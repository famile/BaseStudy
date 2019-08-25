//
//  NSObject+Json.h
//  BaseStudy
//
//  Created by 李涛 on 2019/8/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Json)

+ (instancetype)mj_objectWithJson:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
