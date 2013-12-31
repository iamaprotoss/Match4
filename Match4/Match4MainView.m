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
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        [self addChild:bg];
        /*
        friendsbg = [CCSprite spriteWithFile:@"start_friendsbg.png"];
        friendsbg.position = ccp(156, 190);
        [self addChild:friendsbg];
        */
        gold = [CCSprite spriteWithFile:@"start_gold.png"];
        gold.position = ccp(252, 350);
        [self addChild:gold];
        
        for (int i = 0; i < 5; i++) {
            CCSprite *life = [CCSprite spriteWithFile:@"start_live.png"];
            life.position = ccp(25+30*i, 350);
            [self addChild:life];
            [lives addObject:life];
        }
        /*
        points = [CCSprite spriteWithFile:@"start_points.png"];
        points.position = ccp(150, 325);
        [self addChild:points];
        */
        title = [CCSprite spriteWithFile:@"start_title.png"];
        title.position = ccp(160, 420);
        [self addChild:title];
        
        /*option = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_optionbutton.png"] selectedSprite:[CCSprite spriteWithFile:@"start_optionbutton.png"] target:self selector:@selector(mainToOption)];
        CCMenu *menu = [CCMenu menuWithItems:option, nil];
        menu.position = ccp(100, 100);
        [self addChild:menu];*/
        
        CCSprite *startNormal = [CCSprite spriteWithFile:@"start_start.png"];
        startNormal.anchorPoint = ccp(0.5, 0.5);
        CCSprite *startSelected = [CCSprite spriteWithFile:@"start_start.png"];
        startSelected.anchorPoint = ccp(0.5, 0.5);
        start = [CCMenuItemSprite itemWithNormalSprite:startNormal selectedSprite:startSelected target:self selector:@selector(mainToItem)];
        CCMenu *menu = [CCMenu menuWithItems:start, nil];
        menu.position = ccp(160, 100);
        [self addChild:menu];
    }
    return self;
}

-(void) mainToItem
{
    [[GameController sharedController] showItemView];
}

@end
