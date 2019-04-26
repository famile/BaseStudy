//
//  ViewController.m
//  Test_8_18
//
//  Created by 李涛 on 15/8/18.
//  Copyright (c) 2015年 敲代码的小毛驴. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) int index;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 1;
    self.iconView.image = [UIImage imageNamed:@"01"];
}



/*
 CAAnimation的子类，用于做转场动画，能够为层提供移出屏幕和移入屏幕的动画效果。iOS比Mac OS X的转场动画效果少一点
 
 UINavigationController就是通过CATransition实现了将控制器的视图推入屏幕的动画效果
 
 属性解析:
 
 type：动画过渡类型
 
 subtype：动画过渡方向
 
 startProgress：动画起点(在整体动画的百分比)
 
 endProgress：动画终点(在整体动画的百分比)
 */

- (IBAction)preOnclick:(id)sender {
    self.index--;
    if (self.index<2) {
        self.index = 5;
    }
    self.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%d.png",self.index]];
    //创建核心动画
    CATransition *ca = [CATransition animation];
    //告诉要执行什么动画
    //设置过渡效果
    ca.type = @"cube";
    //设置动画的过渡方向
    ca.subtype = kCATransitionFromLeft;
    //设置动画的时间
    ca.duration = .4;
    
    [self.iconView.layer addAnimation:ca forKey:nil];
}

- (IBAction)nextOnClick:(id)sender {
    self.index++;
    if (self.index>6) {
        self.index = 1;
    }
    self.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%d.png",self.index]];
    CATransition *transition = [CATransition animation];
    
    transition.duration = .4;
    
    transition.type = @"cube";
    
    transition.subtype = kCATransitionFromRight;
    
    [self.iconView.layer addAnimation:transition forKey:nil];
    
}
- (IBAction)animationGroup:(id)sender {
    //平移
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    anima1.toValue = @(150);
    
    //缩放
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.toValue = @(0.5);
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = @(M_PI_2);
    
    //组动画
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    
    groupAnima.animations = @[anima1,anima2,anima3];
    
    groupAnima.duration = 2;
    
    groupAnima.removedOnCompletion = NO;
    
    groupAnima.fillMode = kCAFillModeForwards;
    
    [self.iconView.layer addAnimation:groupAnima forKey:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
