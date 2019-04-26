//
//  TestSuperView.m
//  Test_8_18
//
//  Created by 李涛 on 2018/3/4.
//  Copyright © 2018年 敲代码的小毛驴. All rights reserved.
//

#import "TestSuperView.h"

@implementation TestSuperView


- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event{
    BOOL res = [super pointInside:point withEvent:event];
    return YES;
}

@end
