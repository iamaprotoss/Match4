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

@implementation StoreView

-(id) init
{
    if (self = [super init]) {
        storebg = [CCSprite spriteWithFile:@"store_bg.png"];
        storebg.position = ccp(160, 100);
        [self addChild:storebg];
        
        for (int i = 0; i < 5; i++) {
            CCSprite *itembg = [CCSprite spriteWithFile:@"store_coinbg.png"];
            itembg.position = ccp(160, 240-60*i);
            [self addChild:itembg];
            CCSprite *item = [CCSprite spriteWithFile:[NSString stringWithFormat:@"store_coin%i.png", i+1]];
            item.position = ccp(50, 240-60*i);
            [self addChild:item];
            CCMenuItemSprite *buy = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"store_buy.png"] selectedSprite:[CCSprite spriteWithFile:@"store_buy.png"] target:self selector:@selector(buyCoin:)];
            buy.tag = i;
            CCMenu *buyMenu = [CCMenu menuWithItems:buy, nil];
            buyMenu.position = ccp(250, 240-60*i);
            [self addChild:buyMenu];
        }
    }
    return self;
}

-(void) buyCoin:(id)target
{
    int tag = ((CCNode*)target).tag;
    [[GameController sharedController].moneyManager buyIAP:tag];
}

@end
