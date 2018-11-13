//
//  BlockViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2018/8/3.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "BlockViewController.h"
#import "BlockFuncModel.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    test1();
//    test2();
//    test3();
//    test4();
    
//    BlockFuncModel *model = [[BlockFuncModel alloc] init];
//    model.add(1).add(2).add(3);
    
    /*
     block的原理是怎样的？本质是什么？
     __block的作用是什么？有什么使用注意点？
     block的属性修饰词为什么是copy？使用block有哪些使用注意？
     block在修改NSMutableArray，需不需要添加__block？
     
     1.block本质上是一个对象，他内部也有一个isa指针，block是封装了函数和函数调用环境的oc对象
     
     栈空间上的block不会对对象强引用，堆空间的block有能力持有外部调用的对象，即对对象进行强引用或去除强引用的操作
     
     2.__block用于解决block内部不能修改auto变量值的问题，__block不能修饰静态变量和全局变量
     __block将变量包装成对象，然后在把变量封装在结构体内。block内部存储的变量为结构体指针，也就可以通过指针到内存地址进而修改变量的值
     
     3.copy将block从栈中复制一份到堆中，栈中的代码在作用域结束后内存就会被销毁，block可能在内存销毁之后才去调用他，这样就出现问题了
     
     使用block需要注意：循环引用，在block内部修改外部变量需要添加__block 修饰变量
     
     4.不需要，block内修改NSMutableArray仅仅是使用了array的内存地址，在内存地址中添加内容，并没有修改array的内存地址，不需要__block也可以正确编译
     
     
     */
    
    
    
    
}


#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method
void test1(){
//    int a = 10;
//    NSLog(@"%p",&a);
//    void (^block)(void) = ^{
//        NSLog(@"%p",&a);
//        NSLog(@"a is %d",a);
//    };
//    a = 20;
//    NSLog(@"%p",&a);
//    block();
    
    BlockFuncModel *m = [[BlockFuncModel alloc] init];
    m.name = @"123";
    __weak BlockFuncModel *wm = m;
    void(^block2)(void) = ^{
        NSLog(@"%@",wm.name);
    };
    m.name = @"321";
    block2();
    NSLog(@"----------End");
}

void test2(){
    __block int a = 10;
    NSLog(@"%p",&a);
    void (^block)(void) = ^{
        NSLog(@"%p",&a);
        NSLog(@"a is %d",a);
    };
    a = 20;
    block();
}

void test3(){
    static int a = 10;
    void (^block)(void) = ^{
        NSLog(@"a is %d", a);
    };
    a = 20;
    block(); // 20
}

int a = 10;
void test4(){
    void(^block)(void) = ^{
        NSLog(@"a is %d", a);
    };
    a = 20;
    block();
}

#pragma mark - setter

#pragma mark - init

@end
