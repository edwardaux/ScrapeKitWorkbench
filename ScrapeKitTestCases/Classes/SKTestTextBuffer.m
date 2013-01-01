//
//  SKTestTextBuffer.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 28/12/12.
//  Copyright (c) 2012 BlackDog Foundry. All rights reserved.
//

#import "SKTestCase.h"
#import <ScrapeKit/ScrapeKit.h>

@interface SKTestTextBuffer : SKTestCase
@end

@implementation SKTestTextBuffer

-(void)testSimple {
	SKTextBuffer *buffer;
	
	buffer = [[SKTextBuffer alloc] initWithString:@"hello"];
	GHAssertEqualStrings([buffer stringValue], @"hello", nil);
	
	buffer = [[SKTextBuffer alloc] initWithString:@"hello" range:NSMakeRange(0, 5)];
	GHAssertEqualStrings([buffer stringValue], @"hello", nil);
	
	buffer = [[SKTextBuffer alloc] initWithString:@"hello" range:NSMakeRange(1, 4)];
	GHAssertEqualStrings([buffer stringValue], @"ello", nil);
	
	buffer = [[SKTextBuffer alloc] initWithString:@"hello" range:NSMakeRange(2, 2)];
	GHAssertEqualStrings([buffer stringValue], @"ll", nil);
}

-(void)testBetweenSimple {
	SKTextBuffer *buffer;
	
	buffer = [[SKTextBuffer alloc] initWithString:@"<a><b>c</b></a>"];
	GHAssertEqualStrings([[buffer betweenString1:@"<a>" include1:YES string2:@"</a>" include2:YES includeToEOF:NO] stringValue], @"<a><b>c</b></a>", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @"", nil);
	[buffer reset];
	GHAssertEqualStrings([[buffer betweenString1:@"<a>" include1:NO string2:@"</a>" include2:YES includeToEOF:NO] stringValue], @"<b>c</b></a>", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @"", nil);
	[buffer reset];
	GHAssertEqualStrings([[buffer betweenString1:@"<a>" include1:YES string2:@"</a>" include2:NO includeToEOF:NO] stringValue], @"<a><b>c</b>", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @"</a>", nil);
	[buffer reset];
	GHAssertEqualStrings([[buffer betweenString1:@"<a>" include1:NO string2:@"</a>" include2:NO includeToEOF:NO] stringValue], @"<b>c</b>", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @"</a>", nil);
}

-(void)testBetweenNotFound {
	SKTextBuffer *buffer;
	
	buffer = [[SKTextBuffer alloc] initWithString:@"<a><b>c</b></a>"];
	GHAssertEqualStrings([buffer betweenString1:@"<c>" include1:YES string2:@"</c>" include2:YES includeToEOF:NO], nil, nil);
	GHAssertEqualStrings([buffer remainingStringValue], @"<a><b>c</b></a>", nil);
	[buffer reset];
	GHAssertEqualStrings([buffer betweenString1:@"<a>" include1:YES string2:@"</c>" include2:YES includeToEOF:NO], nil, nil);
	GHAssertEqualStrings([buffer remainingStringValue], @"<a><b>c</b></a>", nil);
	[buffer reset];
	GHAssertEqualStrings([buffer betweenString1:@"<c>" include1:YES string2:@"</a>" include2:YES includeToEOF:NO], nil, nil);
	GHAssertEqualStrings([buffer remainingStringValue], @"<a><b>c</b></a>", nil);
}

-(void)testIncludeToEOF {
	SKTextBuffer *buffer;
	
	buffer = [[SKTextBuffer alloc] initWithString:@",a,b,c,d,e"];
	GHAssertEqualStrings([[buffer betweenString1:@"," include1:YES string2:@"," include2:NO includeToEOF:YES] stringValue], @",a", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @",b,c,d,e", nil);
	GHAssertEqualStrings([[buffer betweenString1:@"," include1:YES string2:@"," include2:NO includeToEOF:YES] stringValue], @",b", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @",c,d,e", nil);
	GHAssertEqualStrings([[buffer betweenString1:@"," include1:YES string2:@"," include2:NO includeToEOF:YES] stringValue], @",c", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @",d,e", nil);
	GHAssertEqualStrings([[buffer betweenString1:@"," include1:YES string2:@"," include2:NO includeToEOF:YES] stringValue], @",d", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @",e", nil);
	GHAssertEqualStrings([[buffer betweenString1:@"," include1:YES string2:@"," include2:NO includeToEOF:YES] stringValue], @",e", nil);
	GHAssertEqualStrings([buffer remainingStringValue], @"", nil);
	GHAssertEqualStrings([buffer betweenString1:@"," include1:YES string2:@"," include2:NO includeToEOF:YES], nil, nil);
}

@end
