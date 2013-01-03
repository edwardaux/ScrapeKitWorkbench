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

-(void)testSetVar {
	NSString *script = 
	@"@main\n"
	@"  setvar xxx myvar"
	;

	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	GHAssertEqualStrings([engine variableFor:@"myvar"], @"xxx", nil);
	GHAssertEqualStrings([engine variableFor:@"myvar2"], nil, nil);
}

@end
