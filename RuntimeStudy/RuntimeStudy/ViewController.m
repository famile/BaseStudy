//
//  ViewController.m
//  RuntimeStudy
//
//  Created by 李涛 on 2017/5/11.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//
//http://www.jianshu.com/p/adf0d566c887

#import "ViewController.h"
#import <objc/runtime.h>
#import "MyClass.h"

static char kDTActionHandlerTapGestureKey;

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self encode];
    
    [self setNickName];
    NSString *nickName = [self getNickName];
    NSLog(@"%@",nickName);
    
}



- (void)encode{
    float a[] = {1.0,2.0,3.0};
    NSLog(@"array encoding type: %s",@encode(typeof(a)));
}


- (void)createNewClass{
//    Class cls = objc_allocateClassPair(MyClass.class, "MySubClass", 0);
//    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    
}

- (void)setNickName{

    NSString *nickName = objc_getAssociatedObject(self, "nickName");
    if (!nickName) {
        nickName = @"taotao";
        objc_setAssociatedObject(self, "nickName", nickName, OBJC_ASSOCIATION_COPY);
    }
}

- (NSString *)getNickName{
   return objc_getAssociatedObject(self, "nickName");
}


- (void)runClassBaseMethod{
    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0;
    Class cls = myClass.class;
    //类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"==========================================================");
    
    //父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"==========================================================");
    
    //是否是元类
    NSLog(@"MyClass is %@ a meta-class",class_isMetaClass(cls) ? @"" : @"not");
    NSLog(@"==========================================================");
    
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s",class_getName(cls),class_getName(meta_class));
    NSLog(@"==========================================================");
    
    //变量实例大小
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
    
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instance variable %s", ivar_getName(string));
    }
    NSLog(@"==========================================================");
    
    //属性操作
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property));
    }
    free(properties);
    
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    NSLog(@"==========================================================");
    
    //方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    free(methods);
    
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", method_getName(method1));
    }
    
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method : %s", method_getName(classMethod));
    }
    
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    
    NSLog(@"==========================================================");
    
    //协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    NSLog(@"==========================================================");
    
}

- (void)ivar{
    //Ivar 是表示实例变量的类型，其实际是一个指向objc_ivar结构体的指针
    //objc_property_t 是表示Object-C声明的属性的类型，其实际是指向objc_property结构体的指针
    //objc_property_attribute_t 定义了属性的特性（attribute）是一个结构体
    
    //SEL又叫选择器，是表示一个方法的selector的指针，
    //IMP 实际上是一个函数指针，指向方法实现的首地址
}




@end



