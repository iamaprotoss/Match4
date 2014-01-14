//
//  MoneyManager.m
//  Match4
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "MoneyManager.h"
#import "GameController.h"
#import "AppDelegate.h"

@implementation MoneyManager
@synthesize coins;
@synthesize request;
@synthesize responseProducts;

-(id) init
{
    if (self = [super init]) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        coins = [userDefaults integerForKey:@"coins"];
        selectedIAP = -1;
    }
    return self;
}

-(void)addCoins:(int)noOfCoins
{
    coins += noOfCoins;
    [userDefaults setInteger:coins forKey:@"coins"];
}

-(void)spendCoins:(int)noOfCoins
{
    coins -= noOfCoins;
    [userDefaults setInteger:coins forKey:@"coins"];
}

-(void)buyIAP:(int)thisIAP
{
    AppDelegate *appDelegate = (AppDe)
    switch (thisIAP) {
        case 0:
            
            break;
            
        default:
            break;
    }
}

@end
