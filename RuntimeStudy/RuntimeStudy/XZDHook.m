//
//  XZDHook.m
//  RuntimeStudy
//
//  Created by 李涛 on 2019/5/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "XZDHook.h"
#import <objc/runtime.h>

@implementation XZDHook

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector{
    Class class = classObject;
    // 得到被替换类的实例方法
    Method fromMethod = class_getInstanceMethod(class, fromSelector);
    // 得到替换类的实例方法
    Method toMethod = class_getInstanceMethod(class, toSelector);
    // class_addMethod 返回成功表示被替换的方法没实现，然后会通过class_addMethod方法先实现，返回失败表示被替换的方法已经存在，可以直接IMP指针交换
    if(class_addMethod(class, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        class_replaceMethod(class, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    } else {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

@end
