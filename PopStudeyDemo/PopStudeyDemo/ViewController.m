//
//  ViewController.m
//  PopStudeyDemo
//
//  Created by 李涛 on 2017/5/8.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
#import <POP.h>
#import "PopScaleButton.h"
#import "CustomPresentView.h"
#import <Lottie/Lottie.h>

@interface ViewController ()

@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) UILabel *animationLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addBtn];
    [self addView];
    [self addLabel];
}

- (void)addLabel{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 40, 25)];
    label.backgroundColor = [UIColor blueColor];
    _animationLabel = label;
    [self.view addSubview:label];
}

- (void)addView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    _animationView = view;
}

- (void)addBtn{
    
    PopScaleButton *button = [PopScaleButton button];
    [button addTarget:self action:@selector(touchUpInside:) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(0, 0, 50, 30);
    button.center = self.view.center;
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
}

- (void)touchUpInside:(UIButton *)btn{
    [btn setTitle:@"test" forState:(UIControlStateNormal)];
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.fromValue = @(1.0);
    anim.toValue = @(0.5f);
    [_animationView pop_addAnimation:anim forKey:@"fade"];
    
    POPSpringAnimation *springAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
    springAnim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 60)];
    springAnim.springBounciness = 30.f;
    [_animationView pop_addAnimation:springAnim forKey:@"size"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        POPSpringAnimation *springAnim2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
        springAnim2.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 30)];
        springAnim.springBounciness = 50.f;
        [_animationView pop_addAnimation:springAnim2 forKey:@"size"];
    });
    
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]){
            UILabel *label = (UILabel *)obj;
            label.text = [NSString stringWithFormat:@"%d",(int)values[0]];
        };
        
    }];
    
    POPBasicAnimation *countAnim = [POPBasicAnimation easeInEaseOutAnimation];
    countAnim.property = prop;
    countAnim.fromValue = @(0);
    countAnim.toValue = @(100);
    countAnim.duration = 10;
    [_animationLabel pop_addAnimation:countAnim forKey:@"count"];
    
    
    CustomPresentView *presentView = [[CustomPresentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    [presentView show];
    
}




@end
