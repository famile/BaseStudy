//
//  OSUnfairLockDemo.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/19.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>
@interface OSUnfairLockDemo ()

@property (nonatomic, assign) os_unfair_lock lock;
@property (nonatomic, assign) os_unfair_lock lock1;

@end

@implementation OSUnfairLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lock = OS_UNFAIR_LOCK_INIT;
        _lock1 = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}
// 死锁：永远拿不到锁
- (void)__saleTicket{
    os_unfair_lock_lock(&_lock);
    [super __saleTicket];
    os_unfair_lock_unlock(&_lock);
}

- (void)__drawMoney {
    os_unfair_lock_lock(&_lock1);
    [super __drawMoney];
    os_unfair_lock_unlock(&_lock1);
}

- (void)__saveMoney {
    os_unfair_lock_lock(&_lock1);
    [super __saveMoney];
    os_unfair_lock_unlock(&_lock1);
}


@end
