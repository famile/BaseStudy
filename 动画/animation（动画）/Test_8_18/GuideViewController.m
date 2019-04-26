//
//  GuideViewController.m
//  Test_8_18
//
//  Created by 李涛 on 15/12/10.
//  Copyright © 2015年 敲代码的小毛驴. All rights reserved.
//

#import "GuideViewController.h"

#define ANGLE_ROTATION(angle) ((angle)/180.0*M_PI)

@interface GuideViewController ()
{
    UIView *view;
    CALayer *myLayer;
}
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 30, 30)];
    self.view1.backgroundColor = [UIColor orangeColor];
    self.view1.layer.anchorPoint = CGPointMake(0, 0);
    [self.view addSubview:self.view1];
    
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 30, 30)];
    self.view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.view2];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 40, 60)];
    view.backgroundColor = [UIColor colorWithRed:0.6412 green:0.0 blue:1.0 alpha:1.0];
    [self.view addSubview:view];

    myLayer = [CALayer layer];
    myLayer.frame = CGRectMake(100, 100, 50, 80);
    myLayer.backgroundColor = [UIColor yellowColor].CGColor;
//    myLayer.position = CGPointMake(50, 50);
//    myLayer.anchorPoint = CGPointMake(0, 0);
    myLayer.cornerRadius = 20;
    
    [self.view.layer addSublayer:myLayer];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"stop" forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(270, 50, 50, 30);
    [btn addTarget:self action:@selector(stopAnima) forControlEvents:(UIControlEventTouchUpInside)];
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
    
}

- (void)stopAnima{
    [myLayer removeAnimationForKey:@"huayuan"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self animation1];
//    [self animation2];
//    [self animation3];
//    [self animation4];
//    [self animation5];
//    [self animation6];
    [self animation7]; 
//    [self animation8];
//    [self animation9];
//    [self animation10];
//    [NSTimer scheduledTimerWithTimeInterval:2. target:self selector:@selector(animation11) userInfo:nil repeats:YES];
//    [self animation11];
//    [self animation12];
}

/**
 *  一闪一闪
 */
- (void)animation11{
    
    [UIView animateWithDuration:1. animations:^{
        self.view1.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.view1.alpha = 0.5;
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:1.0 animations:^{
            self.view1.transform = CGAffineTransformIdentity;
            self.view1.alpha = 1;
        } completion:^(BOOL finished) {
            
            
        }];
        
    }];
    
}

- (void)animation1{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    self.view1.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);
    [UIView commitAnimations];
}

- (void)animation2{
    CGAffineTransform tr = CGAffineTransformScale(self.view.transform, 0.5, 0.5);
    [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
        self.view.transform = tr;
    } completion:^(BOOL finished) {
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)animation3{
    CGPoint fromPoint = CGPointMake(100, 200);
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    
    CGPoint toPoint = CGPointMake(300, 300);
    [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x, fromPoint.y)];
    CAKeyframeAnimation *moveAnima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnima.path = movePath.CGPath;
    moveAnima.removedOnCompletion = NO;
    moveAnima.duration = 2;
    [moveAnima setRepeatCount:2];
    [self.view.layer addAnimation:moveAnima forKey:nil];
}
//左右震动
- (void)animation4{
    
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    [keyAn setDuration:1];
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x-5, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x+5, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x-5, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x+5, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x-5, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x+5, view.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y)],
                      nil];
    
//    [keyAn setValues:array];
    keyAn.values = array;
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [keyAn setKeyTimes:times];
    keyAn.keyTimes = times;
    keyAn.repeatCount = LONG_MAX;
    [view.layer addAnimation:keyAn forKey:@"TextAnim"];
}
/**
 *  平移动画
 */
- (void)animation5{
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    /**
     *  告诉系统执行什么样的动画
     */
    anima.keyPath = @"center";
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    /**
     *  动画完成后不删除动画
     */
    anima.removedOnCompletion = NO;
    /**
     *  设置保存动画的最新状态
     */
    anima.fillMode = kCAFillModeForwards;
    /**
     *
     */
    anima.delegate = self;
    
    [myLayer addAnimation:anima forKey:nil];
}
/**
 *  缩放动画
 */
- (void)animation6{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    anima.duration = 2;
    
    anima.removedOnCompletion = NO;
    
    anima.fillMode = kCAFillModeForwards;
    
    [myLayer addAnimation:anima forKey:nil];
}
/**
 *  平移动画
 */
- (void)animation7{
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    anima.duration = 1.;
    
    anima.removedOnCompletion = NO;
    
    anima.fillMode = kCAFillModeForwards;
    
    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 100, 0)];
    
    [myLayer addAnimation:anima forKey:nil];
}
/**
 *  帧动画
 */
- (void)animation8{
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //1.1告诉系统要执行什么动画
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(120, 220)];
    
    
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
    keyAnima.values=@[value1,value2,value3];
    
    keyAnima.removedOnCompletion = NO;
    
    keyAnima.fillMode = kCAFillModeForwards;
    
    keyAnima.duration = 2;
    
    keyAnima.repeatCount = 10;
    
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.view1.layer addAnimation:keyAnima forKey:nil];
}
/**
 *  画圆
 */
- (void)animation9{
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //创建一条路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置一条圆的路径
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, 100, 100));
    
    keyAnima.path = path;
    //有creat就有release
    CGPathRelease(path);
    
    keyAnima.removedOnCompletion = NO;
    
    keyAnima.fillMode = kCAFillModeForwards;
    
    keyAnima.duration = 3;
    
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [myLayer addAnimation:keyAnima forKey:@"huayuan"];
    
}
/**
 *  图片抖动
 */
- (void)animation10{
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    keyAnima.duration = 0.1;
    //设置图标抖动弧度
    //把度数转化为弧度 度数/180*M_PI
    keyAnima.values = @[@(-ANGLE_ROTATION(4)),@(ANGLE_ROTATION(4)),@(-ANGLE_ROTATION(4))];
    
//    keyAnima.removedOnCompletion = NO;
    
    keyAnima.fillMode = kCAFillModeForwards;
    
    [myLayer addAnimation:keyAnima forKey:nil];
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}

- (void)animation12{
    
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animationWithKeyPath:@"frame"];
    //1.1告诉系统要执行什么动画
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(120, 220)];
    
    
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
    keyAnima.values=@[value1,value2,value3];
    
    keyAnima.removedOnCompletion = NO;
    
    keyAnima.fillMode = kCAFillModeForwards;
    
    keyAnima.duration = 2;
    
    keyAnima.repeatCount = 10;
    
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.view1.layer addAnimation:keyAnima forKey:nil];
    
    
}

@end
