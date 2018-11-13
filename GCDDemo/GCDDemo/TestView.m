//
//  TestView.m
//  GCDDemo
//
//  Created by 李涛 on 2018/7/5.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "TestView.h"

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)test{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
