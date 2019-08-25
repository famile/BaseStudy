//
//  LTProxy.h
//  BaseStudy
//
//  Created by 李涛 on 2019/8/20.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTProxy : NSObject

+ (instancetype)initWithTarget:(id)target;

@property (nonatomic, weak) id target;


@end

NS_ASSUME_NONNULL_END
