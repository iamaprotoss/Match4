//
//  Match4ItemLayer.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4ItemLayer.h"
#import "GameController.h"
#import "StoreView.h"

@implementation Match4ItemLayer
//@synthesize buygold, price, selectbg;


-(id) init
{
    if (self = [super init]) {
        //[GameController sharedController].itemView = self;
        numOfItemSelected = 0;
        
        item_bg = [CCSprite spriteWithFile:@"item_bg.png"];
        item_bg.position = ccp(160, 180);
        [self addChild:item_bg];
        
        item_banner = [CCSprite spriteWithFile:@"item_banner.png"];
        item_banner.position = ccp(160, 325);
        [self addChild:item_banner];
        
        item_item = [CCSprite spriteWithFile:@"item_item.png"];
        item_item.position = ccp(160, 330);
        [self addChild:item_item];
        
        item_description = [CCSprite spriteWithFile:@"item_description.png"];
        item_description.position = ccp(160, 100);
        [self addChild:item_description];
        
        /*
        buygold = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_gold.png"] selectedSprite:[CCSprite spriteWithFile:@"start_gold.png"] target:self selector:@selector(store)];
        CCMenu *menu = [CCMenu menuWithItems:buygold, nil];
        menu.position = ccp(160, 275);
        [self addChild:menu];
        */
         
        item_item1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item1.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item1_I.png"] target:self selector:@selector(itemSelect:)];
        item_item1.tag = 1;
        item_item2 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item2.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item2_I.png"] target:self selector:@selector(itemSelect:)];
        item_item2.tag = 2;
        item_item3 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item3.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item3_I.png"] target:self selector:@selector(itemSelect:)];
        item_item3.tag = 3;
        
        CCMenu *menu1 = [CCMenu menuWithItems:item_item1, item_item2, item_item3, nil];
        menu1.position = ccp(160, 270);
        [menu1 alignItemsHorizontallyWithPadding:20];
        [self addChild:menu1];
        
        item_item4 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item4.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item4_I.png"] target:self selector:@selector(itemSelect:)];
        item_item4.tag = 4;
        item_item5 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item5.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item5_I.png"] target:self selector:@selector(itemSelect:)];
        item_item5.tag = 5;
        
        CCMenu *menu2 = [CCMenu menuWithItems:item_item4, item_item5, nil];
        menu2.position = ccp(160, 200);
        [menu2 alignItemsHorizontallyWithPadding:20];
        [self addChild:menu2];
        
        /*price = [CCSprite spriteWithFile:@"item_price.png"];
        price.position = ccp(100, 100);
        [self addChild:price];*/
        
        //self.position = ccp(160, 320);
        for (int i = 0; i < 3; i++) {
            item_itembg[i] = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_itembg.png"] selectedSprite:[CCSprite spriteWithFile:@"item_itembg.png"] target:self selector:@selector(itemDeselect:)];
            item_itembg[i].tag = i+6;
        }
        CCMenu *menu3 = [CCMenu menuWithItems:item_itembg[0], item_itembg[1], item_itembg[2], nil];
        menu3.position = ccp(160, 130);
        [menu3 alignItemsHorizontallyWithPadding:20];
        [self addChild:menu3];
        
        close = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"play_multimark.png"] selectedSprite:[CCSprite spriteWithFile:@"play_multimark.png"] target:self selector:@selector(close)];
        CCMenu *closeM = [CCMenu menuWithItems:close, nil];
        closeM.position = ccp(260, 305);
        [self addChild:closeM];
    }
    return self;
}

-(void)itemSelect:(id)target
{
    int tag = ((CCSprite *)target).tag;
    if (numOfItemSelected < 3) {
        if ([[GameController sharedController] addItem:tag]) {
            numOfItemSelected ++;
            NSLog(@"numOfItemSelected %i", numOfItemSelected);
        };
    }
}

-(void)store
{
    [[GameController sharedController].storeObserver requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            [GameController sharedController].moneyManager.allIAP = products;
            CCLayer *storeView = [StoreView node];
            [self addChild:storeView];
        }
    }];
}

-(void)close
{
    [[GameController sharedController] resetItem];
    [self.delegate closeItemLayer];
}

@end
