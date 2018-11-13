//
//  ViewController.m
//  GCDDemo
//
//  Created by 李涛 on 2017/4/6.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
//#import "AFNetworking.h"
#import "UIViewController+test.h"

@interface ViewController ()<ViewControllerDelegate>
{
    NSString *_name2;
}
@property (nonatomic, strong) NSMutableArray *arr;


@end

@implementation ViewController

@synthesize className = _className;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#pragma mark - 队列创建方法
    /*
     队列的创建方法
     
     1、需要传入两个参数，第一个参数表示队列的唯一标识符，用于DEBUG,可为空
        第二个参数用来识别是串行队列还是并行队列（DISPATCH_QUEUE_SERIAL  DISPATCH_QUEUE_CONCURRENT）
     2、对于并发队列，还可以使用dispatch_get_global_queue来创建全局并发队列。
        GCD默认提供了全局的并发队列，需要两个参数，第一个表示优先级，一般使用
        DISPATCH_QUEUE_PRIORITY_DEFAULT,第二个参数暂时没用，用0即可
     */
    dispatch_queue_t squeue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t aqueue2 = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t aqueue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
#pragma mark - 6种组合方式
    /*
         主队列|串行|并行|
     同步|1   |2   |3   |
     ------------------
     异步|4   |5   |6   |
     
     */
//    [self syncTask:squeue];
//    [self syncTask:aqueue2];
//    [self syncTask:mainQueue];//所有任务都是在主线程执行的，syncTask和第一个任务都是在等对方执行完成，这样大家互相等待，就卡住了，所以任务执行不了
    
//    [self asyncTask:mainQueue];
//    [self asyncTask:squeue];
//    [self asyncTask:aqueue3];

#pragma mark - 线程间的通信
    /**
     * GCD线程之间的通信
       将耗时的操作放到子线程中，完成后回到主线程
     */
//    [self threadCommunication];
    
#pragma mark - GCD的其他方法
    
#pragma mark 栅栏方法
    /*
     有时候需要异步执行两组操作，第一组操作执行完之后，才能开始执行第二组操作。这样
     我们就需要一个相对于栅栏一样的一个方法将两组异步执行的操作组给分割起来，当然这里的
     操作组里可以包含一个或者多个任务。这就需要用dispatch_barrier_async方法在两个
     操作组之间形成栅栏
     PS:栅栏方法只能使用普通的并发队列，不能使用全局并发队列
     */
//    [self barrier];
    
#pragma mark 延时执行方法
    /*
     2秒后异步执行
     */
//    [self afterExecute];
    
#pragma mark 只执行一次（单例）
//    [self executeOnce];
    
#pragma mark 快速迭代方法（dispatch_apple）
//    [self fastEnum];
    
#pragma mark 队列组（dispatch_group）
    /*
        需求:有时候分别异步执行2个耗时操作,当这两个耗时操作都执行完成后再回到主线程
     */
//    [self group];
    
#pragma mark
    [self group2];
    
#pragma mark 模拟网络请求的依次请求
//    [self semaphore];
    
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4"]];
//    _arr = arr;
//    __weak __typeof(_arr)myArr = _arr;
//
//    [_arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [myArr removeObject:obj];
//
//    }];
//
//
//    NSString *(^blockTest)(NSString *) = ^(NSString *name){
//        NSLog(@"%@",name);
//        return name;
//    };
//
//    NSString *res = blockTest(@"哈哈");
//    NSLog(@"res - %@",res);
    
    
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
    self.name = @"";
    self.className = @"";
    
//    self -> _name2;
    
    NSLog(@"%@",self->_name2);
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}



- (void)syncTask:(dispatch_queue_t)queue{
     NSLog(@"asyncMain---begin");
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncMain---end");
}

- (void)asyncTask:(dispatch_queue_t)queue{
     NSLog(@"asyncMain---begin");
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncMain---end");
}



- (void)executeSyncTask:(dispatch_queue_t)queue{
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}

- (void)executeAsyncTask:(dispatch_queue_t)queue{
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}


- (void)threadCommunication{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"2------%@--回到主线程",[NSThread currentThread]);
        });
    });
}

- (void)barrier{
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
}

- (void)afterExecute{
    
    NSLog(@"--begin--");
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)2*NSEC_PER_SEC);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //2秒异步执行这里的代码
        NSLog(@"2秒异步执行这里的代码");
    });
}

- (void)executeOnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只执行一次");
    });
}

- (void)fastEnum{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd------%@",index, [NSThread currentThread]);
    });
}

- (void)group{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"开启任务一");
        [[AFHTTPSessionManager manager] POST:@"http://testwan-vc.yxwenge.com:8088/yxvcity-admin-vc/rest/team/findQuickTeamAllByPage" parameters:@{@"pageNo":@1,@"pageSize":@40} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        NSLog(@"完成任务一");
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"开启任务二");
        
        NSLog(@"完成任务二");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"回到主线程");
    });
}

- (void)group2{
    dispatch_group_t group = dispatch_group_create();
    
    for (int i = 0; i < 5; i++) {
        dispatch_group_enter(group);
        NSLog(@"开始任务：%@",@(i));
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_group_leave(group);
            NSLog(@"完成任务：%@",@(i));
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成全部任务");
    });
    
}

- (void)semaphore{
    //创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //创建全局并行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"完成请求1");
        //标记一个信号量
        sleep(1);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"完成请求2");
        //标记一个信号量
        sleep(2);
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_group_async(group, queue, ^{
        NSLog(@"完成请求3");
        //标记一个信号量
        sleep(3);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"全部完成");
    });
}


@end
