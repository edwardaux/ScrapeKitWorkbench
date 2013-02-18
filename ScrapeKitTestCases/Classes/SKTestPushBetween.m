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
	@"  iffailure end\n"
	@":loop\n"
	@"  popIntoVar elements\n"
	@"  pushbetween <li> exclude </li> exclude\n"
	@"  iffailure end\n"
	@"  goto loop\n"
	@":end\n"
	;
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSMutableArray *elements = [engine variableFor:@"elements"];
	GHAssertEquals([elements count], (NSUInteger)3, nil);
	GHAssertEqualStrings(elements[0], @"abc", nil);
	GHAssertEqualStrings(elements[1], @"def", nil);
	GHAssertEqualStrings(elements[2], @"ghi", nil);
}

-(void)testPushBetween2 {
	NSString *data =
	@"<table>\n"
	@"  <tr><td>00</td><td>01</td></tr>\n"
	@"  <tr><td>10</td><td>11</td></tr>\n"
	@"  <tr><td>20</td><td>21</td></tr>\n"
	@"</table>\n"
	;
	
	NSString *script =
	@"@main\n"
	@"  createvar NSMutableArray rows\n"
	@"  pushbetween <tr> exclude </tr> exclude\n"
	@"  iffailure end\n"
	@":loop\n"
	@"  invoke handleRow\n"
	@"  pop\n"
	@"  pushbetween <tr> exclude </tr> exclude\n"
	@"  iffailure end\n"
	@"  goto loop\n"
	@":end\n"
	@"\n"
	@"@handleRow\n"
	@"  createvar NSMutableArray cells\n"
	@"  pushbetween <td> exclude </td> exclude\n"
	@"  iffailure end\n"
	@":loop\n"
	@"  popIntoVar cells\n"
	@"  pushbetween <td> exclude </td> exclude\n"
	@"  iffailure end\n"
	@"  goto loop\n"
	@":end\n"
	@"  assignvar cells rows\n"
	;
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSMutableArray *elements = [engine variableFor:@"rows"];
	GHAssertEquals([elements count], (NSUInteger)3, nil);
	GHAssertEqualStrings(elements[0][0], @"00", nil);
	GHAssertEqualStrings(elements[0][1], @"01", nil);
	GHAssertEqualStrings(elements[1][0], @"10", nil);
	GHAssertEqualStrings(elements[1][1], @"11", nil);
	GHAssertEqualStrings(elements[2][0], @"20", nil);
	GHAssertEqualStrings(elements[2][1], @"21", nil);
}

@end
