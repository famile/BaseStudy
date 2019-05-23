//
//  Person.m
//  ReackCodeDemo
//
//  Created by 李涛 on 2018/6/28.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void)eat1{
    NSLog(@"%s",__FUNCTION__);
}
- (void)sleep1{
    NSLog(@"%s",__FUNCTION__);
}


- (Person *)eat2{
    NSLog(@"%s",__FUNCTION__);
    return self;
}
- (Person *)sleep2{
    NSLog(@"%s",__FUNCTION__);
    return self;
}

- (void(^)(void))eat3{
    void(^eat3Block)(void) = ^{
        NSLog(@"%s",__FUNCTION__);
    };
    return eat3Block;
}
- (void(^)(void))sleep3{
    void(^sleep3Block)(void) = ^{
        NSLog(@"%s",__FUNCTION__);
    };
    return sleep3Block;
}


- (Person *(^)(void))eat4{
    Person *(^eat4Block)(void) = ^{
        NSLog(@"%s",__FUNCTION__);
        return self;

    };
    return eat4Block;
}
- (Person *(^)(void))sleep4{
    
    return ^ {
        NSLog(@"%s",__FUNCTION__);
        return self;
    };
}

- (Person *(^)(NSString *))eat5{
    return ^(NSString *food){
        NSLog(@"我准备吃%@",food);
        return self;
    };
}

- (Person *(^)(NSInteger))sleep5{
    return ^(NSInteger hour){
        NSLog(@"我准备睡%@小时",@(hour));
        return self;
    };
}

@end
