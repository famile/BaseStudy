//
//  RWLockDemo.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/20.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "RWLockDemo.h"
#import <pthread.h>

@interface RWLockDemo ()

@property (nonatomic, assign) pthread_rwlock_t lock;


@end

@implementation RWLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        pthread_rwlock_init(&_lock, NULL);
    }
    return self;
}

- (void)otherTest {
    
    for (int i = 0; i < 10; i++) {
        [[[NSThread alloc] initWithTarget:self selector:@selector(read) object:nil] start];
        [[[NSThread alloc] initWithTarget:self selector:@selector(write) object:nil] start];
    }
}

- (void)read {
    pthread_rwlock_rdlock(&_lock);
    NSLog(@"read");
    pthread_rwlock_unlock(&_lock);
}

- (void)write {
    pthread_rwlock_wrlock(&_lock);
    NSLog(@"write");
    sleep(5);
    pthread_rwlock_unlock(&_lock);
}

- (void)dealloc {
    pthread_rwlock_destroy(&_lock);
}

@end
