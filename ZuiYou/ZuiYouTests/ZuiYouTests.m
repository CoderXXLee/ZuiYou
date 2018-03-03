//
//  ZuiYouTests.m
//  ZuiYouTests
//
//  Created by mac on 2018/2/28.
//  Copyright © 2018年 le. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZYFeaturedService.h"

@interface ZuiYouTests : XCTestCase

@end

@implementation ZuiYouTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    [ZYFeaturedService recommend];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
