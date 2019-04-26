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
    
    //画文字
    NSString *str = @"的额搜风搜分手了粉色发俄双方说法offFF瓦房你F回复F入会费WFH；飞；FN返回WFH；哦发货；F回复；FHISFHSIFH我皮肤好APIFRHi分红AWFHIOF威锋网i";
    
    // 1、获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //2、绘图
    
    //绘制矩形
    
    CGContextAddRect(ref, CGRectMake(50, 50, 100, 100));
    
    CGContextStrokePath(ref);
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    //设置文字颜色
    md[NSForegroundColorAttributeName] = [UIColor redColor];
    
    //设置文字背景颜色
    md[NSBackgroundColorAttributeName] = [UIColor greenColor];
    
    //设置文字大小
    md[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    //将文字绘制到指定点的位置(如果一行装不下会自动换行，当文字超出范围后就不显示)
    [str drawInRect:CGRectMake(50, 50, 100, 100) withAttributes:md];
    
    
    UIImage *img = [UIImage imageNamed:@"videodetailback"];
    
    //利用drawAsPatternInRect 方法绘制图片到layer，是平铺原有图片
    [img drawAsPatternInRect:CGRectMake(150, 50, 100, 100)];
    
    //利用drawInRect，是通过拉伸原有图片
    [img drawInRect:CGRectMake(150, 150, 100, 100)];
    
    [img drawAtPoint:CGPointMake(150, 250)];
    
    
}

@end
