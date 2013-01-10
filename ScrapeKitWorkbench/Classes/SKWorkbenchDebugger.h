//
//  SKWorkbenchDebugger.h
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 11/01/13.
//  Copyright (c) 2013 BlackDog Foundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ScrapeKit/ScrapeKit.h>

@interface SKWorkbenchDebugger : SKConsoleDebugger

@property (nonatomic,assign) NSTextView *consoleTextView;

@end
