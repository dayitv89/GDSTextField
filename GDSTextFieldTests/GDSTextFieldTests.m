//
//  GDSTextFieldTests.m
//  GDSTextFieldTests
//
//  Created by gauravds on 4/30/15.
//  Copyright (c) 2015 punchh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface GDSTextFieldTests : XCTestCase
@property (nonatomic) ViewController *viewC;
@end

@implementation GDSTextFieldTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddingSuccess {
    XCTAssertEqual(15, [self.viewC addTwoNumbersA:5 intB:10]);
}

- (void)testAddingFail {
    XCTAssertEqual(16, [self.viewC addTwoNumbersA:5 intB:10]);
}


@end
