
//
//  RotationView.m
//  Test_8_18
//
//  Created by 李涛 on 15/12/14.
//  Copyright © 2015年 敲代码的小毛驴. All rights reserved.
//

#import "RotationView.h"

@implementation RotationView

- (void)drawRect:(CGRect)rect{
    
    
    /**
     *  在旋转的时候，其实整个view的layer都旋转了
     */
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextRotateCTM(ref, M_PI_4);
    
    //注意点：设置矩阵操作必须要在添加绘图信息之前
    //缩放，x方向缩放0.5倍，y方向缩放1.5倍
    //CGContextScaleCTM(ref, 0.5, 0.5);

    //平移
    //CGContextTranslateCTM(ref, 50, 100);
    
    CGContextAddRect(ref, CGRectMake(250, 100, 50, 50));
    
    CGContextStrokePath(ref);
    
    
    
}

@end
