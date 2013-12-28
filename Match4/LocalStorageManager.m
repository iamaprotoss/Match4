//
//  LocalStorageManager.m
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "LocalStorageManager.h"

@implementation LocalStorageManager

@synthesize currentGame;

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
    NSDictionary *dic = [userDefault dictionaryForKey:@"currentGame"];
    
    if (dic) {
        self.currentGame = [GameItem new];
        [self.currentGame initWithDictionary:dic];
    }
}

- (void)synchronize
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (self.currentGame) {
        [userDefault setObject:[self.currentGame getDataInDictionary] forKey:@"currentGame"];
    } else {
        [userDefault removeObjectForKey:@"currentGame"];
    }
    [userDefault synchronize];
}

@end
