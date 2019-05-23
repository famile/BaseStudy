//
//  XZDHook.h
//  RuntimeStudy
//
//  Created by 李涛 on 2019/5/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZDHook : NSObject

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;

@end

NS_ASSUME_NONNULL_END
