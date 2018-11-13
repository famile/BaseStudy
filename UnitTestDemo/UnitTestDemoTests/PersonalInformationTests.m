//
//  PersonalInformationTests.m
//  UnitTestDemoTests
//
//  Created by 李涛 on 2018/8/8.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ResponsePersonalInformation.h"
@interface PersonalInformationTests : XCTestCase

@end

@implementation PersonalInformationTests


/**
 单元测试开始前使用
 */
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

/**
 单元测试结束前调用
 */
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 测试代码可以写到test开头的方法中，并且test开头的方法左边会生成一个菱形图标，点击即可运行监测当前test方法内的代码
 */
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPersonalInformationAge{
    ResponsePersonalInformation *response = [[ResponsePersonalInformation alloc] init];
    response.age = @"110";
    [self checkAge:response];
}

- (void)checkAge:(ResponsePersonalInformation *)response{
    
    XCTAssert([response.age integerValue] >0 && [response.age integerValue] <= 110 , @"姓名不合法---0<age<=110认为是合法年龄");
    XCTAssertEqual(response.age, @"110",@"age应该是110");
//    XCTAssertNotEqual(response.age, @"110",@"age不应该是110");
}

/**
 测试性能
 */
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
