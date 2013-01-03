//
//  SKTestRules.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 3/01/13.
//  Copyright (c) 2013 BlackDog Foundry. All rights reserved.
//

#import "SKTestCase.h"
#import <ScrapeKit/ScrapeKit.h>

@interface SKTestRules : SKTestCase
@end

@implementation SKTestRules

-(void)testCreateVar {
	NSString *script =
	@"@main\n"
	@"  createvar NSMutableDictionary mydict\n"
	@"  createvar NSMutableArray myarray\n"
	@"  createvar XXHouse myhouse\n"
	@"  createvar XXDoesntExist xxx\n"
	;
	
	NSString *data = @"";
	[XXAddress alloc];
	SKEngine *engine = [self runScript:script usingData:data];
	GHAssertTrue([[engine variableFor:@"mydict"] isKindOfClass:[NSMutableDictionary class]], nil);
	GHAssertTrue([[engine variableFor:@"myarray"] isKindOfClass:[NSMutableArray class]], nil);
	GHAssertTrue([[engine variableFor:@"myhouse"] isKindOfClass:[XXHouse class]], nil);
	GHAssertNil([engine variableFor:@"xxx"], nil);
}

-(void)testSetVar {
	NSString *script =
	@"@main\n"
	@"  setvar xxx myvar1\n"
	@"  setvar yyy myvar2\n"
	@"  setvar yyy2 myvar2\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	GHAssertEqualStrings([engine variableFor:@"myvar1"], @"xxx", nil);
	GHAssertEqualStrings([engine variableFor:@"myvar2"], @"yyy2", nil);
	GHAssertNil([engine variableFor:@"myvar3"], nil);
}

-(void)testMutableArray {
	NSString *script =
	@"@main\n"
	@"  createvar NSMutableArray array\n"
	@"  setvar one array\n"
	@"  setvar two array\n"
	@"  setvar three array\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	id array = [engine variableFor:@"array"];
	GHAssertTrue([array isKindOfClass:[NSMutableArray class]], nil);
	GHAssertEquals([array count], (NSUInteger)3, nil);
	GHAssertEqualStrings(array[0], @"one", nil);
	GHAssertEqualStrings(array[1], @"two", nil);
	GHAssertEqualStrings(array[2], @"three", nil);
}

-(void)testArray {
	NSString *script =
	@"@main\n"
	@"  createvar NSArray array\n"
	@"  setvar one array\n"
	@"  setvar two array\n"
	@"  setvar three array\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	id array = [engine variableFor:@"array"];
	GHAssertTrue([array isKindOfClass:[NSArray class]], nil);
	GHAssertEquals([array count], (NSUInteger)0, nil);
}

-(void)testAssignVar {
	NSString *script =
	@"@main\n"
	@"  createvar XXAddress addr\n"
	@"  setvar Sunset addr street\n"
	@"  setvar Hollywood addr suburb\n"
	@"  setvar CA addr state\n"
	@"  setvar 90210 addr postcode\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	XXAddress *addr = [engine variableFor:@"addr"];
	GHAssertEqualStrings([addr street], @"Sunset", nil);
	GHAssertEqualStrings([addr suburb], @"Hollywood", nil);
	GHAssertEqualStrings([addr state], @"CA", nil);
	GHAssertEqualStrings([addr postcode], @"90210", nil);
}


@end
