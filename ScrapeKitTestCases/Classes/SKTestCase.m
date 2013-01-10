//
//  SKTestCase.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 27/12/12.
//  Copyright (c) 2012 BlackDog Foundry. All rights reserved.
//

#import "SKTestCase.h"

@implementation XXAddress
@end

@implementation XXPhoto
@end

@implementation XXHouse
@end

@implementation SKBreakpointRule
-(BOOL)executeInFrame:(SKFrame *)frame function:(SKFunction *)function engine:(SKEngine *)engine {
	return YES;
}
@end

@implementation SKTestCase

-(void)confirmValid:(NSString *)script {
	NSError *error;
	SKEngine *engine = [[SKEngine alloc] init];
	
	if (![engine compile:script error:&error])
		GHFail([NSString stringWithFormat:@"Expected to compile, but got \"%@\"", [error localizedDescription]]);
}

-(void)confirmInvalid:(NSString *)script expectedError:(NSString *)expectedError {
	NSError *error;
	SKEngine *engine = [[SKEngine alloc] init];
	
	if ([engine compile:script error:&error])
		GHFail(@"Expected compilation error but somehow compiled");
	else {
		GHAssertEqualStrings([error localizedDescription], expectedError, nil);
	}
}

-(SKEngine *)runScript:(NSString *)script usingData:(NSString *)data {
	SKEngine *engine = [[SKEngine alloc] init];
	[engine addRuleImplementationClass:[SKBreakpointRule class] forVerb:@"BREAK"];
	[engine setDebugger:[[SKConsoleDebugger alloc] init]];
	
	NSError *error = NULL;
	if (![engine compile:script error:&error])
		GHFail([NSString stringWithFormat:@"Expected to compile, but got \"%@\"", [error localizedDescription]]);

	[engine parse:data];
	return engine;
}

@end
