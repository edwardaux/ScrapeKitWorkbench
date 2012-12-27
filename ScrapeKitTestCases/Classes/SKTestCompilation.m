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

@end
