//
//  NSObject+Json.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "NSObject+Json.h"
#import <objc/runtime.h>
@implementation NSObject (Json)

+ (instancetype)mj_objectWithJson:(NSDictionary *)json {
    id obj = [[self alloc] init];
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
        [name deleteCharactersInRange:(NSMakeRange(0, 1))];
    }
    free(ivars);
    return obj;
}

@end
