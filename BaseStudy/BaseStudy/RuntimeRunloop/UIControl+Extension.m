//
//  UIControl+Extension.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "UIControl+Extension.h"
#import <objc/runtime.h>

@implementation UIControl (Extension)

+ (void)load {
    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method method2 = class_getInstanceMethod(self, @selector(mj_sendAction:to:forEvent:));
    method_exchangeImplementations(method1, method2);
}

- (void)mj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSLog(@"%@---%@---%@",self,target,NSStringFromSelector(action));
    if ([self isKindOfClass:[UIButton class]]) {
        // 拦截所有按钮
    } else {
        
    }
    [self mj_sendAction:action to:target forEvent:event];
}

@end
