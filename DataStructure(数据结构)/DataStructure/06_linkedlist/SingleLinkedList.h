//
//  SingleLinkedList.h
//  DataStructure
//
//  Created by 李涛 on 2019/4/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LinkedListNode;
NS_ASSUME_NONNULL_BEGIN

@interface SingleLinkedList : NSObject

@property (nonatomic, strong) LinkedListNode *head;


+ (SingleLinkedList *)linkListWithHead:(LinkedListNode *)head;

/*
 单链表反转
 链表环的检测
 两个有序的链表的合并
 删除链表的倒数第n个节点
 求链表的中间节点
 */


- (SingleLinkedList *)reversal;

- (void)addNode:(LinkedListNode *)node;

- (void)insertNode:(LinkedListNode *)node afterValue:(CGFloat)value;

- (void)insertNode:(LinkedListNode *)node beforeValue:(CGFloat)value;
/** 移除倒数第n个节点 */
- (void)removeNodeLastIndex:(NSInteger)index;

- (LinkedListNode *)middleNode;

@end

NS_ASSUME_NONNULL_END
