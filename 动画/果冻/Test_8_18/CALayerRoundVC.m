//
//  CALayerRoundVC.m
//  Test_8_18
//
//  Created by 李涛 on 16/3/7.
//  Copyright © 2016年 敲代码的小毛驴. All rights reserved.
//

#import "CALayerRoundVC.h"

@interface CALayerRoundVC ()

{
    CAShapeLayer *layer;
}

@end

@implementation CALayerRoundVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:showView];
    showView.backgroundColor = [UIColor redColor];
    showView.alpha = 0.5;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100/2.f, 100/2.f) radius:100/2.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    layer = [CAShapeLayer layer];
    layer.frame = showView.bounds;
    //边缘线的颜色
    layer.strokeColor = [UIColor greenColor].CGColor;
    //闭环填充的颜色
    layer.fillColor = [UIColor clearColor].CGColor;
    //边缘线的类型
    layer.lineCap = kCALineCapSquare;
    //从贝塞尔曲线获取到形状
    layer.path = path.CGPath;
    
    //    layer.lineWidth = 1.0f;
    
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.fromValue = @0;
    pathAnimation.toValue = @1;
    pathAnimation.repeatCount = 4;
    [layer addAnimation:pathAnimation forKey:nil];
    
    [showView.layer addSublayer:layer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
