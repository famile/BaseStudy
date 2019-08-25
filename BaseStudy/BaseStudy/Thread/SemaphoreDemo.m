//
//  SemaphoreDemo.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/20.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation SemaphoreDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(5);
    }
    return self;
}

- (void)otherTest {
    
    for (int i = 0; i < 10; i++) {
        [[[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil] start];
    }
}

- (void)test {
    // 最大并发数量
    /*
     如果信号量大于零， 信号量-1，继续往下执行
     如果信号量<= 0 就会休眠等待，DISPATCH_TIME_FOREVER（等待时间）直到信号量的值大于0然后继续执行代码
     */
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"完成任务");
    sleep(1);
    // 让信号量的值+1
    dispatch_semaphore_signal(_semaphore);
}

@end
