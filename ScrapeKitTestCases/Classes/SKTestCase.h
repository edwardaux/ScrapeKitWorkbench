//
//  SKTestCase.h
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 27/12/12.
//  Copyright (c) 2012 BlackDog Foundry. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import <ScrapeKit/ScrapeKit.h>

@interface SKTestCase : GHTestCase

-(void)confirmValid:(NSString *)script;
-(void)confirmInvalid:(NSString *)script expectedError:(NSString *)expectedError;

@end
