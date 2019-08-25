//
//  NSObject+test1.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/2.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "NSObject+test1.h"
#import <objc/runtime.h>

@implementation NSObject (test1)
- (void)test{
    NSLog(@"NSObject (test1) - test");
}
//static const void * LTNameKey = &LTNameKey;
// 设置关联对象
//- (void)setName:(NSString *)name {
//    objc_setAssociatedObject(self, LTNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)name {
//    return objc_getAssociatedObject(self, LTNameKey);
//}

//static const char LTNameKey;
//
//// 设置关联对象
//- (void)setName:(NSString *)name {
//    objc_setAssociatedObject(self, &LTNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)name {
//    return objc_getAssociatedObject(self, &LTNameKey);
//}

//#define LTNameKey @"name"
//
//// 设置关联对象
//- (void)setName:(NSString *)name {
//    objc_setAssociatedObject(self, LTNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)name {
//    return objc_getAssociatedObject(self, LTNameKey);
//}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    // 当前方法的指针 _cmd = @selector(name)
    return objc_getAssociatedObject(self, _cmd);
}



@end
