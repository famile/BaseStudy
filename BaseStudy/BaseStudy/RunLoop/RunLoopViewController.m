//
//  RunLoopViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "RunLoopViewController.h"

void observerCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
}

@interface RunLoopViewController ()

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /**
     runloop
     运行循环
     在程序运行过程中循环做一些事情
     
     */
    
    /*
     runloop与线程的关系
     每一个线程都有唯一的runloop和它对应
     RunLoop保存在一个全局的Dictionary里，线程作为key，RunLoop作为value
     线程刚刚创建时并没有RunLoop对象，RunLoop会在第一次获取它时创建
     RunLoop在线程结束的时候销毁
     主线程的RunLoop自动获取（创建），子线程默认没有开RunLoop
     
     应用：
         控制线程的生命周期
         解决NSTimer在滑动时停止工作的问题
         监控应用卡顿
         性能优化
     */
    
    /**
     RunLoop: mode source0,source1,observers,timers
     source0:触摸事件的处理,performSelector:onThread:
     source1:基于Port的线程间通信， 系统事件捕捉
     Timers: NSTimer， performSelector:withObject:afterDelay:
     Observers:用于监听RunLoop的状态，UI刷新（BeforeWaiting）,Autorelease Pool
     */
    //kCFRunLoopDefaultMode|UITrackingRunLoopMode  kCFRunLoopCommonModes
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, observerCallBack, NULL);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
    CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
    });
    
}


#pragma mark - httpRequest

#pragma mark - click
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch - view");
}
#pragma mark - private method
- (void)func1 {
//    NSRunLoop *loop;
//    CFRunLoopRef *loopref;
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//    CFRunLoopGetCurrent()
}
#pragma mark - setter

#pragma mark - init

@end

