//
//  ViewController.m
//  Test_8_18
//
//  Created by 李涛 on 15/8/18.
//  Copyright (c) 2015年 敲代码的小毛驴. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IFTTTAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    self.animator = [IFTTTAnimator new];
//alpha
    IFTTTAlphaAnimation *alphaAnimation = [IFTTTAlphaAnimation animationWithView:view];
//    [alphaAnimation addKeyframeForTime:30 alpha:1.f];
    [alphaAnimation addKeyframeForTime:60 alpha:0.f];
    [alphaAnimation addKeyframeForTime:30 alpha:1.f withEasingFunction:^CGFloat(CGFloat t) {
        NSLog(@"%f",t);
        return t;
    }];
    [self.animator addAnimation:alphaAnimation];
//背景颜色
    IFTTTBackgroundColorAnimation *backgroundColorAnimation = [IFTTTBackgroundColorAnimation animationWithView:view];
    [backgroundColorAnimation addKeyframeForTime:30 color:[UIColor redColor]];
    [backgroundColorAnimation addKeyframeForTime:60 color:[UIColor blueColor]];
    [self.animator addAnimation:backgroundColorAnimation];
    
//旋转
    IFTTTRotationAnimation *rotationAnimation = [IFTTTRotationAnimation animationWithView:view];
    [rotationAnimation addKeyframeForTime:30 rotation:0];
    [rotationAnimation addKeyframeForTime:60 rotation:90];
    [self.animator addAnimation:rotationAnimation];
    
//
    IFTTTFrameAnimation *frameAnimation = [IFTTTFrameAnimation animationWithView:view];
    [frameAnimation addKeyframeForTime:30 frame:CGRectMake(50, 50, 50, 50)];
    [frameAnimation addKeyframeForTime:60 frame:CGRectMake(100, 100, 100, 100)];
    [self.animator addAnimation:frameAnimation];
    
    
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 150, 100, 100)];
    slider.minimumValue = 30;
    slider.maximumValue = 60;
    [slider addTarget:self action:@selector(changeValue:) forControlEvents:(UIControlEventValueChanged)];
    
    
    
    [self.view addSubview:slider];
    
    
}


- (void)changeValue:(UISlider *)slider{
    [self.animator animate:slider.value];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
