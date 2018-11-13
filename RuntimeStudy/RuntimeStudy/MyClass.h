//
//  MyClass.h
//  RuntimeStudy
//
//  Created by 李涛 on 2017/5/15.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject<NSCopying,NSCoding>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;

- (void)method1;
- (void)method2;
+ (void)classMethod1;

@end
