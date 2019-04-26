//
//  CustomViewController.m
//  Test_8_18
//
//  Created by 李涛 on 15/12/10.
//  Copyright © 2015年 敲代码的小毛驴. All rights reserved.
//

#import "CustomViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
typedef enum : NSUInteger {
    RotationStateStop,
    RotationRunning,
} RotationState;

@interface CustomViewController ()
{
    /**
     *  旋转角度
     */
    CGFloat imageViewAngle;
    /**
     * 旋转的view
     */
    UIImageView *imageView;
    /**
     *  旋转状态
     */
    RotationState rotationState;
    
    /**
     *  帧动画图片数组
     */
    NSMutableArray *animationArray;
}


@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"微信公众账号";
    NSArray *imgNameArr = @[@"1",@"2",@"3",@"4",@"5"];
    animationArray = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        [animationArray addObject:[UIImage imageNamed:imgNameArr[i]]];
    }
    
    
    [self buildBarButtonItem];
}

- (void)buildBarButtonItem{
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectstar"]];
    
    imageView.autoresizingMask = UIViewAutoresizingNone;
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.bounds = CGRectMake(0, 0, 40, 40);
    
//    imageView.layer.masksToBounds=YES;
//
//    imageView.layer.cornerRadius=20;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 40, 40);
    
    [button addTarget:self action:@selector(animate) forControlEvents:(UIControlEventTouchUpInside)];
    
    [button addSubview:imageView];
    
    imageView.center = button.center;
    
    //设置RightBarButtonItem
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)animate {
    
    //改变ImageView旋转状态
    
    if (rotationState==RotationStateStop) {
        
        rotationState=RotationRunning;
        
        [self rotateAnimate];
        
    }else{
        
        rotationState=RotationStateStop;
        
    }
}

- (void)rotateAnimate{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    imageViewAngle += 45;
    //0.5秒旋转45°
    
//    [UIView animateWithDuration:0.5 animations:^{
//        imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(imageViewAngle));
//        if (rotationState == RotationRunning) {
//            [self rotateAnimate];
//        }
//                                                            
//    }];
//    [UIView animateWithDuration:0.5 animations:^{
//        imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(imageViewAngle));
//    } completion:^(BOOL finished) {
//        if (rotationState == RotationRunning) {
//            
//            [self rotateAnimate];
//        }
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//    }];
    
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(imageViewAngle));
        
    } completion:^(BOOL finished) {
        
        if (rotationState == RotationRunning) {
            
            [self rotateAnimate];
        }
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

@end
