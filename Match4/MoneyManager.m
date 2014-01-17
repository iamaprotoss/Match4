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

#pragma mark SKProduct
-(void)requestProductDataFromStoreView:(StoreView *)thisView
{
    //self.storeView = thisView;
    self.request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:
                                                                         IAP_100_COINS,
                                                                         IAP_500_COINS,
                                                                         IAP_1000_COINS,
                                                                         IAP_5000_COINS,
                                                                         IAP_10000_COINS,
                                                                          nil]];
    request.delegate = [GameController sharedController].storeObserver;
    [request start];
}


@end
