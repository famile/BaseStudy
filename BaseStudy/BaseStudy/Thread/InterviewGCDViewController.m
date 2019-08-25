//
//  InterviewGCDViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/19.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "InterviewGCDViewController.h"
#import <libkern/OSAtomic.h>
#import "LTSpinLockDemo.h"
#import "OSUnfairLockDemo.h"
#import "MutexDemo.h"
#import "MutexDemo2.h"
#import "SemaphoreDemo.h"
#import "RWLockDemo.h"

@interface InterviewGCDViewController ()
@property (nonatomic, assign) int money;
@property (nonatomic, assign) int ticketsCount;
@property (nonatomic, assign)OSSpinLock lock;
@property (nonatomic, assign)OSSpinLock lock1;

@end

@implementation InterviewGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
                            并发队列        串行队列        主队列
     dispatch_sync(同步)
     dispatch_async(异步)
     */
    /*
     使用snyc函数，往当前串行队列中添加任务，会卡住当前的串行队列（产生死锁）
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"执行任务1");
//    [self interview01];
//    [self interview06];
//    [self interview07];
    NSLog(@"执行任务3");
    /*
     异步并发执行任务1任务2，都完成后执行任务3
     */
//    [self groupInterview];
    
    /*
     多线程的安全隐患
     一块资源被多个线程共享，也就是多个线程可能会访问同一块资源（比如多个线程访问同一个对象，同一个变量，同一个文件）
     当多个线程访问同一块资源时，很容易引发数据错乱和数据安全问题
     解决方案：
     使用线程同步技术（同步，就是协同步调，按预定的先后次序进行）
     常见的线程同步技术是：加锁
     OSSpinLock 叫做”自旋锁“，等待锁的线程会处于忙等(busy-wait)状态,一直占用CPU资源（相当于 while（锁没有打开））  目前已经不安全了，可能会出现优先级反转问题
     如果等待锁的优先级比较高，它会一直用着CPU资源，优先级低的线程就无法释放锁
     
     自旋锁和互斥锁的比较：
     什么情况使用自旋锁：
        预计线程等待锁的时间很短
        加锁的代码（临界区）经常调用，但竞争情况很少发生
        CPU资源不紧张，多核处理器
     
     什么情况使用互斥锁：
        预计线程等待的时间比较长
        单核处理器
        临界区有IO操作
        临界区代码复杂或者循环量大
        临界区竞争非常激烈
     
     */
    _lock = OS_SPINLOCK_INIT;
    _lock1 = OS_SPINLOCK_INIT;
//    [self ticketTest];
//    [self moneyTest];
    
    LTSpinLockDemo *spinDemo = [[LTSpinLockDemo alloc] init];
//    [spinDemo moneyTest];
//    [spinDemo ticketTest];
    /**
     os_unfair_lock 用于取代不安全的OSSpinLock从iOS10开始支持
     从底层调用来看，等待os_unfair_lock锁的线程会处于休眠状态，并非忙等
     */
    OSUnfairLockDemo *unfairDemo = [[OSUnfairLockDemo alloc] init];
//    [unfairDemo moneyTest];
//    [unfairDemo ticketTest];
    /**
     mutex叫做互斥锁，等待锁的线程会处于休眠状态
     */
    MutexDemo *mutexDemo = [[MutexDemo alloc] init];
//    [mutexDemo moneyTest];
//    [demo ticketTest];
    
    MutexDemo2 *mutexDemo2 = [[MutexDemo2 alloc] init];
//    [mutexDemo2 otherTest];
//    [mutexDemo2 otherTest2];
    SemaphoreDemo *semaphoreDemo = [[SemaphoreDemo alloc] init];
//    [semaphoreDemo otherTest];
    
    // 读写安全 多读单写，写的时候不能读
    RWLockDemo *rwDemo = [[RWLockDemo alloc] init];
    [rwDemo otherTest];
}


#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method

/**
 存钱，取钱
 */
- (void)moneyTest {
    self.money = 100;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self drawMoney];
        }
    });
    
}

- (void)saveMoney {
    OSSpinLockLock(&_lock1);
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    NSLog(@"存50，还剩%d元",oldMoney);
    OSSpinLockUnlock(&_lock1);
}

- (void)drawMoney {
    OSSpinLockLock(&_lock1);
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    NSLog(@"取20，还剩%d元",oldMoney);
    OSSpinLockUnlock(&_lock1);
}


/**
 卖票
 */
- (void)ticketTest {
    self.ticketsCount = 15;
    dispatch_queue_t queue = dispatch_queue_create("ticket_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
}

- (void)saleTicket {
    // 加锁
//    OSSpinLock lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&_lock);
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    NSLog(@"还剩%d张票", oldTicketsCount);
    // 解锁
    OSSpinLockUnlock(&_lock);
}

- (void)interview01 {
    // 问题：以下代码是在主线程执行的，会不会产生死锁
    // 队列的特点：排队，FIFO，先进先出
    // dispatch_sync:立马在当前线程执行任务，执行完毕才能继续往下执行
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"执行任务2");
    });
}

- (void)interview02 {
    // 问题：以下代码是在主线程执行的，会不会产生死锁
    // dispatch_async:不会立马在当前线程同步执行任务
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
    });
}

- (void)interview03 {
    // 问题：以下代码是在主线程执行的，会不会产生死锁
    // dispatch_async:不会立马在当前线程同步执行任务
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3");
        });
        NSLog(@"执行任务4");
    });
    NSLog(@"执行任务5");
}
- (void)interview04 {
    // 问题：以下代码是在主线程执行的，会不会产生死锁  ! 不会
    // dispatch_async:不会立马在当前线程同步执行任务
    /*
     同步任务不是在一个队列中，不会相互等待，就不会死锁
     */
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("myqueue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        dispatch_sync(queue2, ^{
            NSLog(@"执行任务3");
        });
        NSLog(@"执行任务4");
    });
    NSLog(@"执行任务5");
}

- (void)interview05 {
    // 问题：以下代码是在主线程执行的，会不会产生死锁  ! 不会
    // dispatch_async:不会立马在当前线程同步执行任务
    /*
     并发队列也可以，不会堵塞
     */
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3");
        });
        NSLog(@"执行任务4");
    });
    NSLog(@"执行任务5");
}

- (void)interview06 {
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
//        [self performSelector:@selector(test) withObject:nil];//会执行
        [self performSelector:@selector(test) withObject:nil afterDelay:.0];//不会执行 afterDelay是定时器的执行，子线程默认没有启动runloop
        NSLog(@"3");
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    });
}

- (void)interview07 {
    if (@available(iOS 10.0, *)) {
        NSThread *thread = [[NSThread alloc] initWithBlock:^{
            NSLog(@"1");
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }];
        [thread start];
        [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:YES];
    } else {
        // Fallback on earlier versions
    }
}

- (void)groupInterview {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务一");
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务二");
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务三");
    });
    
}

- (void)test {
    NSLog(@"2");
}

#pragma mark - setter

#pragma mark - init

@end
