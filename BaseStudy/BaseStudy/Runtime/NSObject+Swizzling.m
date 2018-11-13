//
//  NSObject+Swizzling.m
//  BaseStudy
//
//  Created by 李涛 on 2018/11/9.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector{
    
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(class, swizzledSelector);
    
    //class_addMethod: 实现会覆盖分类的方法实现，但不会取代本类中已存在的实现，
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        //如果类中不存在name指定的方法，则类似于class_addMethod函数一样会添加方法，如果类中已存在name指定的方法，则类似于method_setImplementation一样代替原方法的实现
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

@end
