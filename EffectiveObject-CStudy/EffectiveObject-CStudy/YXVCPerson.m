//
//  YXVCPerson.m
//  EffectiveObject-CStudy
//
//  Created by 李涛 on 2017/5/19.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "YXVCPerson.h"

@implementation YXVCPerson

- (id)copyWithZone:(NSZone *)zone{
    
    YXVCPerson *copy = [[self class] allocWithZone:zone];
    return copy;
}


@end
