//
//  RuntimeRunloopViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/6.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "RuntimeRunloopViewController.h"
#import <objc/runtime.h>
#import "LTPerson.h"

@interface RuntimeRunloopViewController ()

@end

@implementation RuntimeRunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     LLVM  OC -> 中间代码 ->汇编，机器代码
     super
     objc_msgSendSuper({self,[UIViewController class]},sel_registerName(""))
     
     */
    
    NSString *name = @"123";
    id cls = [LTPerson class];
    void *obj = &cls;
    [(__bridge id)obj test];
    
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     interview：
     1、讲一下OC的消息机制
     OC 中的方法都是转成objc_msgSend的函数调用，给receiverf（方法调用者）发送了一条消息（select方法名）
     objc_msgSend底层有3大阶段
      消息发送（当前类，父类），动态方法解析，消息转发
     2、消息转发机制
     
     3、什么是runtime,平时怎么用
     OC是一门动态性比较强的变成语言，允许好多操作推迟到程序运行时再进行
     OC的动态性就是有runtime支撑和实现的，runtime是一套C语言的API，封装了很多动态性相关的函数
     平时编写的OC代码，底层都是转换成了RuntimeAPI进行调用
     利用关联对象（associateObject）给分类添加属性
     遍历系统的所有成员变量（可以访问私有的成员变量，修改textfield的占位文字颜色，字典转模型，自动归档解档）
     交换方法实现（交换系统的方法实现）hook
     利用消息转发机制解决方法找不到的问题
     。。。
     4、[super message] objc_msgSendSuper({self, [Object class]}, @selecter(class))
     是从父类开始查找方法
     
     */
    
    
    /*
     编写代码 -> 编译链接 -> 运行
     
     OC 在运行的时候可以修改编译 和c，c++有很大的不同
     Objective-C的动态性是由Runtime API来支撑的，提供一套c语言的API
     */
    
    /*
     isa指针
        在arm64之前，isa就是一个普通的指针
        arm64后，isa变成了一个共用体
     
     
     */
    
    /*
     cache_t buckt
     散列表，mask 散列表长度-1， 已经缓存的方法， @select()&mask
     */
    /*
     OC的方法调用 （消息机制） 消息发送，动态方法解析，消息转发, 如果找不到方法（unrecognized selector sent to instance）
     objc_msgSend(person, sel_registerName("test"));
     给方法调用者发送消息
     消息接受者（receiver）
     消息名称：
     sel_registerName("test") 和 @select(test)是一样的
     
     */
    LTPerson *person = [[LTPerson alloc] init];
    [person test];
    [person unregisterFunc];
    [person unrecognizedFunc];
//    sel_registerName(<#const char * _Nonnull str#>)
    
    
//
}



@end
