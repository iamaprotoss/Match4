//
//  Match4GameOverLayer.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4GameOverLayer.h"
#import "GameController.h"
#import "Match4TimeView.h"

@implementation Match4GameOverLayer
//@synthesize gameover_menu, moneyTag, bg, retry, scoreTag, facebookshare;


-(id) initWithScore:(int)thisScore money:(int)thisMoney;
{
    if (self = [super init]) {
        win_bg = [CCSprite spriteWithFile:@"win_bg.png"];
        win_bg.position = ccp(160, 190);
        [self addChild:win_bg];
        
        win_flare = [CCSprite spriteWithFile:@"win_flare.png"];
        win_flare.position = ccp(160, 190);
        win_flare.opacity = 150;
        [self addChild:win_flare];
        [win_flare runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:20 angle:360]]];
        
        win_banner = [CCSprite spriteWithFile:@"win_banner.png"];
        win_banner.position = ccp(160, 290);
        [self addChild:win_banner];
        
        win_title = [CCSprite spriteWithFile:@"win_win.png"];
        win_title.position = ccp(160, 295);
        [self addChild:win_title];
        
        win_facebookshare = [CCSprite spriteWithFile:@"win_facebook.png"];
        win_facebookshare.position = ccp(160, 130);
        [self addChild:win_facebookshare];
        
        CCSprite *restartNormal = [CCSprite spriteWithFile:@"win_replay.png"];
        CCSprite *restartSelected = [CCSprite spriteWithFile:@"win_replay_I.png"];
        win_restart = [CCMenuItemSprite itemWithNormalSprite:restartNormal selectedSprite:restartSelected target:self selector:@selector(buttonPressed:)];
        win_restart.tag = 0;
        
        CCSprite *menuNormal = [CCSprite spriteWithFile:@"win_menu.png"];
        CCSprite *menuSelected = [CCSprite spriteWithFile:@"win_menu_I.png"];
        win_menu = [CCMenuItemSprite itemWithNormalSprite:menuNormal selectedSprite:menuSelected target:self selector:@selector(buttonPressed:)];
        win_menu.position = ccp(175, 100);
        win_menu.tag = 1;
        
        CCMenu *menu = [CCMenu menuWithItems:win_restart, win_menu, nil];
        [menu alignItemsHorizontallyWithPadding:20];
        menu.position = ccp(160, 100);
        [self addChild:menu];
        
        win_money_title = [CCSprite spriteWithFile:@"win_gold.png"];
        win_money_title.position = ccp(120, 180);
        [self addChild:win_money_title];
        
        win_money_icon = [CCSprite spriteWithFile:@"win_gold_icon.png"];
        win_money_icon.position = ccp(120, 160);
        [self addChild:win_money_icon];
        
        win_money = [Match4Label labelWithString:[NSString stringWithFormat:@"+%i", thisMoney] fontSize:20];
        win_money.position = ccp(160, 160);
        win_money.color = ccc3(240, 0, 0);
        win_money.opacity = 200;
        [self addChild:win_money];
        
        win_score_title = [CCSprite spriteWithFile:@"win_score.png"];
        win_score_title.position = ccp(140, 240);
        [self addChild:win_score_title];
        
        win_score_icon = [CCSprite spriteWithFile:@"win_score_icon.png"];
        win_score_icon.position = ccp(200, 240);
        [self addChild:win_score_icon];
        
        win_score = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", thisScore] fontSize:30];
        [self addChild:win_score];
        win_score.position = ccp(160, 210);
        win_score.color = ccc3(240, 0, 0);
        win_score.opacity = 200;
    }
    return self;
}

-(void) buttonPressed:(id)target;
{
    if (((CCNode *)target).tag == 0) {
        [[GameController sharedController].timeView restart];
    } else if (((CCNode *)target).tag == 1) {
        [[GameController sharedController] showMainView];
    }
}

@end
