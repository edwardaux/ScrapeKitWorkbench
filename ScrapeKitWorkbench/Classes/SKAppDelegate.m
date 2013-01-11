//
//  SKAppDelegate.m
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 21/12/12.
//  Copyright (c) 2012 BlackDog Foundry. All rights reserved.
//

#import "SKAppDelegate.h"
#import "SKMainWindowController.h"

@interface SKAppDelegate ()
@property (nonatomic, strong) SKMainWindowController *mainWindowController;
@end

@implementation SKAppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self setMainWindowController:[[SKMainWindowController alloc] init]];
	[[[self mainWindowController] window] makeKeyAndOrderFront:nil];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
	NSString *script = [[[self mainWindowController] scriptTextView] string];
	NSString *data = [[[self mainWindowController] dataTextView] string];
	[[NSUserDefaults standardUserDefaults] setValue:script forKey:@"script"];
	[[NSUserDefaults standardUserDefaults] setValue:data forKey:@"data"];
	return NSTerminateNow;
}

@end
