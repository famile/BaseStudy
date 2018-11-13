//
//  BaseModel.h
//  BaseStudy
//
//  Created by 李涛 on 2018/7/31.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseTestDelegate<NSObject>

- (void)implementProtocol;

@end

@protocol BaseModelDelegate<NSObject>

@property (nonatomic, copy) NSString *className;

@end

@interface BaseModel : NSObject<BaseModelDelegate>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, weak) id<BaseTestDelegate> delegate;

@property (nonatomic, copy) void(^blockTest)(int);

- (void)test;

@end
