//
//  CropView.m
//  Test_8_18
//
//  Created by 李涛 on 15/12/14.
//  Copyright © 2015年 敲代码的小毛驴. All rights reserved.
//

#import "CropView.h"

@implementation CropView

- (void)drawRect:(CGRect)rect{
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
//    [[UIColor redColor] setFill];
    
    CGContextAddEllipseInRect(ref, CGRectMake(100, 100, 50, 50));
    
    //指定上下文中可以显示内容的范围就是圆的范围
    CGContextClip(ref);
    
//    CGContextFillPath(ref);
    
    UIImage *image = [UIImage imageNamed:@"u=1217182835,856986414&fm=21&gp=0.jpg"];
    
    [image drawAtPoint:CGPointMake(100, 100)];
    
}

@end
