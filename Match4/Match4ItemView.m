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
        bg.scaleX = 0.33;
        bg.scaleY = 0.3;
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        [self addChild:bg];
        
        selectbg = [CCSprite spriteWithFile:@"item_selectbg.png"];
        selectbg.scaleX = 0.33;
        selectbg.scaleY = 0.3;
        selectbg.position = ccp(165, 240);
        [self addChild:selectbg];
        
        buygold = [CCSprite spriteWithFile:@"item_buygold.png"];
        buygold.scaleX = 0.33;
        buygold.scaleY = 0.3;
        buygold.position = ccp(165, 350);
        [self addChild:buygold];
        
        item = [CCSprite spriteWithFile:@"item_item.png"];
        item.scaleX = 0.33;
        item.scaleY = 0.3;
        item.position = ccp(125, 285);
        [self addChild:item];
        
        price = [CCSprite spriteWithFile:@"item_price.png"];
        price.scaleX = 0.33;
        price.scaleY = 0.3;
        price.position = ccp(125, 245);
        [self addChild:price];
        
        
        
        CCSprite *sprite1 = [CCSprite spriteWithFile:@"start_start.png"];
        sprite1.scaleX = 0.33;
        sprite1.scaleY = 0.3;
        sprite1.anchorPoint = ccp(0.5, 0.5);
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"start_start.png"];
        sprite2.scaleX = 0.35;
        sprite2.scaleY = 0.32;
        sprite2.anchorPoint = ccp(0.5, 0.5);
        start = [CCMenuItemSprite itemWithNormalSprite:sprite1 selectedSprite:sprite2 target:self selector:@selector(mainToTime)];
        CCMenu *menu = [CCMenu menuWithItems:start, nil];
        menu.position = ccp(350, 150);
        [self addChild:menu];

    }
    return self;
}

-(void) mainToTime
{
    [[GameController sharedController] showGameView];
}

@end
