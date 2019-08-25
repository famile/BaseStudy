//
//  MutexDemo.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/19.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "MutexDemo.h"
#import <pthread.h>
@interface MutexDemo ()

@property (nonatomic, assign) pthread_mutex_t tickedMutex;
@property (nonatomic, assign) pthread_mutex_t moneyMutex;
@end

@implementation MutexDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 静态初始化
//        pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
        [self __initLockWithMutex:&_tickedMutex];
        [self __initLockWithMutex:&_moneyMutex];
    }
    return self;
}

- (void)__initLockWithMutex:(pthread_mutex_t *)mutex {
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    pthread_mutex_init(mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}

- (void)__saleTicket {
    pthread_mutex_lock(&_tickedMutex);
    [super __saleTicket];
    pthread_mutex_unlock(&_tickedMutex);
}

- (void)__saveMoney {
    pthread_mutex_lock(&_moneyMutex);
    [super __saveMoney];
    pthread_mutex_unlock(&_moneyMutex);
}

- (void)__drawMoney {
    pthread_mutex_lock(&_moneyMutex);
    [super __drawMoney];
    pthread_mutex_unlock(&_moneyMutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&_moneyMutex);
    pthread_mutex_destroy(&_tickedMutex);
}

@end
