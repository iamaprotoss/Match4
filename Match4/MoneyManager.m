//
//  MoneyManager.m
//  Match4
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "MoneyManager.h"
#import "GameController.h"
#import "StoreObserver.h"
#import "StoreLayer.h"

@implementation MoneyManager
@synthesize coins;
@synthesize request;
@synthesize allIAP;
@synthesize storeView;
@synthesize responseProducts;

-(id) init
{
    if (self = [super init]) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        selectedIAP = -1;
    }
    return self;
}

-(void)addCoins:(int)noOfCoins
{
    [GameController sharedController].statsManager.currentMoney += noOfCoins;
    [userDefaults setInteger:[GameController sharedController].statsManager.currentMoney forKey:@"money"];
}

-(void)spendCoins:(int)noOfCoins
{
    [GameController sharedController].statsManager.currentMoney -= noOfCoins;
    [userDefaults setInteger:[GameController sharedController].statsManager.currentMoney forKey:@"money"];
}

-(void)buyIAP:(int)thisIAP
{
    switch (thisIAP) {
        case 0:
            [[GameController sharedController].storeObserver purchase:IAP_100_COINS];
            break;
        case 1:
            [[GameController sharedController].storeObserver purchase:IAP_500_COINS];
            break;
        case 2:
            [[GameController sharedController].storeObserver purchase:IAP_1000_COINS];
            break;
        case 3:
            [[GameController sharedController].storeObserver purchase:IAP_5000_COINS];
            break;
        case 4:
            [[GameController sharedController].storeObserver purchase:IAP_10000_COINS];
            break;
        default:
            break;
    }
}

#pragma mark StoreObserverProtocol
/*-(void)transactionDidFinish:(NSString *)transactionIdentifier
{
    if ([transactionIdentifier isEqualToString:IAP_100_COINS]) {
        [self addCoins:100];
    } else if ([transactionIdentifier isEqualToString:IAP_500_COINS]) {
        [self addCoins:500];
    } else if ([transactionIdentifier isEqualToString:IAP_1000_COINS]) {
        [self addCoins:1000];
    } else if ([transactionIdentifier isEqualToString:IAP_5000_COINS]) {
        [self addCoins:5000];
    } else if ([transactionIdentifier isEqualToString:IAP_10000_COINS]) {
        [self addCoins:10000];
    }
}*/

-(void)transactionDidError:(NSError *)error
{
    
}

@end
