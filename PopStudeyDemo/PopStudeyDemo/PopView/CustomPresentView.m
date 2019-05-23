//
//  CustomPresentView.m
//  Formwork
//
//  Created by 李涛 on 16/10/20.
//  Copyright © 2016年 Tao_Lee. All rights reserved.
//

#import "CustomPresentView.h"
#import <POP/POP.h>

#define ScreenWidth      [UIScreen mainScreen].bounds.size.width
#define ScreenHeight      [UIScreen mainScreen].bounds.size.height
@interface CustomPresentView ()

@property (nonatomic, strong) UIControl *overControl;


@end

@implementation CustomPresentView

- (void)show{
    self.backgroundColor = [UIColor redColor];
    self.overControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [_overControl addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
    _overControl.backgroundColor = [UIColor clearColor];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.overControl];
    [window addSubview:self];
    
    POPSpringAnimation *springAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAnim.springBounciness = 10.f;
    springAnim.springSpeed = 25.f;
    springAnim.fromValue = [NSValue valueWithCGRect:CGRectMake(0, -300, ScreenWidth, 300)];
    springAnim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, ScreenWidth, 300)];
    [self pop_addAnimation:springAnim forKey:@"scaleAnimation"];
    
    
    POPSpringAnimation *opacityAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnim.fromValue = @(0.3);
    opacityAnim.toValue = @(1.f);
    [self.layer pop_addAnimation:opacityAnim forKey:@"opacityAnimation"];
    
    
//    POPSpringAnimation *rotationAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
//    rotationAnim.fromValue = @(-M_PI/8);
//    rotationAnim.toValue = @(0);
//    [self.layer pop_addAnimation:rotationAnim forKey:@"rotationAnimation"];
    
    
//    POPSpringAnimation *springAnim2 = [POPSpringAnimation animationWithPropertyNamed:];
    
    
}
- (void)dismiss{
    
//    POPSpringAnimation *springAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
//    springAnim.springBounciness = 10;
//    springAnim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, ScreenWidth, 300)];
//    [self.layer pop_addAnimation:springAnim forKey:@"scaleAnimation"];
    
    
    POPSpringAnimation *springAnim2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAnim2.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, ScreenWidth, 300)];
    springAnim2.toValue = [NSValue valueWithCGRect:CGRectMake(0, -300, ScreenWidth, 300)];
    [self.layer pop_addAnimation:springAnim2 forKey:@"scaleAnimation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.overControl removeFromSuperview];
        [self removeFromSuperview];
    });
}

@end
