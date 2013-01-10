//
//  SKMainWindowController.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 10/01/13.
//  Copyright (c) 2013 BlackDog Foundry. All rights reserved.
//

#import "SKMainWindowController.h"
#import "SKWorkbenchDebugger.h"
#import <ScrapeKit/ScrapeKit.h>

@interface SKMainWindowController ()

@end

@implementation SKMainWindowController

-(id)init {
	self = [super initWithWindowNibName:NSStringFromClass([self class]) owner:self];
	if (self != nil) {
		
	}
	return self;
}

-(IBAction)startScrape:(id)sender {
	NSError *error = nil;
	SKEngine *engine = [[SKEngine alloc] init];
	
	SKWorkbenchDebugger *debugger = [[SKWorkbenchDebugger alloc] init];
	[debugger setConsoleTextView:[self consoleTextView]];
	[engine setDebugger:debugger];
	
	if (![engine compile:[[self scriptTextView] string] error:&error]) {
		[[self consoleTextView] setString:[error localizedDescription]];
	}
	else {
		[engine parse:[[self dataTextView] string]];
	}
}

@end
