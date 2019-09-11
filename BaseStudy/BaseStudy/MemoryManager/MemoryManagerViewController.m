//
//  MemoryManagerViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/20.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "MemoryManagerViewController.h"
#import "LTProxy.h"
#import "LTTimer.h"
@interface MemoryManagerViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) dispatch_source_t gcdTimer;

@end

@implementation MemoryManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // NSTimer内存泄露
//    [self timerMemoryLeak];
    
    // 创建gcd定时器
//    [self createGcdTimer];
    
//    [LTTimer execTask:^{
//        NSLog(@"1234");
//    } start:1 interval:1 repeats:YES async:NO];
    
//    [LTTimer execTask:self selector:@selector(timerTest) start:1 interval:1 repeats:YES async:YES];
    
    /*
     低  保留
     |   代码段
     高  数据段（
            字符串常量 NSString *str = @"123"，
            已初始化数据 已初始化的全局变量，静态变量
            未初始化数据）未初始化的全局变量，静态变量
        堆（heap）
        栈(stack 由高到低分配)函数调用开销 比如局部变量，分配的内存地址越来越小
        内核区
     */
    
    /*
     引用计数
     copy: 产生一个副本对象，跟原对象互不影响
     深copy：内容copy
     浅copy：指针copy
     */
    
    /*
     autorelease对象在什么时机会被释放
     如果有autoreleasepool{} 在大括号结束的时候释放
      是由runloop来控制的，可能是在某次循环进入睡眠或者退出的时候释放
     
     如果是autorelease对象，会在runloop循环后释放
     如果不是会在方法结束后释放
     */
    
    /*
     卡顿的原因：
     cpu计算，gpu渲染 Vsync(垂直同步信号)
     卡顿的解决思路：尽可能减少CPU,GPU资源消耗
     CPU优化：
         尽量用轻量级的对象，比如用不到实物处理的地方，可以考虑CALayer取代UIView
         不要频繁的调用UIView的相关属性，比如frame，bounds，transform等属性，尽量减少不必要的修改
         尽量提前计算好布局，在有需要时一次性调整对应的属性，不要多次修改属性
         autolayout会比直接设置frame消耗更多的cpu资源
         图片的size最好刚好跟UIImageView的size保持一致
         控制一下线程的最大并发数量
         尽量把耗时的操作放到子线程
            文本处理（尺寸计算，绘制）
            图片处理（解码，绘制）
     GPU优化：
        尽量减少视图数量和层次
        尽量避免短时间内大量图片的显示，尽可能将多张图片合成一张进行显示
        GPU能处理的最大文理尺寸4096x4096，一旦超过这个尺寸，就会占用CPU资源进行处理，所以纹理尽量不要超过这个尺寸
        减少透明的视图（alpha<1）不透明的就设置opaque为YES
        尽量避免离屏渲染
     */
}


#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method
- (void)timerMemoryLeak {
//    __weak typeof(self) ws = self;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [ws test];
//    }];
    // timer对self强引用，self对timer强引用造成循环引用
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[LTProxy initWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
}

- (void)timerTest {
    NSLog(@"开始任务%s", __func__);
}

/**
 gcd定时器
 */
- (void)createGcdTimer {
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    uint64_t start = 2.0; // 两秒后开始执行
    uint64_t interval = 1.0; // 间隔1秒执行
    // 设置时间
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        [self timerTest];
    });
    
    dispatch_source_set_event_handler_f(timer, timerFire);
    
    // 启动定时器
    dispatch_resume(timer);
    _gcdTimer = timer;
}

#pragma mark - setter

#pragma mark - init

- (void)dealloc {
    [self.timer invalidate];
    NSLog(@"%s", __func__);
    
}

void timerFire(void * params) {
    NSLog(@"222");
}

@end


