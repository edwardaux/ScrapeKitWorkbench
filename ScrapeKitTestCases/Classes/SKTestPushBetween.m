//
//  SKTestPushBetween.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 8/01/13.
//  Copyright (c) 2013 BlackDog Foundry. All rights reserved.
//

#import "SKTestCase.h"
#import <ScrapeKit/ScrapeKit.h>

@interface SKTestPushBetween : SKTestCase
@end

@implementation SKTestPushBetween

-(void)testPushBetween1 {
	NSString *data =
	@"<ol>\n"
	@"  <li>abc</li>\n"
	@"  <li>def</li>\n"
	@"  <li>ghi</li>\n"
	@"</ol>\n"
	;
	
	NSString *script =
	@"@main\n"
	@"  createvar NSMutableArray elements\n"
	@"  pushbetween <li> exclude </li> exclude\n"
	@"  iffailure :end\n"
	@":loop\n"
	@"  popIntoVar elements\n"
	@"  pushbetween <li> exclude </li> exclude\n"
	@"  iffailure :end\n"
	@"  goto :loop\n"
	@":end\n"
	;
	
	[XXAddress alloc];
	SKEngine *engine = [self runScript:script usingData:data];
	NSMutableArray *elements = [engine variableFor:@"elements"];
	GHAssertEquals([elements count], (NSUInteger)3, nil);
	GHAssertEqualStrings(elements[0], @"abc", nil);
	GHAssertEqualStrings(elements[1], @"def", nil);
	GHAssertEqualStrings(elements[2], @"ghi", nil);
}

//-(void)testPushBetween2 {
//	NSString *data =
//	@"<table>\n"
//	@"  <tr><td>col00</td><td>col01</td></tr>\n"
//	@"  <tr><td>col10</td><td>col11</td></tr>\n"
//	@"</table>\n"
//	;
//	
//	NSString *script =
//	@"@main\n"
//	@"  pushbetween <tr> exclude </tr> exclude\n"
//	@"  iffailure :end\n"
//	@":loop\n"
//	@"  pushbetween NSMutableDictionary mydict\n"
//	@"  createvar NSMutableArray myarray\n"
//	@"  createvar XXHouse myhouse\n"
//  @"  createvar XXDoesntExist xxx\n"
//	@":end\n"
//	@"\n"
//	@"@handlerow\n"
//  @"  createvar XXDoesntExist xxx\n"
//	;
//	
//	[XXAddress alloc];
//	SKEngine *engine = [self runScript:script usingData:data];
//	GHAssertTrue([[engine variableFor:@"mydict"] isKindOfClass:[NSMutableDictionary class]], nil);
//	GHAssertTrue([[engine variableFor:@"myarray"] isKindOfClass:[NSMutableArray class]], nil);
//	GHAssertTrue([[engine variableFor:@"myhouse"] isKindOfClass:[XXHouse class]], nil);
//	GHAssertNil([engine variableFor:@"xxx"], nil);
//}


@end
