//
//  NSObject+Swizzling.h
//  BaseStudy
//
//  Created by 李涛 on 2018/11/9.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END

