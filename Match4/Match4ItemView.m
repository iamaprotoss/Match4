//
//  Match4ItemView.m
//  Match4
//
//  Created by apple on 13-12-27.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4ItemView.h"
#import "GameController.h"

@implementation Match4ItemView
@synthesize start, buygold, item, price, selectbg;

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    Match4ItemView *layer = [Match4ItemView node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id) init
{
    if (self = [super init]) {
        CCSprite *bg = [CCSprite spriteWithFile:@"start_bg.png"];
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        [self addChild:bg];
        
        selectbg = [CCSprite spriteWithFile:@"item_mainbg.png"];
        selectbg.position = ccp(160, 284);
        [self addChild:selectbg];
        
        buygold = [CCSprite spriteWithFile:@"item_maingold.png"];
        buygold.position = ccp(160, 350);
        [self addChild:buygold];
        
        item = [CCSprite spriteWithFile:@"item_item.png"];
        item.position = ccp(125, 285);
        [self addChild:item];
        
        price = [CCSprite spriteWithFile:@"item_price.png"];
        price.position = ccp(125, 245);
        [self addChild:price];
        
        CCSprite *startNormal = [CCSprite spriteWithFile:@"start_start.png"];
        startNormal.anchorPoint = ccp(0.5, 0.5);
        CCSprite *startSelected = [CCSprite spriteWithFile:@"start_start.png"];
        startSelected.anchorPoint = ccp(0.5, 0.5);
        start = [CCMenuItemSprite itemWithNormalSprite:startNormal selectedSprite:startSelected target:self selector:@selector(itemToTime)];
        CCMenu *menu = [CCMenu menuWithItems:start, nil];
        menu.position = ccp(160, 100);
        [self addChild:menu];
    }
    return self;
}

-(void) itemToTime
{
    [[GameController sharedController] showGameView];
}

@end
