//
//  PlaygroundTestCase.h
//  PlaygroundsForTests
//
//  Created by Darren Clark on 2017-06-11.
//  Copyright © 2017 Darren Clark. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PlaygroundTestCase : XCTestCase

@property (class, readonly, nonnull) NSArray<NSString *> *testNames;

- (void)playgroundContent;
- (void)test:(NSString *)test block:(void(^)(void))block;

@end
