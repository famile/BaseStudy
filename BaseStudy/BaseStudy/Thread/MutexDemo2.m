//
//  MutexDemo2.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/19.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "MutexDemo2.h"
#import <pthread.h>

@interface MutexDemo2 ()

@property (nonatomic, assign) pthread_mutex_t mutex;
@property (nonatomic, assign) pthread_mutex_t mutex2;
@property (nonatomic, assign) pthread_cond_t cond;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation MutexDemo2

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 静态初始化
        //        pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
        [self __initLockWithMutex:&_mutex];
        [self __initLockWithMutex:&_mutex2];
        pthread_cond_init(&_cond, NULL);
        self.data = [NSMutableArray array];
        
    }
    return self;
}

- (void)__initLockWithMutex:(pthread_mutex_t *)mutex {
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    // 递归锁： 允许同一个线程对一个锁重复加锁
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    // 初始化锁
    pthread_mutex_init(mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}

- (void)otherTest { 
    static int count = 0;
    pthread_mutex_lock(&_mutex);
    if (count < 10) {
        [self otherTest];
        NSLog(@"执行任务");
        count += 1;
    }
    pthread_mutex_unlock(&_mutex);
}

- (void)otherTest2 {
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    sleep(2);
    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
    
}

- (void)__remove {
    pthread_mutex_lock(&_mutex2);
    if (self.data.count == 0) {
        // 等待
        pthread_cond_wait(&_cond, &_mutex2);
    }
    [self.data removeLastObject];
    NSLog(@"删除元素");
    pthread_mutex_unlock(&_mutex2);
}


- (void)__add {
    pthread_mutex_lock(&_mutex2);
    [self.data addObject:@"Test"];
    NSLog(@"添加元素");
    // 发信号
    pthread_cond_signal(&_cond);
    pthread_mutex_unlock(&_mutex2);
}


- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
    pthread_mutex_destroy(&_mutex2);
    pthread_cond_destroy(&_cond);
}

@end
