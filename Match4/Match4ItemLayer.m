//
//  Match4ItemLayer.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4ItemLayer.h"
#import "GameController.h"

@implementation Match4ItemLayer
@synthesize start, buygold, item, price, selectbg;


-(id) init
{
    if (self = [super init]) {
        //[GameController sharedController].itemView = self;
        numOfItemSelected = 0;
        
        selectbg = [CCSprite spriteWithFile:@"item_bg.png"];
        selectbg.position = ccp(160, 180);
        [self addChild:selectbg];
        
        buygold = [CCSprite spriteWithFile:@"start_gold.png"];
        buygold.position = ccp(160, 275);
        [self addChild:buygold];
        
        item1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item1.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item1.png"] target:self selector:@selector(itemSelect:)];
        item1.tag = 1;
        item2 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item2.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item2.png"] target:self selector:@selector(itemSelect:)];
        item2.tag = 2;
        item3 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item3.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item3.png"] target:self selector:@selector(itemSelect:)];
        item3.tag = 3;
        
        CCMenu *menu1 = [CCMenu menuWithItems:item1, item2, item3, nil];
        menu1.position = ccp(160, 200);
        [menu1 alignItemsHorizontallyWithPadding:20];
        [self addChild:menu1];
        
        item4 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item4.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item4.png"] target:self selector:@selector(itemSelect:)];
        item4.tag = 4;
        item5 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"item_item5.png"] selectedSprite:[CCSprite spriteWithFile:@"item_item5.png"] target:self selector:@selector(itemSelect:)];
        item5.tag = 5;
        
        CCMenu *menu2 = [CCMenu menuWithItems:item4, item5, nil];
        menu2.position = ccp(160, 100);
        [menu2 alignItemsHorizontallyWithPadding:20];
        [self addChild:menu2];
        
        /*price = [CCSprite spriteWithFile:@"item_price.png"];
        price.position = ccp(100, 100);
        [self addChild:price];*/
        
        //self.position = ccp(160, 320);
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

@end
