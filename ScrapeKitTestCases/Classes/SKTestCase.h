//
//  SKTestCase.h
//  ScrapeKitWorkbench
//
//  Created by Craig Edwards on 27/12/12.
//  Copyright (c) 2012 BlackDog Foundry. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import <ScrapeKit/ScrapeKit.h>

@interface XXAddress : NSObject
@property (nonatomic,strong) NSString *street;
@property (nonatomic,strong) NSString *suburb;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *postcode;
@end

@interface XXPhoto : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *url;
@end

@interface XXHouse : NSObject
@property (nonatomic,strong) XXAddress *address;
@property (nonatomic)        NSInteger bedrooms;
@property (nonatomic)        NSInteger bathrooms;
@property (nonatomic,strong) NSMutableArray *photos;
@end

@interface SKTestCase : GHTestCase

-(void)confirmValid:(NSString *)script;
-(void)confirmInvalid:(NSString *)script expectedError:(NSString *)expectedError;
-(SKEngine *)runScript:(NSString *)script usingData:(NSString *)data;

@end
