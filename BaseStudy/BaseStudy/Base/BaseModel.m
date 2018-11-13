//
//  BaseModel.m
//  BaseStudy
//
//  Created by 李涛 on 2018/7/31.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "BaseModel.h"



@implementation BaseModel
@synthesize className = _className;

- (void)test{
    if (_delegate && [_delegate respondsToSelector:@selector(implementProtocol)]) {
        [_delegate implementProtocol];
    }
    
    if (self.blockTest) {
        self.blockTest(1);
    }
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


@end
