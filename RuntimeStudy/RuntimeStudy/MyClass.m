//
//  MyClass.m
//  RuntimeStudy
//
//  Created by 李涛 on 2017/5/15.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "MyClass.h"
#import <objc/runtime.h>

static NSMutableDictionary *map = nil;

@interface MyClass (){
    NSInteger   _instance1;
    NSInteger * _instance2;
    
}

@property (nonatomic, assign) NSUInteger integer;

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;

@end

@implementation MyClass 

+ (void)classMethod1{
    
}

- (void)method1{
    NSLog(@"call method method1");
}

- (void)method2{
    
}

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2{
    NSLog(@"arg1: %ld, arg2: %@",arg1,arg2);
}

- (void)setDataWithDic:(NSDictionary *)dic{
    
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        NSString *propertyKey = [self propertyForKey:key];
        if (propertyKey)
        {
            objc_property_t property = class_getProperty([self class], [propertyKey UTF8String]);
            // TODO: 针对特殊数据类型做处理
            NSString *attributeString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            
            [self setValue:obj forKey:propertyKey];
        }
    }];
}
- (NSString *)propertyForKey:(NSString *)key{
    return [map objectForKey:key];
}


@end
