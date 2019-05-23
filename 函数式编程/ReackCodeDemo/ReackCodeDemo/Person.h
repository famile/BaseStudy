//
//  Person.h
//  ReackCodeDemo
//
//  Created by 李涛 on 2018/6/28.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (void)eat1;
- (void)sleep1;


- (Person *)eat2;
- (Person *)sleep2;

- (void(^)(void))eat3;
- (void(^)(void))sleep3;

- (Person *(^)(void))eat4;
- (Person *(^)(void))sleep4;

- (Person *(^)(NSString *))eat5;
- (Person *(^)(NSInteger))sleep5;

@end
