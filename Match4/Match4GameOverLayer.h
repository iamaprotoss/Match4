//
//  Match4GameOverLayer.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
#import "Match4Label.h"

@interface Match4GameOverLayer : CCLayer
{
    CCSprite *win_bg;
    CCSprite *win_flare;
    CCSprite *win_banner;
    CCSprite *win_title;
    CCSprite *win_facebook;
    CCMenu *win_facebook_btn;
    CCSprite *win_money_title;
    CCSprite *win_score_title;
    CCSprite *win_money_icon;
    CCSprite *win_score_icon;
    CCSprite *win_facebookshare;
    CCMenuItemSprite *win_restart;
    CCMenuItemSprite *win_leaderboard;
    CCMenuItemSprite *win_menu;
    Match4Label *win_score;
    Match4Label *win_money;
}
/*
@property (nonatomic, retain) CCMenuItemSprite *retry;
@property (nonatomic, retain) CCMenuItemSprite *gameover_menu;
@property (nonatomic, retain) CCSprite *moneyTag;
@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCSprite *scoreTag;
@property (nonatomic, retain) CCSprite *facebookshare;
*/
-(id) initWithScore:(int)thisScore money:(int)thisMoney;

-(void)showLeaderboard;

@end

