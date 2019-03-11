//
//  UIViewController+test.m
//  GCDDemo
//
//  Created by 李涛 on 2018/7/3.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "UIViewController+test.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>


static void *nameKey = &nameKey;

@implementation UIViewController (test)

//@dynamic name;

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


+ (void)load{
    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
}

+ (void)initialize{
    
}

- (void)swizzled_viewDidAppear:(BOOL)animated
{
    // call original implementation
    [self swizzled_viewDidAppear:animated];
    
    // Logging
//    [Logging logWithEventName:NSStringFromClass([self class])];
    
    NSLog(@"哈哈，添加成功");
}


- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name{
    return objc_getAssociatedObject(self, nameKey);
}


@end
