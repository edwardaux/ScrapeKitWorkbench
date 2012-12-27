//
//  SKTestCompilation.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 27/12/12.
//  Copyright (c) 2012 BlackDog Foundry. All rights reserved.
//

#import "SKTestCase.h"
#import <ScrapeKit/ScrapeKit.h>

@interface SKTestCompilation : SKTestCase
@end

@implementation SKTestCompilation

-(void)testNoMain {
	NSString *script = @""
	@"@blah\n"
	@"	goto :end\n"
	@"	:end";
	
	[self confirmInvalid:script expectedError:@"No main function"];
}

-(void)testMissingFunction {
	NSString *script = @""
	@"	goto :end\n"
	@"	:end";
	
	[self confirmInvalid:script expectedError:@"Rule \"goto :end\" declared outside of a function"];
}

-(void)testEmptyFunction1 {
	NSString *script = @""
	@"@main\n";
	
	[self confirmValid:script];
}

-(void)testEmptyFunction2 {
	NSString *script = @""
	@"@main\n"
	@"@foo\n"
	@"	goto :end\n"
	@"	:end";
	
	[self confirmValid:script];
}

-(void)testNoTrailingCR1 {
	NSString *script = @""
	@"@main";
	
	[self confirmValid:script];
}

-(void)testNoTrailingCR2 {
	NSString *script = @""
	@"@main\n"
	@"	:end";
	
	[self confirmValid:script];
}

-(void)testTrailingCR {
	NSString *script = @""
	@"@main\n\n\n";
	
	[self confirmValid:script];
}

-(void)testWhitespace {
	NSString *script = @""
	@"@main\n"
	@":end1\n"
	@"\n"
	@"\t\n"
	@" \n"
	@" :end2\n"
	@"	:end3";
	
	[self confirmValid:script];
}

@end
