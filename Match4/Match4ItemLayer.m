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
        
        selectbg = [CCSprite spriteWithFile:@"item_bg.png"];
        selectbg.position = ccp(160, 180);
        [self addChild:selectbg];
        
        buygold = [CCSprite spriteWithFile:@"start_gold.png"];
        buygold.position = ccp(160, 275);
        [self addChild:buygold];
        
        item = [CCSprite spriteWithFile:@"item_item.png"];
        item.position = ccp(100, 150);
        [self addChild:item];
        
        price = [CCSprite spriteWithFile:@"item_price.png"];
        price.position = ccp(100, 100);
        [self addChild:price];
        
        //self.position = ccp(160, 320);
    }
    return self;
}

@end
