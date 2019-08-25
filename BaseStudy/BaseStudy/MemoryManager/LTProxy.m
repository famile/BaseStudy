//
//  LTProxy.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/20.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "LTProxy.h"

@implementation LTProxy

+ (instancetype)initWithTarget:(id)target {
    LTProxy *proxy = [[LTProxy alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _target;
}

@end
