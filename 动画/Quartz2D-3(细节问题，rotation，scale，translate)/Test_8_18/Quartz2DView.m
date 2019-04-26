
//
//  Quartz2DView.m
//  Test_8_18
//
//  Created by 李涛 on 15/12/14.
//  Copyright © 2015年 敲代码的小毛驴. All rights reserved.
//

#import "Quartz2DView.h"

@implementation Quartz2DView

- (void)drawRect:(CGRect)rect{
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //保存一份最初的上下文
    CGContextSaveGState(ref);
    
    CGContextMoveToPoint(ref, 20, 100);
    
    CGContextAddLineToPoint(ref, 100, 320);
    
    CGContextSetLineWidth(ref, 10);
    
    CGContextSetLineCap(ref, kCGLineCapRound);
    
    [[UIColor purpleColor] set];
    
    CGContextStrokePath(ref);
    
    //还原之前保存的那份上下文
    //注意：在栈里保存了几次，那么就可以取几次（比如不能保存了1次，取两次，在取第二次的时候，栈里为空会直接挂掉）。
    CGContextRestoreGState(ref);
    
    //第二条线
    CGContextMoveToPoint(ref, 40, 200);
    
    CGContextAddLineToPoint(ref, 80, 100);
    
    CGContextStrokePath(ref);
    
    /*
    //如果保存一次取多次就 挂了
    CGContextRestoreGState(ref);
    
    //第二条线
    CGContextMoveToPoint(ref, 40, 200);
    
    CGContextAddLineToPoint(ref, 80, 100);
    
    CGContextStrokePath(ref);
     */
    
//    CGContextRef ref1 = UIGraphicsGetCurrentContext();
//    
//    CGContextRotateCTM(ref1,M_PI_2);
//    
//    CGContextAddRect(ref1, CGRectMake(100, 200, 100, 100));
//    
//    CGContextStrokePath(ref1);
    
    
    
}


@end
