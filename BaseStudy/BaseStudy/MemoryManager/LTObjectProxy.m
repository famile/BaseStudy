//
//  LTObjectProxy.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/20.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "LTObjectProxy.h"

@implementation LTObjectProxy

+ (instancetype)proxyWithTarget:(id)target {
    LTObjectProxy *proxy = [LTObjectProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
