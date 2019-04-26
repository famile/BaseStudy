//
//  ViewController.m
//  Test_8_18
//
//  Created by 李涛 on 15/8/18.
//  Copyright (c) 2015年 敲代码的小毛驴. All rights reserved.
//

#import "ViewController.h"

#define WS(ws) __weak typeof(self)ws = self;

//#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *animaView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self animation1];
//    [self animation2];
//    [self animation3];
//    [self animation4];
}

- (void)animation1{
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:2.];
    
    self.animaView.center = CGPointMake(300, 300);
    
    [UIView commitAnimations];
}
/*
 block动画块
 + (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
 
 参数解析:
 
 duration：动画的持续时间
 
 delay：动画延迟delay秒后开始
 
 options：动画的节奏控制
 
 animations：将改变视图属性的代码放在这个block中
 
 completion：动画结束后，会自动调用这个block
 */

/**
 *  平移动画
 */
- (void)animation2{
    
    __weak typeof(self) ws = self;
    
    [UIView animateWithDuration:2. delay:0. options:UIViewAnimationOptionCurveLinear animations:^{
        
        ws.animaView.center = CGPointMake(200, 200);
        
    } completion:^(BOOL finished) {
        
    }];
}

/*
 转场动画
 
 + (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
 
 参数解析:
 
 duration：动画的持续时间
 
 view：需要进行转场动画的视图
 
 options：转场动画的类型
 
 animations：将改变视图属性的代码放在这个block中
 
 completion：动画结束后，会自动调用这个block
 */

/**
 *  转场动画
 */
- (void)animation3{
    WS(ws);
    
    [UIView transitionWithView:self.animaView duration:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
        ws.animaView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:^(BOOL finished) {
        
        
    }];
}
/*
 + (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion
 
 方法调用完毕后，相当于执行了下面两句代码：
 
 // 添加toView到父视图
 
 [fromView.superview addSubview:toView];
 
 // 把fromView从父视图中移除
 
 [fromView.superview removeFromSuperview];
 
 参数解析:
 
 duration：动画的持续时间
 
 options：转场动画的类型
 
 animations：将改变视图属性的代码放在这个block中
 
 completion：动画结束后，会自动调用这个block
 */

- (void)animation4{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 400, 40, 40)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    [UIView transitionFromView:self.animaView toView:view duration:2 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {
        
    }];
}
- (IBAction)animation5:(id)sender {
    NSLog(@"点击了按钮subBtn1");
    
}
- (IBAction)animation6:(id)sender {
    NSLog(@"点击了按钮subBtn2");
    
}


@end
