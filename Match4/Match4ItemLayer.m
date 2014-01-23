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
#import "Match4Label.h"

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
        
        item_title = [CCSprite spriteWithFile:@"item_item.png"];
        item_title.position = ccp(160, 330);
        [self addChild:item_title];
        
        item_description = [CCSprite spriteWithFile:@"item_description.png"];
        item_description.position = ccp(160, 100);
        [self addChild:item_description];
        
        /*
        buygold = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_gold.png"] selectedSprite:[CCSprite spriteWithFile:@"start_gold.png"] target:self selector:@selector(store)];
        CCMenu *menu = [CCMenu menuWithItems:buygold, nil];
        menu.position = ccp(160, 275);
        [self addChild:menu];
        */
        [self placeItem:0 atPosition:ccp(90, 270) withPrice:100];
        [self placeItem:1 atPosition:ccp(160, 270) withPrice:200];
        [self placeItem:2 atPosition:ccp(230, 270) withPrice:300];
        [self placeItem:3 atPosition:ccp(120, 200) withPrice:400];
        [self placeItem:4 atPosition:ccp(200, 200) withPrice:500];
        
        //self.position = ccp(160, 320);
        for (int i = 0; i < 3; i++) {
            item_itembg[i] = [CCSprite spriteWithFile:@"item_itembg.png"];
            item_itembg[i].position = ccp(i*70+90, 130);
            [self addChild:item_itembg[i]];
        }
        
        selectionSlot[0] = selectionSlot[1] = selectionSlot[2] = NO;
        
        
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
    NSMutableDictionary *uData = item_item[tag-1].userData;
    if (![[uData objectForKey:@"is selected"] boolValue]) {
        if (numOfItemSelected < 3) {
            numOfItemSelected ++;
            [uData setObject:[NSNumber numberWithBool:YES] forKey:@"is selected"];
            //item_item[tag-1].userData = uData;
            if (selectionSlot[0] == NO) {
                item_item[tag-1].position = ccp(90, 130);
                selectionSlot[0] = YES;
            } else if (selectionSlot[1] == NO) {
                item_item[tag-1].position = ccp(160, 130);
                selectionSlot[1] = YES;
            } else if (selectionSlot[2] == NO) {
                item_item[tag-1].position = ccp(230, 130);
                selectionSlot[2] = YES;
            }
            
            item_item[tag-1].zOrder = 1000;
            [[GameController sharedController] addItem:tag];
            [[GameController sharedController].moneyManager spendCoins:[[uData objectForKey:@"price"] intValue]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:@([GameController sharedController].moneyManager.coins) userInfo:nil];
        }
    } else { // if the item is not selected
        if (numOfItemSelected > 0) {
            numOfItemSelected --;
            [uData setObject:[NSNumber numberWithBool:NO] forKey:@"is selected"];
            if (item_item[tag-1].position.x == 90) {
                selectionSlot[0] = NO;
            } else if (item_item[tag-1].position.x == 160) {
                selectionSlot[1] = NO;
            } else if (item_item[tag-1].position.x == 230) {
                selectionSlot[2] = NO;
            }
            //item_item[tag-1].userData = uData;
            item_item[tag-1].position = ccp([[uData objectForKey:@"original x"] floatValue], [[uData objectForKey:@"original y"] floatValue]);
            [[GameController sharedController] deleteItem:tag];
            [[GameController sharedController].moneyManager addCoins:[[uData objectForKey:@"price"] intValue]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:@([GameController sharedController].moneyManager.coins) userInfo:nil];
        }
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

-(void) placeItem:(int)Id atPosition:(CGPoint)thisPos withPrice:(int)price
{
    CCMenuItemSprite *itemSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"item_item%i.png", Id+1]]selectedSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"item_item%i_I.png", Id+1]] target:self selector:@selector(itemSelect:)];
    itemSprite.tag = Id+1;
    item_item[Id] = [CCMenu menuWithItems:itemSprite, nil];
    item_item[Id].position = ccp(thisPos.x, thisPos.y);
    item_item[Id].userData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithFloat:item_item[Id].position.x], @"original x",
                             [NSNumber numberWithFloat:item_item[Id].position.y], @"original y",
                             [NSNumber numberWithBool:NO], @"is selected",
                             [NSNumber numberWithInt:100*(Id+1)], @"price",
                             nil];
    [self addChild:item_item[Id]];
    CCSprite *item_price = [CCSprite spriteWithFile:@"item_price.png"];
    item_price.position = ccp(item_item[Id].position.x, item_item[Id].position.y-40);
    [self addChild:item_price];
    item_price_label[Id] = [Match4Label labelWithString:[NSString stringWithFormat:@"%i",price] fontSize:12];
    item_price_label[Id].position = ccp(35, 10);
    [item_price addChild:item_price_label[Id]];
}

@end
