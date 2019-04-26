//
//  SingleLinkedListTest.m
//  DataStructureTests
//
//  Created by 李涛 on 2019/4/15.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LinkedListNode.h"
#import "SingleLinkedList.h"

@interface SingleLinkedListTest : XCTestCase

@property (nonatomic, strong) NSArray *nodeArr;
@property (nonatomic, strong) SingleLinkedList *linkList;

@end

@implementation SingleLinkedListTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    LinkedListNode *node1 = [LinkedListNode nodeWithValue:1];
    LinkedListNode *node2 = [LinkedListNode nodeWithValue:2];
    LinkedListNode *node3 = [LinkedListNode nodeWithValue:3];
    LinkedListNode *node4 = [LinkedListNode nodeWithValue:4];
    LinkedListNode *node5 = [LinkedListNode nodeWithValue:5];
    node1.next = node2;
    node2.next = node3;
    node3.next = node4;
    node4.next = node5;
    
    _linkList = [SingleLinkedList linkListWithHead:node1];
    _nodeArr = @[node1,node2,node3,node4,node5];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testReversal{
    SingleLinkedList *reLinkedList = [_linkList reversal];
    NSLog(@"%@",@(reLinkedList.head.value));
}

- (void)testAddNode{
    [_linkList addNode:[LinkedListNode nodeWithValue:6]];
    NSLog(@"%@",@(_linkList.head.value));
}

- (void)testInsertNode{
    
    [_linkList insertNode:[LinkedListNode nodeWithValue:4.5] afterValue:4];
    NSLog(@"%@",@(_linkList.head.value));
}

- (void)testRemoveNode{
    //删除倒数第二个节点
    [_linkList removeNodeLastIndex:5];
    NSLog(@"%@",@(_linkList.head.value));
}

- (void)testMiddleNode{
    LinkedListNode *node = [_linkList middleNode];
    NSLog(@"%@",@(node.value));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
