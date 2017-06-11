//
//  PlaygroundTestCase.m
//  PlaygroundsForTests
//
//  Created by Darren Clark on 2017-06-11.
//  Copyright © 2017 Darren Clark. All rights reserved.
//

#import "PlaygroundTestCase.h"
#import <objc/runtime.h>

@implementation PlaygroundTestCase
{
    NSString *currentTest;
}

static NSMutableArray *allTestNames = nil;

+ (NSArray<NSInvocation *> *)testInvocations
{
    allTestNames = [NSMutableArray array];
    [[[self alloc] init] playgroundContent];

    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSString *name in allTestNames) {
        [result addObject:[self addTestInvocation:name]];
    }
    return result;
}

+ (NSInvocation *)addTestInvocation:(NSString *)testName
{
    IMP testImplemenation = [self instanceMethodForSelector:@selector(runTestForName:)];
    SEL selector = [self getSelectorName:testName];

    class_addMethod(self, selector, testImplemenation, "v@:@");

    NSMethodSignature *sig = [self instanceMethodSignatureForSelector:@selector(runTestForName:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];

    invocation.selector = selector;
    [invocation setArgument:&testName atIndex:2];
    [invocation retainArguments];

    return invocation;
}

+ (SEL)getSelectorName:(NSString *)testName
{
    char *selName = strdup([testName UTF8String]);
    for (int i = 0; i < strlen(selName); i++) {
        char ch = selName[i];
        if (ch >= 'a' && ch <= 'z') {
            continue;
        }
        else if (ch >= 'A' && ch <= 'Z') {
            continue;
        }
        else if (i > 0 && ch >= '0' && ch <= '9') {
            continue;
        }
        else {
            selName[i] = '_';
        }
    }
    SEL sel = sel_registerName(selName);
    free(selName);
    return sel;
}

#pragma mark -

- (void)runTestForName:(NSString *_Nonnull )name
{
    currentTest = name;
    [self playgroundContent];
    currentTest = nil;
}

- (void)playgroundContent
{
    XCTFail(@"Should be overriden");
}

- (void)test:(NSString *)test block:(void(^)(void))block
{
    if (currentTest == nil) {
        // in test discovery currently
        [allTestNames addObject:test];
    }
    else if ([currentTest isEqualToString:test]) {
        // running a test
        block();
    }
}

@end
