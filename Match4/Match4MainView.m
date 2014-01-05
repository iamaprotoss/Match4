//
//  Match4MainView.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4MainView.h"
#import "Match4TimeView.h"
#import "GameController.h"

@implementation Match4MainView
@synthesize bg, friendsbg, gold, lives, option, points, start, title, facebooklogin;
@synthesize friendsLayer, itemLayer;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    Match4MainView *layer = [Match4MainView node];
    
    [scene addChild:layer];
    
    return scene;
}

- (void)dealloc
{
    [super dealloc];
}

-(id) init
{
    if (self = [super init]) {
        [GameController sharedController].mainView = self;
        
        bg = [CCSprite spriteWithFile:@"start_bg.png"];
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        [self addChild:bg];
        /*
        friendsbg = [CCSprite spriteWithFile:@"start_friendsbg.png"];
        friendsbg.position = ccp(156, 190);
        [self addChild:friendsbg];
        */
        
        for (int i = 0; i < 5; i++) {
            CCSprite *life = [CCSprite spriteWithFile:@"start_live.png"];
            life.position = ccp(30+30*i, 450);
            [self addChild:life];
            [lives addObject:life];
        }
        
        /*facebooklogin = [CCSprite spriteWithFile:@"start_facebook_login.png"];
        facebooklogin.position = ccp(160, 200);
        [self addChild:facebooklogin];*/
        
        gold = [CCSprite spriteWithFile:@"start_gold.png"];
        gold.position = ccp(250, 450);
        [self addChild:gold];
        
        /*title = [CCSprite spriteWithFile:@"start_title.png"];
        title.position = ccp(160, 420);
        [self addChild:title];*/
        
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
        menu.position = ccp(160, 120);
        [self addChild:menu];
        
        friendsLayer = [Match4FriendsLayer node];
        friendsLayer.position = ccp(0, 120);
        [self addChild:friendsLayer];
    }
    return self;
}

-(void) mainToItem
{
    if (friendsLayer!=nil) {
        [friendsLayer removeFromParent];
        friendsLayer = nil;
        itemLayer = [Match4ItemLayer node];
        itemLayer.position = ccp(0, 120);
        [self addChild:itemLayer];
    } else {
        [[GameController sharedController] showGameView];
    }
}

@end
