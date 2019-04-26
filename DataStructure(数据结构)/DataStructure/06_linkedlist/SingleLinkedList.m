//
//  SingleLinkedList.m
//  DataStructure
//
//  Created by 李涛 on 2019/4/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "SingleLinkedList.h"
#import "LinkedListNode.h"

@implementation SingleLinkedList

+ (SingleLinkedList *)linkListWithHead:(LinkedListNode *)head{
    SingleLinkedList *linkList = [[SingleLinkedList alloc] init];
    linkList.head = head;
    return linkList;
}

- (SingleLinkedList *)reversal{
    if (_head == nil || _head.next == nil) {
        return self;
    }
    LinkedListNode *pre = nil;
    LinkedListNode *cur = _head;
    LinkedListNode *next = _head.next;

    while (next != nil) {
        cur.next = pre;
        pre = cur;
        cur = next;
        next = cur.next;
    }
    cur.next = pre;
    SingleLinkedList * singleLinkedList = [[SingleLinkedList alloc] init];
    singleLinkedList.head = cur;
    return singleLinkedList;
}


- (void)addNode:(LinkedListNode *)node{
    LinkedListNode *temp = _head;
    if (!temp) {
        _head = node;
    }else{
        while (temp.next) {
            temp = temp.next;
        }
        temp.next = node;
    }
}

- (void)insertNode:(LinkedListNode *)node afterValue:(CGFloat)value{
    if (_head) {
        LinkedListNode *curNode = _head;
        LinkedListNode *nextNode = _head.next;
        while (nextNode) {
            if (curNode.value == value) {
                curNode.next = node;
                node.next = nextNode;
                break;
            }else{
                curNode = nextNode;
                nextNode = nextNode.next;
            }
        }
    }
}

- (void)insertNode:(LinkedListNode *)node beforeValue:(CGFloat)value{
    if (_head) {
        LinkedListNode *preNode = nil;
        LinkedListNode *curNode = _head;
        
        while (curNode.next) {
            if(curNode.value == value){
                if (preNode) {
                    preNode.next = node;
                    node.next = curNode;
                }else{
                    node.next = curNode;
                    _head = node;
                }
                break;
            }else{
                preNode = curNode;
                curNode = curNode.next;
            }
        }
    }
}

- (void)removeNodeLastIndex:(NSInteger)index{
    NSMutableArray *nodeArr = [NSMutableArray array];
    if (_head) {
        LinkedListNode *curNode = _head;
        [nodeArr addObject:curNode];
        while (curNode.next) {
            [nodeArr addObject:curNode.next];
            if (nodeArr.count > index + 1) {
                [nodeArr removeObjectAtIndex:0];
            }
            curNode = curNode.next;
        }
        if (nodeArr.count == index) {//倒数第n个节点就是第一个节点
            _head = _head.next;
        }else if (nodeArr.count == index+1){
            LinkedListNode *preNode = nodeArr[0];
            LinkedListNode *curNode = nodeArr[1];
            preNode.next = curNode.next;
            curNode = nil;
        }
    }
}

- (LinkedListNode *)middleNode{
    LinkedListNode *slowNode = _head;
    LinkedListNode *fastNode = _head;
    while (fastNode) {
        if (fastNode.next) {
            fastNode = fastNode.next.next;
        }else{
            break;
        }
        slowNode = slowNode.next;
    }
    return slowNode;
}

@end
