//
//  ViewController.m
//  LayerDemo
//
//  Created by 李涛 on 2017/3/24.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CALayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addLayer1];
    [self addLayer2];
    
    
}


- (UIButton *)customButton
{
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
}


#pragma mark - CALayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}


- (void)addLayer1{
    self.view.backgroundColor = [UIColor grayColor];
    UIView *bgView = [[UIView alloc] initWithFrame:(CGRectMake(100, 100, 100, 100))];
    [self.view addSubview:bgView];
    
    
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
//    [self.view.layer addSublayer:layer];
    
    UIImage *image = [UIImage imageNamed:@"test"];
    layer.contents = (__bridge id)(image.CGImage);
    //    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsGravity = kCAGravityCenter;
    layer.contentsScale = [UIScreen mainScreen].scale;
    //    layer.contentsScale = image.scale;
    layer.masksToBounds = YES;
    
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    //scale by 50%
//    transform = CGAffineTransformScale(transform, 0.5, 0.5);
//    //rotate by 30 degrees
//    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
//    //translate by 200 points
//    transform = CGAffineTransformTranslate(transform, 200, 0);
//    [UIView animateWithDuration:1 animations:^{
//        layer.affineTransform = transform;
//    }];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//    layer.transform = transform;
    
    bgView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    bgView.layer.transform = transform;
    
}

- (void)addLayer2{
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.delegate = self;
    layer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:layer];
    [layer display];
    
}

- (void)addLayer3{
    self.view.backgroundColor = [UIColor grayColor];
    
    //create opaque button
    UIButton *button1 = [self customButton];
    //    button1.alpha = 0.5;
    button1.center = CGPointMake(50, 150);
    [self.view addSubview:button1];
    
    //create translucent button
    UIButton *button2 = [self customButton];
    
    button2.center = CGPointMake(250, 150);
    button2.alpha = 0.5;
    [self.view addSubview:button2];
    
    //enable rasterization for the translucent button
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


@end
