//
//  MultiInheritModel.h
//  BaseStudy
//
//  Created by 李涛 on 2018/8/1.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol protocol1<NSObject>

- (void)protocol1;

@end

@protocol protocol2<NSObject>

- (void)protocol2;

@end

@protocol protocol3<NSObject>

- (void)protocol3;

@end

@interface MultiInheritModel : NSObject<protocol1,protocol2,protocol3>

@end
