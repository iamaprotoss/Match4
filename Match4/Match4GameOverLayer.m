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
        
        CCSprite *restartNormal = [CCSprite spriteWithFile:@"win_restart.png"];
        CCSprite *restartSelected = [CCSprite spriteWithFile:@"win_restart_l.png"];
        win_restart = [CCMenuItemSprite itemWithNormalSprite:restartNormal selectedSprite:restartSelected target:self selector:@selector(buttonPressed:)];
        win_restart.tag = 0;
        
        CCSprite *menuNormal = [CCSprite spriteWithFile:@"win_menu.png"];
        CCSprite *menuSelected = [CCSprite spriteWithFile:@"win_menu_l.png"];
        win_menu = [CCMenuItemSprite itemWithNormalSprite:menuNormal selectedSprite:menuSelected target:self selector:@selector(buttonPressed:)];
        win_menu.tag = 1;
        
        win_leaderboard = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"win_leaderboard.png"] selectedSprite:[CCSprite spriteWithFile:@"win_leaderboard.png"] target:self selector:@selector(buttonPressed:)];
        win_leaderboard.tag = 2;
        
        CCMenu *menu = [CCMenu menuWithItems:win_restart, win_menu, win_leaderboard, nil];
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
        
        win_score_icon = [CCSprite spriteWithFile:@"win_star_icon.png"];
        win_score_icon.position = ccp(225, 245);
        [self addChild:win_score_icon];
        win_lv_bonus = [CCSprite spriteWithFile:@"win_lv_bonus.png"];
        win_lv_bonus.position = ccp(15, 30);
        [win_score_icon addChild:win_lv_bonus];
        Match4Label *bonus = [Match4Label labelWithString:[NSString stringWithFormat:@"+%i%%", [GameController sharedController].statsManager.currentLevel] fontSize:12];
        bonus.position = ccp(16, 7);
        bonus.color = ccc3(20, 120, 150);
        [win_score_icon addChild:bonus];
        
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
    [[GameController sharedController].soundController playSound:@"GeneralMenuButton"];
    int tag = ((CCNode *)target).tag;
    if (tag == 0) {
        [[GameController sharedController].timeView restart];
    } else if (tag == 1) {
        [[GameController sharedController] showMainView:NO];
    } else if (tag == 2) {
        [[GameController sharedController].gameCenterManager showLeaderboard];
    }
}


@end
