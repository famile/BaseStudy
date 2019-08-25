//
//  ObjectViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2019/7/18.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "ObjectViewController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "NSObject+test1.h"
#import "NSObject+test2.h"
#import "LTPerson.h"
@interface ObjectViewController ()

@end

@implementation ObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     1. 一个object对象占多少个内存
     系统分配了16个字节给object对象，malloc_size方法获得
     object内部只占8个字节 class_getInstanceSize函数获得
     
     2. 对象的isa指针指向哪里
     instance对象的isa指向class对象
     class对象指向meta-class对象
     meta-class对象isa指向基类的meta-class对象
     
     3.oc的类信息存放在哪里
     对象方法，属性，成员变量，协议存放在class对象内
     类方法存放在meta-class对象内
     成员变量的具体值存放在instance对象
     
     */
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSObject *obj = [[NSObject alloc] init];
    
    NSLog(@"%zd,%zd",class_getInstanceSize([NSObject class]), malloc_size((__bridge const void *)(obj)));
    
    Class class = object_getClass(obj);
    Class metaClass = object_getClass(class);
    
    [obj test];
    
    /*
     4.iOS用什么方式实现一个对象的KVO(kvo的本质)
     利用runtimeAPI动态生成一个子类，并且让instance对象的isa指针指向这个新的类
     当修改instance对象的属性时，会调用Foundation框架的_NSSetXXXValueAndNotify函数
     willChangeValueForKey:
     父类的setter方法
     didChangeValueForKey:
     内部会触发监听器observe 的监听方法 observeValueForKeyPath:ofObject:change:context:
     5.如何手动出发KVO
     willChangeValueForKey:
     didChangeValueForKey:
     需要同时实现，did内部有标记will有没有调用
     
     */
    
    
    /*
     6.通过KVC修改属性会触发KVO嘛
     会触犯KVO
     7.KVC的赋值和取值过程是怎样的？原理是什么？
     
     */
    
    /*
     KVO setValue: forKey: -> (setKey: _setKey)
     如果没找到
     accessInstanceVariablesDirectly(能不能访问成员变量)
     - 如果return NO， -> setValue: forUndefinedKey:
     - 如果return YES， _key,_isKey,key,isKey,如果找到了直接给成员变量赋值，没找到 -> setValue: forUndefinedKey:
     
     valueForKey: (getKey,key,isKey,_key)
     如果没找到
     accessInstanceVariablesDirectly(能不能访问成员变量) valueForUndefinedKey:
     return NO
     return YES _age,_isAge,age,isAge
     */
    
    
    /*
       category的使用场合是什么：
       扩展一些类的方法
     8.category的实现原理
     Category编译之后的底层结构是struct category_t,里面存放这对象方法，类方法，属性，协议信息
     在程序运行的时候，runtime会将category的数据合并到类信息中（类对象，元类对象中）
     9.Category和Extension的区别是什么
     extension在编译的时候数据已经包含在类信息中
     category是在运行时，才会将数据合并到类信息中
     10.Category中有load方法嘛，load方法是什么时候调用的，load方法能继承嘛
     load方法会在runtime加载类和分类时调用，每个类、分类的+load在程序中只调用一次
     调用顺序：
     先调用类的+load
        按照编译先后顺序调用（先编译，先调用）
        调用子类的+load之前调用父类的+load
     在调用分类的+load
        按照编译先后顺序调用（先编译，先调用）
     11.load，initialize方法的区别是什么，他们在category的调用顺序，以及出现在继承时他们之间的调用过程
     调用方式 load是根据函数地址直接调用， initialize是通过objc_msgSend
     调用时刻：load是runtime加载类分类的时候调用，只会调用一次
             initialize是类第一次接受消息的时候调用，每一个类只会initialize一次（父类的initialize可能会调用多次）
     调用顺序：load
             initialize 先初始化父类，再初始化子类
     
     （initialize方法在类第一次接收到消息时调用（objc_msgSend）
     如果子类没有实现initialize么有实现，就去调用父类的方法
     如果分类实现了initialize方法，就会覆盖类本身的initialize
     调用顺序 先调用父类的initialize方法，再调用子类的initialize方法（如果父类调用过就不会再调用了））
     
     12.Category能否添加成员变量，如果可以，如何给Category添加成员变量
     不能直接给Category直接添加成员变量，但可以间接添加成员变量
     
     */
    
    /*
     运行时动态添加进去
     关联对象并不是存储在被关联对象本身内存中
     关联对象存储在全局的统一的一个AssociationsManager中
     设置关联对象为nil，相当于移除关联对象
     */
    class.name = @"123";
    NSLog(@"Object -> name = %@",class.name);
    
    /*
     13.block的原理是怎样的，本质是什么
     block本质也是oc对象，他内部也有isa指针
     block是封装了函数调用以及函数调用环境的OC对象
     
     14、__block的作用是什么，有什么使用注意点
      __block变量包装成一个对象，解决block内部不能修改auto变量值的问题，
     需要进行内存管理，在MRC下，不会对block修饰的对象进行强引用
     
     15、block的属性修饰词为什么是copy，使用block有哪些使用注意
     block没有copy就不会在堆上，希望控制声明周期
     循环引用的问题
     
     16、block在修改NSMutableArray,需不需要添加__block?
     不需要
     
     */
    
    /*
     block的变量捕获
      局部变量  会捕获到block内部，
            auto    值传递
            static  指针传递
     全局变量  不会捕获到block内部
           可以直接访问
     */
    int a = 10;
    static int height = 10;
    void(^block)(void) = ^{
        NSLog(@"num is %d, height is %d",a,height);
    };
    a = 20;
    height = 20;
    block();
    /*
     block 类型
     __NSGlobalBlock__(没有访问auto变量)
     __NSStackBlock__（访问了auto变量就是stack）
     __NSMallocBlock__（  ）
     */
    
    /*
    当block内部访问了对象类型的auto变量时
     如果block在栈上，将不会对auto变量产生强引用
     
     如果block copy到堆上
        会调用block内部的copy函数
        copy函数内部会调用_Block_object_assign函数
        _Block_object_assign函数会根据auto变量的修饰符（__strong, __weak __unsafe_unretained）做出相应的操作，类似于retain（形成强引用，弱引用）
     如果 block从堆上移除
        会调用block内部的dispose函数
        dispose函数内部会调用_Block_object_dispose函数
        _Block_object_dispose函数会自动释放引用的auto变量，类似于release
     */
    
    /*
     循环引用问题：
            __weak 不会产生强引用，指向的对象销毁后，会自动让指针置为nil
            __unsafe_unretained  不会产生强引用，不安全，指向的对象销毁时，指针存储的地址值不变（不安全，野指针）
     */
    
//    LTPerson *person = [[LTPerson alloc] init];
//    person.name = @"1234";
//    __weak LTPerson *wkPerson = person;
//    person.block = ^{
//        NSLog(@"name -> %@",wkPerson.name);
//    };
    
    __block LTPerson *person = [[LTPerson alloc] init];
    person.name = @"1234";
    person.block = ^{
        NSLog(@"name -> %@",person.name);
        person = nil;
    };
    
    NSMutableArray *arr2 = [NSMutableArray array];
    NSString *temp = @"123";
    temp = @"321";
    MyBlock block2 = ^{
//        [arr2 addObject:@"123"];
//        temp = @"321"
        NSLog(@"插入-----%@",temp);
    };
    block2();
    NSLog(@"%@",arr2);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
