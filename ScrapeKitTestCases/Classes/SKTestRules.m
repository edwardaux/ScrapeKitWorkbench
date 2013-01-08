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
	id value = [engine variableFor:@"array"];
	// note that NSArray is not supported (only NSMutableArray), therefore
	// the engine will just replace the existing variable with the new one
	GHAssertTrue([value isKindOfClass:[NSString class]], nil);
	GHAssertEqualStrings(value, @"three", nil);
}

-(void)testMutableDictionary {
	NSString *script =
	@"@main\n"
	@"  createvar NSMutableDictionary dict\n"
	@"  setvar one dict a\n"
	@"  setvar two dict b\n"
	@"  setvar three dict c\n"
	@"  setvar four dict\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	id dict = [engine variableFor:@"dict"];
	GHAssertTrue([dict isKindOfClass:[NSMutableDictionary class]], nil);
	GHAssertEquals([dict count], (NSUInteger)3, nil);
	GHAssertEqualStrings(dict[@"a"], @"one", nil);
	GHAssertEqualStrings(dict[@"b"], @"two", nil);
	GHAssertEqualStrings(dict[@"c"], @"three", nil);
}

-(void)testObject {
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

-(void)testObjectComplex {
	NSString *script =
	@"@main\n"
	@"  # Create the array to hold all the houses\n"
	@"  createvar NSMutableArray houses\n"
	@"	"
	@"  # Create a new house\n"
	@"  createvar XXHouse house\n"
	@"  setvar 1 house bedrooms\n"
	@"  setvar 2 house bathrooms\n"
	@"	"
	@"  # Create a new address\n"
	@"  createvar XXAddress addr\n"
	@"  setvar Sunset addr street\n"
	@"  setvar Hollywood addr suburb\n"
	@"  setvar CA addr state\n"
	@"  setvar 90210 addr postcode\n"
	@"  assignvar addr house address\n"
	@"	"
	@"  # Create a couple of photos\n"
	@"  createvar NSMutableArray photos\n"
	@"  assignvar photos house photos\n"
	@"  createvar XXPhoto photo\n"
	@"  setvar t1 photo title\n"
	@"  setvar u1 photo url\n"
	@"  assignvar photo house photos\n"
	@"  createvar XXPhoto photo\n"
	@"  setvar t2 photo title\n"
	@"  setvar u2 photo url\n"
	@"  assignvar photo house photos\n"
	@"	"
	@"  # And now add the house to the array\n"
	@"  assignvar house houses\n"
	@"	"
	@"  # Create a second house\n"
	@"  createvar XXHouse house\n"
	@"  setvar 3 house bedrooms\n"
	@"  setvar 4 house bathrooms\n"
	@"	"
	@"  # Create a new address\n"
	@"  createvar XXAddress addr\n"
	@"  setvar Railway addr street\n"
	@"  setvar Dallas addr suburb\n"
	@"  setvar TX addr state\n"
	@"  setvar 12345 addr postcode\n"
	@"  assignvar addr house address\n"
	@"	"
	@"  # Create a single photo\n"
	@"  createvar NSMutableArray photos\n"
	@"  assignvar photos house photos\n"
	@"  createvar XXPhoto p1\n"
	@"  setvar t3 p1 title\n"
	@"  setvar u3 p1 url\n"
	@"  assignvar p1 house photos\n"
	@"	"
	@"  # And now add the house to the array\n"
	@"  assignvar house houses\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSArray *houses = [engine variableFor:@"houses"];
	GHAssertEquals([houses count], (NSUInteger)2, nil);

	GHAssertEquals([houses[0] bedrooms], (NSInteger)1, nil);
	GHAssertEquals([houses[0] bathrooms], (NSInteger)2, nil);
	XXAddress *address = [(XXHouse *)houses[0] address];
	GHAssertEqualStrings([address street], @"Sunset", nil);
	GHAssertEqualStrings([address suburb], @"Hollywood", nil);
	GHAssertEqualStrings([address state], @"CA", nil);
	GHAssertEqualStrings([address postcode], @"90210", nil);
	NSArray *photos = [houses[0] photos];
	GHAssertEquals([photos count], (NSUInteger)2, nil);
	GHAssertEqualStrings([photos[0] title], @"t1", nil);
	GHAssertEqualStrings([photos[0] url], @"u1", nil);
	GHAssertEqualStrings([photos[1] title], @"t2", nil);
	GHAssertEqualStrings([photos[1] url], @"u2", nil);
	
	GHAssertEquals([houses[1] bedrooms], (NSInteger)3, nil);
	GHAssertEquals([houses[1] bathrooms], (NSInteger)4, nil);
	address = [(XXHouse *)houses[1] address];
	GHAssertEqualStrings([address street], @"Railway", nil);
	GHAssertEqualStrings([address suburb], @"Dallas", nil);
	GHAssertEqualStrings([address state], @"TX", nil);
	GHAssertEqualStrings([address postcode], @"12345", nil);
	photos = [houses[1] photos];
	GHAssertEquals([photos count], (NSUInteger)1, nil);
	GHAssertEqualStrings([photos[0] title], @"t3", nil);
	GHAssertEqualStrings([photos[0] url], @"u3", nil);
}

-(void)testIf1 {
	NSString *script =
	@"@main\n"
	@"  createvar Blah wontwork\n"
	@"  ifsuccess :success\n"
  @"  setvar OK text\n"
	@"  goto :end\n"
	@":success\n"
  @"  setvar WRONG text\n"
	@":end\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSString *text = [engine variableFor:@"text"];
	GHAssertEqualStrings(text, @"OK", nil);
}

-(void)testIf2 {
	NSString *script =
	@"@main\n"
	@"  createvar Blah wontwork\n"
	@"  iffailure :failure\n"
  @"  setvar WRONG text\n"
	@"  goto :end\n"
	@":failure\n"
  @"  setvar OK text\n"
	@":end\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSString *text = [engine variableFor:@"text"];
	GHAssertEqualStrings(text, @"OK", nil);
}

-(void)testIf3 {
	NSString *script =
	@"@main\n"
	@"  createvar NSString willwork\n"
	@"  ifsuccess :success\n"
  @"  setvar WRONG text\n"
	@"  goto :end\n"
	@":success\n"
  @"  setvar OK text\n"
	@":end\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSString *text = [engine variableFor:@"text"];
	GHAssertEqualStrings(text, @"OK", nil);
}

-(void)testIf4 {
	NSString *script =
	@"@main\n"
	@"  createvar NSString willwork\n"
	@"  iffailure :failure\n"
  @"  setvar OK text\n"
	@"  goto :end\n"
	@":failure\n"
  @"  setvar WRONG text\n"
	@":end\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSString *text = [engine variableFor:@"text"];
	GHAssertEqualStrings(text, @"OK", nil);
}

-(void)testFunction1 {
	NSString *script =
	@"@main\n"
	@"  invoke func\n"
	@"\n"
	@"@func\n"
	@"  setvar one a\n"
	@"  setvar two b\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSString *a = [engine variableFor:@"a"];
	NSString *b = [engine variableFor:@"b"];
	GHAssertEqualStrings(a, @"one", nil);
	GHAssertEqualStrings(b, @"two", nil);
}


-(void)testFunction2 {
	NSString *script =
	@"@main\n"
	@"  invoke func1\n"
	@"  invoke func2\n"
	@"\n"
	@"@func1\n"
	@"  setvar one a\n"
	@"  setvar two b\n"
	@"\n"
	@"@func2\n"
	@"  setvar three a\n"
	@"  setvar four b\n"
	;
	
	NSString *data = @"";
	
	SKEngine *engine = [self runScript:script usingData:data];
	NSString *a = [engine variableFor:@"a"];
	NSString *b = [engine variableFor:@"b"];
	GHAssertEqualStrings(a, @"three", nil);
	GHAssertEqualStrings(b, @"four", nil);
}



@end
