//
//  NSLockDemo.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/20.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()

@property (nonatomic, strong) NSLock *ticketLock;
@property (nonatomic, strong) NSLock *moneyLock;

@end

@implementation NSLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ticketLock = [[NSLock alloc] init];
        self.moneyLock = [[NSLock alloc] init];
    }
    return self;
}

- (void)__saveMoney {
    
    [_moneyLock lock];
    [super __saveMoney];
    [_moneyLock unlock];
}

- (void)__drawMoney {
    [_moneyLock lock];
    [super __drawMoney];
    [_moneyLock unlock];
}

- (void)__saleTicket {
    [_ticketLock lock];
    [super __saleTicket];
    [_ticketLock unlock];
}

@end
