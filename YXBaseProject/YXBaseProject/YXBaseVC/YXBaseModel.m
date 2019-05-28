//
//  YXBaseModel.m
//  YXVC
//
//  Created by 李涛 on 2017/6/14.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "YXBaseModel.h"
#import "MJExtension.h"
@implementation YXBaseModel
MJExtensionCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end
