//
//  Match4MainView.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4MainView.h"
#import "Match4TimeView.h"

@implementation Match4MainView
@synthesize bg, friendsbg, gold, lives, option, points, start, title;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    Match4MainView *layer = [Match4MainView node];
    
    [scene addChild:layer];
    
    return scene;
}

- (void)dealloc
{
    [bg release];
    [friendsbg release];
    [gold release];
    [lives release];
    [option release];
    [points release];
    [start release];
    [title release];
}

-(id) init
{
    if (self = [super init]) {
        bg = [CCSprite spriteWithFile:@"start_bg.png"];
        bg.scaleX = 0.33;
        bg.scaleY = 0.3;
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        [self addChild:bg];
        
        friendsbg = [CCSprite spriteWithFile:@"start_friendsbg.png"];
        friendsbg.scaleX = 0.33;
        friendsbg.scaleY = 0.3;
        friendsbg.position = ccp(156, 190);
        [self addChild:friendsbg];
        
        gold = [CCSprite spriteWithFile:@"start_gold.png"];
        gold.scaleX = 0.33;
        gold.scaleY = 0.3;
        gold.position = ccp(252, 361);
        [self addChild:gold];
        
        for (int i = 0; i < 5; i++) {
            CCSprite *life = [CCSprite spriteWithFile:@"start_live.png"];
            life.scaleX = 0.33;
            life.scaleY = 0.3;
            life.position = ccp(25+30*i, 360);
            [self addChild:life];
            [lives addObject:life];
        }
        
        points = [CCSprite spriteWithFile:@"start_points.png"];
        points.scaleX = 0.33;
        points.scaleY = 0.3;
        points.position = ccp(150, 325);
        [self addChild:points];
        
        title = [CCSprite spriteWithFile:@"start_title.png"];
        title.scaleX = 0.33;
        title.scaleY = 0.3;
        title.position = ccp(165, 430);
        [self addChild:title];
        
        /*option = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_optionbutton.png"] selectedSprite:[CCSprite spriteWithFile:@"start_optionbutton.png"] target:self selector:@selector(mainToOption)];
        CCMenu *menu = [CCMenu menuWithItems:option, nil];
        menu.position = ccp(100, 100);
        [self addChild:menu];*/
        
        CCSprite *sprite1 = [CCSprite spriteWithFile:@"start_start.png"];
        sprite1.scaleX = 0.33;
        sprite1.scaleY = 0.3;
        sprite1.anchorPoint = ccp(0.5, 0.5);
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"start_start.png"];
        sprite2.scaleX = 0.35;
        sprite2.scaleY = 0.32;
        sprite2.anchorPoint = ccp(0.5, 0.5);
        start = [CCMenuItemSprite itemWithNormalSprite:sprite1 selectedSprite:sprite2 target:self selector:@selector(mainToItem)];
        CCMenu *menu = [CCMenu menuWithItems:start, nil];
        menu.position = ccp(350, 150);
        [self addChild:menu];
    }
    return self;
}

-(void) mainToItem
{
    [[GameController sharedController] showItemView];
}

@end
