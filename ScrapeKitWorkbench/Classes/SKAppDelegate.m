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

@end
