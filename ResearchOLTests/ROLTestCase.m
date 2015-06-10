//
//  ROLTestCase.m
//  ResearchOL
//
//  Created by Joshua on 15/6/3.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ResearchOLTests-swift.h"

@interface ROLTestCase : XCTestCase

@end

@implementation ROLTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample {
//    // This is an example of a functional test case.
//    XCTAssert(YES, @"Pass");
//}
//
//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (void)testGetQuestionare {
    XCTestExpectation *exp = [self expectationWithDescription:@"5"];
    [[ROLQuestionManager sharedManager] getQuestionares:5 success:^{
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if ([ROLQuestionManager sharedManager].questionares.count != 5) {
            XCTFail(@"error");
        }
    }];
}

- (void)testGetQuestions {
    XCTestExpectation *exp = [self expectationWithDescription:@"5"];
    ROLQuestionare *questionare = [[ROLQuestionare alloc] init];
    questionare.uuid = @"-Jn5DezX4eGo-qh3bDVJ";
    [[ROLQuestionManager sharedManager] getQuestions:9 questionare:questionare success:^{
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (questionare.questions.count < 1) {
            XCTFail(@"error");
        }
    }];
}

- (void)testSetAnswerForIndex {
    ROLAnswer *answer = [[ROLAnswer alloc] init];
    answer.type = 1;
    [[ROLQuestionManager sharedManager] setAnswer:answer index:0];
    if ([[[ROLQuestionManager sharedManager] answers] objectForKey:@0] != answer) {
        XCTFail(@"error");
    }
}
 

@end
