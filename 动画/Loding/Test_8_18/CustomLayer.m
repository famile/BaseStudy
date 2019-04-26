//
//  CustomLayer.m
//  Test_8_18
//
//  Created by 李涛 on 15/12/14.
//  Copyright © 2015年 敲代码的小毛驴. All rights reserved.
//

#import "CustomLayer.h"

@implementation CustomLayer

@dynamic progress;

/**
 *  当progress的值改变的时候，CALayer会标记自己为需要重绘，如果我们重写了drawInContext:方法，系统就会在适当的时候调用drawInContext：重绘Layer
 */
+ (BOOL)needsDisplayForKey:(NSString *)key{
    
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}



@end
