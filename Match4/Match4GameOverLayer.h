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
    CCSprite *bg;
    CCSprite *scoreTag;
    CCSprite *moneyTag;
    CCSprite *facebookshare;
    CCMenuItemSprite *retry;
    CCMenuItemSprite *gameover_menu;
    Match4Label *score;
    Match4Label *money;
}

@property (nonatomic, retain) CCMenuItemSprite *retry;
@property (nonatomic, retain) CCMenuItemSprite *gameover_menu;
@property (nonatomic, retain) CCSprite *moneyTag;
@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCSprite *scoreTag;
@property (nonatomic, retain) CCSprite *facebookshare;

-(id) initWithScore:(int)thisScore money:(int)thisMoney;

@end

