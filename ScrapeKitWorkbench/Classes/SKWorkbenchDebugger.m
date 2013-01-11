//
//  SKWorkbenchDebugger.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 11/01/13.
//  Copyright (c) 2013 BlackDog Foundry. All rights reserved.
//

#import "SKWorkbenchDebugger.h"

@implementation SKWorkbenchDebugger

-(void)emitMessage:(NSString *)message {
	NSString *current = [[self consoleTextView] string];
	NSString *appended = [current stringByAppendingFormat:@"%@\n", message];
	[[self consoleTextView] setString:appended];
}

@end
