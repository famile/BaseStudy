//
//  LTPerson.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/5.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "LTPerson.h"
#import <objc/runtime.h>
@implementation LTPerson

- (void)dealloc{
    NSLog(@"%s", __func__);
}



- (void)test {
    NSLog(@"%s - name: %@", __func__, _name);
}

- (void)defaultImple {
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(unregisterFunc)) {
        Method defaultMeth = class_getInstanceMethod(self, @selector(defaultImple));
        class_addMethod(self, sel, method_getImplementation(defaultMeth), method_getTypeEncoding(defaultMeth));
    }
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    
    return [super resolveClassMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(unrecognizedFunc)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@0:8"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s",anInvocation.selector);
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
 
    return [super forwardingTargetForSelector:aSelector];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}


@end
