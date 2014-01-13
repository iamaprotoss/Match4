//
//  LocalStorageManager.m
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "LocalStorageManager.h"

@implementation LocalStorageManager

@synthesize currentGame, stats;

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [self.currentGame release];
}

- (void)load
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *statsDic = [userDefault dictionaryForKey:@"stats"];
    if (statsDic) {
        self.stats = [StatsItem new];
        [self.stats initWithDictionary:statsDic];
    }
    
    NSDictionary *gameDic = [userDefault dictionaryForKey:@"currentGame"];
    if (gameDic) {
        self.currentGame = [GameItem new];
        [self.currentGame initWithDictionary:gameDic];
    }
}

- (void)synchronize
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (self.stats) {
        [userDefault setObject:[self.stats getDataInDictionary] forKey:@"stats"];
    } else {
        [userDefault removeObjectForKey:@"stats"];
    }

    if (self.currentGame) {
        [userDefault setObject:[self.currentGame getDataInDictionary] forKey:@"currentGame"];
    } else {
        [userDefault removeObjectForKey:@"currentGame"];
    }
    [userDefault synchronize];
}

@end
