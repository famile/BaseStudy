//
//  ViewDrawStudyViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2018/11/6.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "ViewDrawStudyViewController.h"

@interface ViewDrawStudyViewController ()

@end

@implementation ViewDrawStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     先从runloop说起，iOS的mainRunloop是一个60fps的回调，也就是没16.7ms就会绘制一次屏幕，在这段时间内：
     要完成view的缓冲区的创建，view的内容的绘制（重写了drawRect方法）这些CPU的工作。
     然后将这个缓冲区交给GPUc渲染，这个过程又包括多个View的拼接（compositing），纹理的渲染（Texture）等，最终显示在屏幕上。
     因此，如果在16.7ms内完不成这些操作，比如CPU做了太多的计算，或者view层次过多，图片过大，导致GPU压力太大，就导致“卡”的现象。
     
     
     View从绘制到Render的过程：
     每一个view都有一个layer，每一个layer都有个content，这个content指向的是一块缓存，叫做backing store
     view的绘制和渲染是两个过程，当view被绘制时，CPU执行drawRect，通过context将数据写入backing store
     当backing store写完后，通过render server交给GPU去渲染，将backing store中的bitmap数据显示在屏幕上
     
     */
    
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 300, 14)];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.text = @"test";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    /*
     
     https://www.jianshu.com/p/dc5442dce3b9
     当一个新的Runloop到来，上面说道在这个Runloop中需要将界面渲染上去，对于UIKit的渲染，Apple用的是它的Core Animation
     
     
     
     在Runloop开始的时候调用
     [CATransaction begin]
     
     在Runloop结束的时候调用
     [CATransaction commit]
     在begin和commit之间做的事情是将view增加到 view hierarchy中，这个时候也不会发生任何绘制的操作
     当[CATransaction commit]执行完后，CPU开始绘制这个view
     
     首先CPU会为layer分配一块内存用来绘制bitmap，叫做backing store
     创建指向这块bitmap缓冲区的指针，叫做CGContextRef
     通过Core Graphic的API 也叫Quartz2D，绘制bitmap
     将layer的content指向生成的bitmap
     清空dirty flag标记
     
     这样CPU的绘制基本上就完成了
     
     Running Time Self Symbol Name
     2.0ms 1.2% 0.0 +[CATransaction flush]
     2.0ms 1.2% 0.0 CA::Transaction::commit()
     2.0ms 1.2% 0.0 CA::Context::commit_transaction(CA::Transaction*)
     1.0ms 0.6% 0.0 CA::Layer::layout_and_display_if_needed(CA::Transaction*)
     1.0ms 0.6% 0.0 CA::Layer::display_if_needed(CA::Transaction*)
     1.0ms 0.6% 0.0 -[CALayer display]
     1.0ms 0.6% 0.0 CA::Layer::display()
     1.0ms 0.6% 0.0 -[CALayer _display]
     1.0ms 0.6% 0.0 CA::Layer::display_()
     1.0ms 0.6% 0.0 CABackingStoreUpdate_
     1.0ms 0.6% 0.0 backing_callback(CGContext*, void*)
     1.0ms 0.6% 0.0 -[CALayer drawInContext:]
     1.0ms 0.6% 0.0 -[UIView(CALayerDelegate) drawLayer:inContext:]
     1.0ms 0.6% 0.0 -[UILabel drawRect:]
     1.0ms 0.6% 0.0 -[UILabel drawTextInRect:]
     
     如果某个时刻修改了label的text
     由于内容变了，layer的content的bitmap的尺寸也要变化，所以这个时候当新的Runloop到来时，CPU要为layer重新创建一个backing store，重新绘制bitmap
     CPU这一块最耗时的地方往往是Core Graphic的绘制上，关于Core Graphic的性能优化是y另一个话题了，
     
     GPU bound：
     CPU完成了任务，将View变成了bitmap，然后是GPU的工作，GPU的处理单位是Texture
     基本上GPU都是通过OpenGL来完成的，但是从bitmap到Texture之间需要一座桥梁，Core Animation正好充当了这个角色
     Core Animation对OpenGL的API有一层封装，当我们要渲染的layeri已经有bitmap content的时候，这个content一般来说是一个CGImageRef，CoreAnimation会创建一个OpenGL的Texture并将CGImageRef(bitmap)和这个Texture绑定，通过TextureID来标识。
     
     整个过程就是一件事：CPU将准备好的bitmap放到RAM里，GPU去搬这块内存到VRAM中处理
     这个过程GPU所能承受的极限就是16.7ms完成一帧的处理，所以最开始提到的60fps就是GPU能处理的最高频率
     GPU的挑战：
     1.将数据从RAM搬到VRAM中
     2.将Texture渲染到屏幕上
     这个过程的瓶颈在第二点，渲染Texture基本要处理这么几个点：
     
     Compositing:
     Compositing是指将多个纹理拼到一起的过程，对应UIKit，是指处理多个view合到一起的情况
     [self.view addsubview:subview];
     如果view之间没有叠加，那么GPU只需要做普通渲染即可，如果多个view有叠加部分，GPU就需要做blending
     
     R = S+D*(1-Sa)
     R: 为最终的像素值
     
     S: 代表 上面的Texture（Top Texture）
     
     D: 代表下面的Texture(lower Texture)
     
     其中S,D都已经pre-multiplied各自的alpha值。
     
     Sa代表Texture的alpha值。
     
     假如Top Texture（上层view）的alpha值为1，即不透明。那么它会遮住下层的Texture。即,R = S。是合理的。 假如Top Texture（上层view）的alpha值为0.5，S 为 (1,0,0)，乘以alpha后为(0.5,0,0）。D为(0，0，1)。 得到的R为（0.5，0，0.5）。
     基本上每个像素点都需要这么计算一次。
     
     因此，view的层级很复杂，或者view都是半透明的（alpha值不为1）都会带来GPU额外的计算工作
     
     size：
     这个问题，主要是处理image带来的，假如内存里有一张400x400的图片，要放到100x100的imageview里，如果不做任何处理，直接丢进去，问题就大了，这意味着，GPU需要对大图进行缩放到小的区域显示，需要做像素点的sampling，这种smapling的代价很高，又需要兼顾pixel alignment。计算量会飙升。
     
     
     Offscreen Rendering And Mask：
     如果我们对layer做这样的操作：
     label.layer.cornerRadius = 5.0f;
     label.layer.masksToBounds = YES;
     
     会产生offscreen rendering,它带来的最大的问题是，当渲染这样的layer的时候，需要额外开辟内存，绘制好radius，mask，然后再将绘制好的bitmap重新赋值给layer。
     
     因此继续性能的考虑，Quartz提供了优化的api：
     label.layer.cornerRadius = 5.0f;
     label.layer.masksToBounds = YES;
     label.layer.shouldRasterize = YES;
     label.layer.rasterizationScale = label.layer.contentsScale;
     
     简单的说，这是一种cache机制。
     
     同样GPU的性能也可以通过instrument去衡量：
     红色代表GPU需要做额外的工作来渲染View，绿色代表GPU无需做额外的工作来处理bitmap。
     
     */
}


#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method

#pragma mark - setter

#pragma mark - init



@end
