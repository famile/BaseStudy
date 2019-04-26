//
//  LinkedListNode.m
//  DataStructure
//
//  Created by 李涛 on 2019/4/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "LinkedListNode.h"

@implementation LinkedListNode


+ (LinkedListNode *)nodeWithValue:(CGFloat)value{
    LinkedListNode *node = [[LinkedListNode alloc] init];
    node.value = value;
    return node;
}

@end
