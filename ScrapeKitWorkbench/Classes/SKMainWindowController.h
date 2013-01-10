//
//  SKMainWindowController.h
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 10/01/13.
//  Copyright (c) 2013 BlackDog Foundry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SKMainWindowController : NSWindowController

@property (assign) IBOutlet NSTextView *scriptTextView;
@property (assign) IBOutlet NSTextView *dataTextView;
@property (assign) IBOutlet NSButton *scrapeButton;
@property (assign) IBOutlet NSTextView *consoleTextView;

-(IBAction)startScrape:(id)sender;

@end
