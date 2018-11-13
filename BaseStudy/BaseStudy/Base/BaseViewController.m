//
//  BaseViewController.m
//  BaseStudy
//
//  Created by 李涛 on 2018/7/31.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "BaseViewController.h"

#import "BaseModel.h"
#import "MultiInheritModel.h"
@interface BaseViewController ()<BaseTestDelegate>

@property (nonatomic, strong) BaseModel *baseModel;

@end

@implementation BaseViewController

- (void)dealloc{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    /*
     内存的分配
     高  栈区(stack)
     ^   堆区(heap)
     |   全局区(static静态区)
     |   常量区(常量字符串)
     低  代码区
     
     
     //main.cpp
     int a = 0;            全局初始化区
     char *p1;          全局未初始化区
     main()
     {
     int b;                          // 栈
     char s[] = "abc";      //栈
     char *p2;                  //栈
     char *p3 = "123456";          //"123456/0"在常量区，p3在栈上。
     static int c =0；                    //全局（静态）初始化区
     p1 = (char *)malloc(10);
     p2 = (char *)malloc(20);
     //分配得来得10和20字节的区域就在堆区。
     strcpy(p1, "123456");         //123456/0放在常量区，编译器可能会将它与p3所指向的"123456"优化成一个地方。
     
     */
    
    //https://www.cnblogs.com/ruixin-jia/p/5877492.html
    
    //32位和64位
    /*
                 char short int long pointer
       32位 的大小   1    2    4    8     4
       64位 的大小   1    2    4    8     8
     */
    
    
    
#pragma mark - 面向过程和面向对象的区别
    
    /*
     面向过程和面向对象的区别：
     
     面向过程：就是分析解决问题所需要的步骤，然后用函数一步一步实现，使用的时候依次调用
     
     面向对象：就是把构成问题的事物分解成各个对象，建立对象不是为了完成一个步骤，而是为了描述某个事物在整个解决问题的步骤中的行为
     特性：封装，继承，多态，易维护，扩展，复用
     
     */
    
#pragma mark - 类名映射，方法映射，performSelector注意点
    
    Class class = NSClassFromString(@"BaseModel");
    BaseModel *model = [[class alloc] init];
    model.delegate = self;
    model.name = @"name1";
    [model test];
    _baseModel = model;
    
    NSLog(@"%@",model.name);
    
    SEL sel1 = @selector(test);
    SEL sel2 = NSSelectorFromString(@"test");
    
    [self performSelector:sel1];
    [self performSelector:sel2];
    
    [self performSelector:@selector(test)];
    /*
     这里为什么会有warning？编译器无法检查实际上有没有这个selector，为什么会造成内存泄露呢？怎么消除这个warning
     原因是这样的，我们在arc下调用一个方法，runtime需要知道我们对于返回值该怎么办，返回值可能有各种类型：void，id，int，char，NSString等等。arc一般是根据返回值的头文件决定改怎么办的，一共有4种情况：
     1.直接忽略（如果是基本数据类型，int，void这样的）
     2.把返回值先retain，等到不用的时候再release（最常见的情况）
     3.不retain，等到用不到的时候直接release（用于init、copy这一类方法，或者标注ns_returns_retained的方法）
     4.什么也不做，默认返回值在返回前后是始终有效的（一直到最近的release pool结束为止，用于标注ns_returns_autoreleased的方法）
     
     而调用performSelector：的时候，系统会默认返回值并不是基本类型，但也不会retain、release，也就是默认采取第4种方式。所以如果那个方法本来属于前3种，都有可能造成内存泄露。
     对于返回void或者基本类型的方法，就目前而言可以忽略warning，但这样不一定安全。我看过 Clang 在处理返回值这块儿的几次迭代演进。一旦开着 ARC，编译器会觉得从performSelector:返回的对象没理由不能 retain，不能 release。在编译器眼里，它就是个对象。所以，如果返回值是基本类型或者void，编译器还是存在会 retain、release 它的可能，然后直接导致 crash。
     
     有趣的是，下面这种静态声明的selector就不会出warning，原因是：这种情况下编译器能在编译阶段得到关于这个selector的全部信息，不需要默认任何事情
     [self performSelector:@selector(test)];
     
     作者：戴仓薯
     链接：https://www.jianshu.com/p/6517ab655be7
     來源：简书
     简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
     */
    IMP imp1 = [self methodForSelector:sel1];
    void (*func)(id,SEL) = (void *)imp1;
    func(self,sel1);
    
    /*
     NS/CF/CG/CA/UI这些前缀分别是什么含义：
     NS cocoa Fundation框架
     CF cocoa Fundation框架
     CG CoreGraphics.framworks
     CA CoreAnimation
     UI UIKit
     */
    
#pragma mark - 说Objective-C是动态运行时语言是什么意思
    /*
     主要是将数据类型的确定由编译时推迟到了运行时，这个问题涉及到两个概念：运行时，多态
     运行时机制 使我们直到运行时才去决定一个对象的类别，以及调用该类别对象相应方法
     多态：不同对象以自己的方式响应相同的消息的能力叫做多态
     假设生物类（life）拥有一个相同的方法-eat，那么人，狗继承了life后，实现各自的eat，但是调用我们只需调用各自的eat方法，也就是不同的对象以自己的方式响应了相同的消息（响应了eat这个选择器），因此也可以说运行时机制是多态机制的基础
     */

#pragma mark - NotificationCenter，KVC，KVO，Delegate说明他们的区别
    /*
     KVO :一对多，观察者模式，提供了观察某一属性变化的方法，极大简化了代码
     KVC：键值编码，一个对象在调用setValue的时候，
         1.检查相应的key是否有setter方法，存在就调用set方法
         2.set方法不存在就查找_key成员变量是否存在，存在直接赋值
         3._key不存在，就查找key，key存在就直接赋值
         4.如果以上都没有，调用ValueForUndefinedkey，和setValueForUndefinekey
     Delegate:通常发送者和接受者的关系是直接一对一的关系
         代理的目的是改变或传递控制链，允许一个类在某些特定时刻通知其他类，而不需要获取到那些类的指针
         可以减少框架复杂度，消息的发送者告知接受者某个事件将要发生，delegate同意然后发送者响应事件，delegate机制使得接受者可以改变发送者的行为
     Notification:观察者模式，通常发送者和接受者的关系是间接的多对多关系，消息的发送者告知接受者事件已经发生，接受者不能影响发送者
     
     区别：
         1.效率：delegate比NSNotification高
         2.delegate比notification更加直接，需要返回值，notification不关心结果
         3.两个模块之间联系不是很紧密，就用notification，多线程之前传值用notification
         4.delegate是一种简单的回调，且主要用在一个模块中，
     */
    
#pragma mark - OC有多继承嘛，没有的话用什么代替
    /*
     oc是没有多继承的，只支持单继承，如果要实现多继承的话，如果要实现多继承的话，可以通过类别和协议的方式来实现
     
     protocol 可以实现多个接口，通过实现多个接口可以完成多继承
     category 一般使用分类，用category重写类的方法，仅对本category有效，不会影响到其他类与原有类的关系
     
     */
    //protocol 实现多继承
    MultiInheritModel *mulInheritModel = [[MultiInheritModel alloc] init];
    [mulInheritModel protocol1];
    [mulInheritModel protocol2];
    [mulInheritModel protocol3];
    //给NSObject添加分类，因为NSObject是所有类的分类，给NSObject添加类别就相当于所有类别添加了这些方法，所有的类都可以使用这些方法
    
#pragma mark - category 和 extension是什么，两者区别，继承和类别在实现中有何区别？
    /*
     类别：在没有原类.m文件的基础上，给该类添加方法
     延展：一种特殊形式的类别，一般写在.m文件里声明和实现延展的作用，就是给某个类添加私有方法和私有变量
     区别：1.延展可以添加属性并且它添加的方法是必须要实现的，延展可以认为是一个私有的类目
          2.类别可以在不知道，不改变原类代码的情况下添加新的方法，只能添加，不能删除修改
          3.如果类别和原来类的方法名称产生冲突，则类别将覆盖原来的方法，因为类别具有更高的优先级
          4.继承可以增加，修改，删除方法，添加属性
     
     */
    
#pragma mark - oc中有私有方法，私有变量，没有的话，有没有什么代替的方法？
    /*
     方法只有静态方法和实例方法，但是可以通过把方法的声明和定义都放在.m来实现一个表面的私有方法。
     私有属性可以通过@private来修饰，或者把声明放到.m文件中
     在OC中，所有实例变量默认都是私有的，所有实例方法默认是共有的
     */
    
#pragma mark - include与import的区别，#import和@class的区别
    /*
     include是C中用来引入文件的关键字，import是OC中代替include的关键字，
     import能确保同一个文件只导入一次，include容易引起重复引用问题
     
     import和@class的区别：
         1.import会链入该头文件的全部信息，包括实例变量和方法，@class只是告诉编译器，其后面的名称是类的名称，至于这些类是如何定义的，暂时不用考虑
         2.@class声明这个名称是类的名称，不需要咋知道其内部的实例变量和方法
         3.在实现类里面，因为会用到这个引用类内部的实体变量，需要import导入被引用类的头文件
         4.在编译效率方面，如果100个头文件import同一个文件，或者这些文件是依次引用的，A->B B->C C->D这样的引用关系，当最开始的那个头文件变化，后面引用它的类都会重新编译，这将浪费大量的时间，而@class则不会
         5.如果有循环依赖关系，A->B B->A 使用import相互包含，就会出现编译错误，如果使用@class相互声明就不会编译错误
     
     */
#pragma mark - nil Nil NULL NSNull的区别
    
    /*
     nil Nil NULL这三者在OC中的值是一样的，都是(void*)0 那么为什么要区分呢，又与NSNull区别
     nil是宏，是对OC的对象使用的，表示对象为空
     Nil是宏，是对于OC的类使用的，表示类指向空
     NULL是宏，是对于C的指针而使用的，表示空指针
     NSNull 是类类型，表示空的占位对象
     
     */
    
#pragma mark - 向一个nil对象发送消息会发生什么？
    /*
     向nil发送消息是完全有效的，只是在运行时不会有任何作用
     objc是动态语言，在运行时转为消息发送
     objc_msgSend(receiver,selector)
     runtime会根据对象的isa指针找到对象实际所属类，然后在该类的方法列表和父类的方法列表中寻找方法运行，objc_msgSend并不会返回值，返回的内容都是具体调用时执行的。如果向nil发送消息，在寻找isa的时候就返回了，不会出现任何错误
     */
    
#pragma mark - delegate protocol 理解
    /*
     protocol 主要定义公共接口，不管具体实现
     委托方：根据指定的协议，指定代理完成什么功能
     代理：根据指定的协议，完成委托方需要实现的功能
     */
    
#pragma mark - objc对象内存中的布局 isa指针问题
    /*
     所有的父类的成员变量和自己的成员变量都会存放在该对象所对应的存储空间中
     每一个对象内部都有一个isa指针，指向他的类对象，类对象中存放这本对象的：
         1.对象方法列表
         2.成员变量的列表
         3.属性列表
     内部也有一个isa指针指向元对象（meta class）元对象内部存放的是类方法列表，类对象内部还有一个superClass的指针，指向他的父类对象
     最终指向root meteclass（根元类），根元类的isa指向自己
     
     isa是一个class类型的指针，每个实例对象有isa的指针，指向对象的类，类对象里面也有一个isa指针，指向元类（meteClass）元类保存了类方法的列表。当类方法被调用时先从本身查找类方法的实现，如果没有，元类会向他父类查找该方法。元类也有isa指针，它的指针最终指向的是一个根元类（root meteClass）根元类的isa指针指向本身，这样就形成了一个封闭的内循环
     */
    
#pragma mark - 创建一个对象需要什么步骤
    /*
     开辟内存空间
     初始化参数
     返回内存地址
     */
    
#pragma mark - assign 和 weak 有什么区别
    /*
     1.assign 修饰基本数据类型，weak 修饰对象类型
     2.weak 一般使用在出现循环引用的时候，是一种非拥有关系，
     
     */
    
#pragma mark - 内存管理研究的对象
    /*
     野指针: 是指指向“垃圾”内存（不可用内存）的指针
         1.使用野指针调用对象方法，会报异常，程序崩溃
     内存泄露
     僵尸对象：堆中已经被释放的对象（retainCount = 0）
     空指针：指针赋值为空，nil
     */
    
#pragma mark - autorelease, release, NSAutoreleasePool
    /*
     release：手动为该对象引用计数-1
     autorelease：把该对象放入自动释放池，当自动释放池释放时，其内的对象的引用计数-1
     
     autorelease对象在出了作用域后，会被添加到最近一次创建的自动释放池中，并会在当前的runloop迭代结束时释放
     
     自动释放池：用来存储多个对象类型的指针变量，存入池内的对象，当自动释放池被销毁是，会对池内的对象全部做一次release操作
     什么时候释放：一旦监听到runloop即将进入睡眠等待状态，就释放自动释放池
     
     */
    
#pragma mark - 内存泄露
//    [_baseModel setBlockTest:^(int res) {
//        [self test];
//    }];
//    [self leak];
    
    /*
     常见的内存循环引用的场景：
         1.NSTimer - self->timer->self(target为self)
         2.block的使用，self->block->self  self.block = ^{[self doSomething]}
         3.delegate  委托声明delegate时要用weak
     */
    
#pragma mark - 对象添加到通知中心，通知中心发通知时，这个对象却已经被释放了，可能会出现什么问题
    /*
     当对象加入到通知中心后，若在对象销毁前不将该对象从通知中心移除，当发送通知时，就会造成崩溃。
     */
    
#pragma mark - 字符串的引用计数问题
    //https://blog.csdn.net/monkeylu92/article/details/49967047
    /*
     1）对于通过initWithString和stringWithString(字面量)创建的NSString对象，不管字符串的内容和长度怎么变化，该对象始终是存储在常量区的，没有引用计数一说；硬要加一个引用计数的话，那么就是无符号长整型的最大值
     
     2）对于通过initWithFormat和stringWithFormat创建的NSString对象，如果字符串内容是汉字，那么，该对象和Objective-C中其他类型的对象是一致的；如果字符串内容是非汉字，那么，当字符串长度小于10个时，该对象存储区域在已知的五大区域之外，且随着字符串长度的变化，存储地址会有很大变化；当字符串长度超过10个以后，该对象与Objective-C中其他类型的对象一致
     */
    NSString *name = [[NSString alloc] init];
    NSLog(@"%p-%p",&name,name);
    name = @"哈哈";
    NSLog(@"%p-%p",&name,name);
    name = @"呵呵";
    NSLog(@"%p-%p",&name,name);
    NSString *name2 = @"哈哈";
    NSLog(@"%p-%p",&name2,name2);
    if (name == name2) {
        NSLog(@"相等");
    }else{
        NSLog(@"不相等");
    }
    
    if ([name isEqualToString:name2]) {
        NSLog(@"相同");
    }else{
        NSLog(@"不相同");
    }
#pragma mark - KVC 和 KVO
    /*
     kvc 键值编码，通过字符串直接访问对象的属性
     底层实现：当一个对象调用setValue时，检查对应的set方法，存在直接调用set方法，不存在检查_key是否存在，存在直接赋值，不存在查找相同名称的属性，如果有直接赋值。如果还没有，调用valueforUndefindKey，setValue:forUnderfindKey
     kvo 键值观察机制
         底层实现：kvo基于runtime机制实现， 当观察一个对象，一个新类会动态创建，这个类继承对象原本的类，并重写了观察属性的setter方法，重写的setter方法会负责在原setter方法之前和之后，通知所观察对象：值的更改。最后通过isa混写（isa-swizzling）把这个对象的isa指针（isa指针告诉runtime系统这个对象的类是什么）指向这个新的子类，对象就神奇的变成了新创建的子类的实例
     */
    
#pragma mark - 简单说下app启动过程
    /*
     1.main函数
     2.UIApplicationMain（创建UIApplication对象），创建UIApplication的delegate对象，
     如果是storeboard:根据Info.plist获得Main.storyboard的文件名，加载Main.storyboard,创建UIWindow，创建和设置UIWindow的rootViewController
     如果是没有storyboard：delegate监听系统事件，程序启动完毕的时候，就会调用代理，在application：didFinishLaunchingWithOptions:中创建UIWindow和设置rootViewController
     */
    
#pragma mark - load 和 initialize方法的区别
    /*
     + (void)load;
     load是只要类所在文件被引用就会被调用，所以如果类没有被引用进项目就不会调用load。
     load方法会在每一个类甚至分类被引入是调用一次，调用的顺序是父类优先于子类，子类优先于分类，load不会被类自动继承
     
     + (void)initialize;
     initialize是在类或者其子类的第一个方法被调用前调用。类被引用，但是没有使用，initialize不会被调用
     */
    
}

#pragma mark - BaseTestDelegate
- (void)implementProtocol{
    NSLog(@"代理实现");
}


- (void)test{
    NSLog(@"%s",__func__);
}

- (void)leak{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}


#pragma mark - httpRequest

#pragma mark - click

#pragma mark - private method

#pragma mark - setter

#pragma mark - init

@end
