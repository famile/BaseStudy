//
//  MemoryManagerViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/20.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "MemoryManagerViewController.h"
#import "LTProxy.h"
#import "LTTimer.h"
@interface MemoryManagerViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) dispatch_source_t gcdTimer;

@end

@implementation MemoryManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // NSTimer内存泄露
//    [self timerMemoryLeak];
    
    // 创建gcd定时器
//    [self createGcdTimer];
    
//    [LTTimer execTask:^{
//        NSLog(@"1234");
//    } start:1 interval:1 repeats:YES async:NO];
    
//    [LTTimer execTask:self selector:@selector(timerTest) start:1 interval:1 repeats:YES async:YES];
    
    /*
     低  保留
     |   代码段
     高  数据段（
            字符串常量 NSString *str = @"123"，
            已初始化数据 已初始化的全局变量，静态变量
            未初始化数据）未初始化的全局变量，静态变量
        堆（heap）
        栈(stack 由高到低分配)函数调用开销 比如局部变量，分配的内存地址越来越小
        内核区
     */
    
    /*
     引用计数
     copy: 产生一个副本对象，跟原对象互不影响
     深copy：内容copy
     浅copy：指针copy
     */
    
    /*
     autorelease对象在什么时机会被释放
     如果有autoreleasepool{} 在大括号结束的时候释放
      是由runloop来控制的，可能是在某次循环进入睡眠或者退出的时候释放
     
     如果是autorelease对象，会在runloop循环后释放
     如果不是会在方法结束后释放
     */
}


#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method
- (void)timerMemoryLeak {
//    __weak typeof(self) ws = self;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [ws test];
//    }];
    // timer对self强引用，self对timer强引用造成循环引用
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[LTProxy initWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
}

- (void)timerTest {
    NSLog(@"开始任务%s", __func__);
}

/**
 gcd定时器
 */
- (void)createGcdTimer {
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    uint64_t start = 2.0; // 两秒后开始执行
    uint64_t interval = 1.0; // 间隔1秒执行
    // 设置时间
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        [self timerTest];
    });
    
    dispatch_source_set_event_handler_f(timer, timerFire);
    
    // 启动定时器
    dispatch_resume(timer);
    _gcdTimer = timer;
}

#pragma mark - setter

#pragma mark - init

- (void)dealloc {
    [self.timer invalidate];
    NSLog(@"%s", __func__);
    
}

void timerFire(void * params) {
    NSLog(@"222");
}

@end


