//
//  LinkedListNode.h
//  DataStructure
//
//  Created by 李涛 on 2019/4/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LinkedListNode : NSObject

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, strong) LinkedListNode *next;

+ (LinkedListNode *)nodeWithValue:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END
