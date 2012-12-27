//
//  SKTestCase.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 27/12/12.
//  Copyright (c) 2012 BlackDog Foundry. All rights reserved.
//

#import "SKTestCase.h"

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

@end
