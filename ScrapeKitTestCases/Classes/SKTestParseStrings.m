//
//  SKTestParseStrings.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 16/01/13.
//  Copyright (c) 2013 BlackDog Foundry. All rights reserved.
//

#import "SKTestCase.h"
#import <ScrapeKit/ScrapeKit.h>

@interface SKTestParseStrings : SKTestCase
@end

// declare this private method so compiler is quiet
@interface SKEngine ()
-(NSArray *)tokenizeRule:(NSString *)paramString error:(NSError **)error;
@end

@implementation SKTestParseStrings

-(void)invokeAndCheck:(NSString *)input expected:(NSArray *)expected {
	NSError *error = nil;
	SKEngine *engine = [[SKEngine alloc] init];
	NSArray *tokens = [engine tokenizeRule:input error:&error];
	GHAssertEqualObjects(tokens, expected, nil);
}

-(void)testSimple {
	[self invokeAndCheck:@"a"       expected:@[ @"a" ]];
	[self invokeAndCheck:@"aaa"     expected:@[ @"aaa" ]];
	[self invokeAndCheck:@"a b"     expected:@[ @"a", @"b" ]];
	[self invokeAndCheck:@" a b"    expected:@[ @"a", @"b" ]];
	[self invokeAndCheck:@"  a b"   expected:@[ @"a", @"b" ]];
	[self invokeAndCheck:@"a   b"   expected:@[ @"a", @"b" ]];
	[self invokeAndCheck:@"  a b  " expected:@[ @"a", @"b" ]];

	[self invokeAndCheck:@"\"a\""         expected:@[ @"a" ]];
	[self invokeAndCheck:@"\"aaa\""       expected:@[ @"aaa" ]];
	[self invokeAndCheck:@"\"a\" b"       expected:@[ @"a", @"b" ]];
	[self invokeAndCheck:@" a \"b\""      expected:@[ @"a", @"b" ]];
	[self invokeAndCheck:@"  \"a\" \"b\"" expected:@[ @"a", @"b" ]];
	
	[self invokeAndCheck:@"\"a\\\"b\""      expected:@[ @"a\\\"b" ]];
	[self invokeAndCheck:@"\"a\\\"b \\\"\"" expected:@[ @"a\\\"b \\\"" ]];
	[self invokeAndCheck:@"\"a\" \"b\""     expected:@[ @"a", @"b" ]];
	
}

@end
