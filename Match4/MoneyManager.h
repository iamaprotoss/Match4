//
//  MoneyManager.h
//  Match4
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "StoreView.h"

@interface MoneyManager : NSObject
{
    NSUserDefaults *userDefaults;
    StoreView *storeView;
    int coins;
    int selectedIAP;
    
    SKProductsRequest *request;
}

@property (nonatomic) int coins;
@property (nonatomic, retain) SKProductsRequest *request;
@property (nonatomic, retain) SKProductsRequest *responseProducts;

-(void)addCoins:(int)noOfCoins;
-(void)spendCoins:(int)noOfCoins;

@end
