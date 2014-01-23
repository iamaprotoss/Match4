//
//  StoreView.m
//  Match4
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "StoreView.h"
#import "GameController.h"
#import "MoneyManager.h"
#import "Match4Label.h"

@implementation StoreView

-(id) init
{
    if (self = [super init]) {
        store_bg = [CCSprite spriteWithFile:@"store_bg.png"];
        store_bg.position = ccp(160, 100);
        [self addChild:store_bg];
        
        for (int i = 0; i < 5; i++) {
            store_coinbg[i] = [CCSprite spriteWithFile:@"store_coinbg.png"];
            store_coinbg[i].position = ccp(160, 240-60*i);
            [self addChild:store_coinbg[i]];
            store_coin[i] = [CCSprite spriteWithFile:[NSString stringWithFormat:@"store_coin%i.png", i+1]];
            store_coin[i].position = ccp(20,20);
            [store_coinbg[i] addChild:store_coin[i]];
            CCMenuItemSprite *buy = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"store_buy.png"] selectedSprite:[CCSprite spriteWithFile:@"store_buy_I.png"] target:self selector:@selector(buyCoin:)];
            buy.tag = i;
            store_buy[i] = [CCMenu menuWithItems:buy, nil];
            store_buy[i].position = ccp(200, 20);
            [store_coinbg[i] addChild:store_buy[i]];
            int nCoin;
            float nPrice;
            if (i == 0) {
                nCoin = 100;
                nPrice = 0.99;
            } else if (i == 1) {
                nCoin = 500;
                nPrice = 3.99;
            } else if (i == 2) {
                nCoin = 1000;
                nPrice = 5.99;
            } else if (i == 3) {
                nCoin = 5000;
                nPrice = 19.99;
            } else {
                nCoin = 10000;
                nPrice = 29.99;
            }
            store_coin_label[i] = [Match4Label labelWithString:[NSString stringWithFormat:@"%i",nCoin] fontSize:16];
            store_coin_label[i].position = ccp(60, 20);
            [store_coinbg[i] addChild:store_coin_label[i]];
            store_price_label[i] = [Match4Label labelWithString:[NSString stringWithFormat:@"$%.2f",nPrice] fontSize:16];
            store_price_label[i].position = ccp(120, 20);
            [store_coinbg[i] addChild:store_price_label[i]];
        }
        
        close = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"play_multimark.png"] selectedSprite:[CCSprite spriteWithFile:@"play_multimark.png"] target:self selector:@selector(close)];
        CCMenu *closeM = [CCMenu menuWithItems:close, nil];
        closeM.position = ccp(260, 305);
        [self addChild:closeM];

    }
    return self;
}

-(void) buyCoin:(id)target
{
    int tag = ((CCNode*)target).tag;
    [[GameController sharedController].moneyManager buyIAP:tag];
}

-(void) close
{
    [self.delegate closeStoreView];
}


@end
