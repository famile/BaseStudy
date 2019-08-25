//
//  LTSpinLockDemo.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/19.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "LTSpinLockDemo.h"
#import <libkern/OSAtomic.h>
@interface LTSpinLockDemo ()

@property (nonatomic, assign) OSSpinLock lock;
@property (nonatomic, assign) OSSpinLock lock1;

@end

@implementation LTSpinLockDemo

- (instancetype)init {
    if (self = [super init]) {
        self.lock = OS_SPINLOCK_INIT;
        self.lock1 = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)__drawMoney {
    OSSpinLockLock(&_lock);
    [super __drawMoney];
    OSSpinLockUnlock(&_lock);
}

- (void)__saveMoney {
    OSSpinLockLock(&_lock);
    [super __saveMoney];
    OSSpinLockUnlock(&_lock);
}

- (void)__saleTicket {
    OSSpinLockLock(&_lock1);
    [super __saleTicket];
    OSSpinLockUnlock(&_lock1);
}

@end
