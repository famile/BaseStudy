//
//  CustomView.m
//  Test_8_18
//
//  Created by 李涛 on 15/12/14.
//  Copyright © 2015年 敲代码的小毛驴. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/**
 *  当自定义view第一次显示出来的时候就会调用drawRect方法
 */
 - (void)drawRect:(CGRect)rect{
    
     //1.取得和当前视图相关联的图形上下文（因为图形上下文决定绘制的输出目标）
     // 如果在drawRect方法中调用UIGraphicsGetCurrentContext方法 获取出来的就是Layer的上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     
     //2、绘图（绘制直线），保存绘图信息
     //设置起点
     CGContextMoveToPoint(ctx, 20, 100);
     
     //设置终点
     CGContextAddLineToPoint(ctx, 300, 100);
     
     //设置绘图的状态
     //设置线条的颜色为蓝色
     CGContextSetRGBStrokeColor(ctx, 0, 1.0, 0, 1.0);
     
     //设置线条的宽度
     CGContextSetLineWidth(ctx, 15);
     
     //设置线条的起点和终点的样式为圆角
     CGContextSetLineCap(ctx, kCGLineCapRound);
     
     //设置线条的转角的样式为圆角
     CGContextSetLineJoin(ctx, kCGLineJoinRound);
     
     //3、渲染（绘制出一条空心的线）
     CGContextStrokePath(ctx);
     
     //注意线条不能渲染为实心的
//     CGContextFillPath(ctx);
     
     CGContextRef ctr = UIGraphicsGetCurrentContext();
     
     CGContextMoveToPoint(ctr, 150, 40);
     
     CGContextAddLineToPoint(ctr, 150, 200);
     
//     CGContextSetRGBStrokeColor(<#CGContextRef  _Nullable c#>, <#CGFloat red#>, <#CGFloat green#>, <#CGFloat blue#>, <#CGFloat alpha#>)
     
     //第二种设置颜色的方法
     [[UIColor grayColor] set];
     
     CGContextSetLineWidth(ctr, 15);
     
     //设置线条的起点和终点的样式
     CGContextSetLineCap(ctr, kCGLineCapRound);
     
     CGContextStrokePath(ctr);
     
     /**
      *  绘制三角形
      */
     
     CGContextRef ctr1 = UIGraphicsGetCurrentContext();
     
     CGContextMoveToPoint(ctr1, 50, 200);
     
     CGContextAddLineToPoint(ctr1, 150, 170);
     
     CGContextAddLineToPoint(ctr1, 100, 230);
     
     CGContextSetLineWidth(ctr1, 5);
     
     //关闭起点和终点
     CGContextClosePath(ctr1);
     
     CGContextStrokePath(ctr1);
     
     /**
      *  绘制四边形
      */
     CGContextRef ref = UIGraphicsGetCurrentContext();
     
     CGContextAddRect(ref, CGRectMake(10, 400, 200, 50));
     
     [[UIColor purpleColor] setFill];
     
     [[UIColor redColor] setStroke];
     
//     [[UIColor greenColor] set];
     //空心
     CGContextStrokePath(ref);
     
     //实心
//     CGContextFillPath(ref);
     
     /**
      *  画圆
      */
     CGContextRef ref1 = UIGraphicsGetCurrentContext();
     
     CGContextAddArc(ref1, 250, 250, 50, 0, 2*M_PI, 0);
     
     CGContextStrokePath(ref1);
     
     //第二种
     CGContextAddEllipseInRect(ref1, CGRectMake(250, 350, 50, 50));
     
     CGContextStrokePath(ref1);
     
     /**
      *  画圆弧
      */
     
     CGContextRef ref2 = UIGraphicsGetCurrentContext();
     /**
      *  x/y圆心
      *  radius 半径
        startAngle 开始的弧度
        endAngle 结束的弧度
        clockwise 画圆弧的方向（0-顺时针，1-逆时针）
      */
     CGContextAddArc(ref2, 280, 500, 20, 0, M_PI, 0);
     
     CGContextClosePath(ref2);
     
     CGContextFillPath(ref2);
     
     /**
      *  画饼状图
      */
     CGContextRef ref3 = UIGraphicsGetCurrentContext();
     
     CGContextMoveToPoint(ref3, 150, 250);
     
     CGContextAddLineToPoint(ref3, 150, 300);
     
     CGContextAddArc(ref3, 150, 250, 50, M_PI_2, M_PI, 0);
     
     CGContextClosePath(ref3);
     
//     CGContextFillPath(ref3);
     
     CGContextStrokePath(ref3);
}

@end
