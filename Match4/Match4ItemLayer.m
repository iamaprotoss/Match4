//
//  Match4ItemLayer.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4ItemLayer.h"
#import "GameController.h"
#import "StoreLayer.h"
#import "Match4Label.h"

@implementation Match4ItemLayer
//@synthesize buygold, price, selectbg;


-(id) init
{
    if (self = [super init]) {
        str_description = [[NSMutableArray alloc] initWithObjects:@"add 5 seconds", @"add 10% to total score", @"add 3 blazing jades at game start", @"starting score multipler becomes 2", @"5% chance to drop blazing jade in game", nil];
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
        
        [self placeItem:0 atPosition:ccp(90, 275) withPrice:100];
        [self placeItem:1 atPosition:ccp(160, 275) withPrice:100];
        [self placeItem:2 atPosition:ccp(230, 275) withPrice:100];
        [self placeItem:3 atPosition:ccp(120, 200) withPrice:300];
        [self placeItem:4 atPosition:ccp(200, 200) withPrice:500];
        
        //self.position = ccp(160, 320);
        for (int i = 0; i < 3; i++) {
            item_itembg[i] = [CCSprite spriteWithFile:@"item_itembg.png"];
            item_itembg[i].position = ccp(i*70+90, 80);
            [self addChild:item_itembg[i]];
        }
        
        selectionSlot[0] = selectionSlot[1] = selectionSlot[2] = NO;
        
        item_description_bg = [CCSprite spriteWithFile:@"item_description.png"];
        item_description_bg.position = ccp(160, 130);
        [self addChild:item_description_bg];
        item_description = [Match4Label labelWithString:@"select up to 3 items" fontSize:10];
        item_description.position = ccp(160, 132);
        item_description.color = ccc3(5, 120, 150);
        [self addChild:item_description];
    }
    return self;
}

-(void)dealloc
{
    [str_description release];
    [super dealloc];
}

-(void)itemSelect:(id)target
{
    int tag = ((CCSprite *)target).tag;
    item_description.string = [str_description objectAtIndex:tag-1];
    NSMutableDictionary *uData = item_item[tag-1].userData;
    if (![[uData objectForKey:@"is selected"] boolValue]) {
        if (numOfItemSelected < 3) {
            if ([GameController sharedController].statsManager.currentMoney >= [[uData objectForKey:@"price"] intValue]) {
                [[GameController sharedController].moneyManager spendCoins:[[uData objectForKey:@"price"] intValue]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:nil userInfo:nil];
                numOfItemSelected ++;
                [uData setObject:[NSNumber numberWithBool:YES] forKey:@"is selected"];
                //item_item[tag-1].userData = uData;
                if (selectionSlot[0] == NO) {
                    item_item[tag-1].position = ccp(90, 80);
                    selectionSlot[0] = YES;
                } else if (selectionSlot[1] == NO) {
                    item_item[tag-1].position = ccp(160, 80);
                    selectionSlot[1] = YES;
                } else if (selectionSlot[2] == NO) {
                    item_item[tag-1].position = ccp(230, 80);
                    selectionSlot[2] = YES;
                }
                
                item_item[tag-1].zOrder = 1000;
                [[GameController sharedController] addItem:tag];
            } else {
                [[GameController sharedController].mainView goToStore];
            }
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:nil userInfo:nil];
        }
    }
}


-(void)back
{
    [[GameController sharedController] resetItem];
    [self.delegate closeItemLayer];
}

-(void) placeItem:(int)Id atPosition:(CGPoint)thisPos withPrice:(int)price
{
    item_itemobg[Id] = [CCSprite spriteWithFile:[NSString stringWithFormat:@"item_item%i_l.png", Id+1]];
    item_itemobg[Id].position = ccp(thisPos.x, thisPos.y);
    [self addChild:item_itemobg[Id]];
    CCMenuItemSprite *itemSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"item_item%i.png", Id+1]]selectedSprite:[CCSprite spriteWithFile:[NSString stringWithFormat:@"item_item%i_l.png", Id+1]] target:self selector:@selector(itemSelect:)];
    itemSprite.tag = Id+1;
    item_item[Id] = [CCMenu menuWithItems:itemSprite, nil];
    item_item[Id].position = ccp(thisPos.x, thisPos.y);
    item_item[Id].userData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithFloat:item_item[Id].position.x], @"original x",
                             [NSNumber numberWithFloat:item_item[Id].position.y], @"original y",
                             [NSNumber numberWithBool:NO], @"is selected",
                             [NSNumber numberWithInt:price], @"price",
                             nil];
    [self addChild:item_item[Id]];
    CCSprite *item_price = [CCSprite spriteWithFile:@"item_price.png"];
    item_price.position = ccp(item_item[Id].position.x, item_item[Id].position.y-37);
    [self addChild:item_price];
    item_price_label[Id] = [Match4Label labelWithString:[NSString stringWithFormat:@"%i",price] fontSize:12];
    item_price_label[Id].position = ccp(33, 11);
    [item_price addChild:item_price_label[Id]];
}

@end
