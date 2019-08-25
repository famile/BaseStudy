//
//  LTPerson.h
//  BaseStudy
//
//  Created by 李涛 on 2019/8/5.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyBlock)(void);

@interface LTPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) MyBlock block;


- (void)test;
- (void)unregisterFunc;
- (void)unrecognizedFunc;

@end

NS_ASSUME_NONNULL_END
