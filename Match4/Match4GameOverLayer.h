//
//  Match4GameOverLayer.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"

@interface Match4GameOverLayer : CCLayer
{
    CCSprite *bg;
    CCSprite *score;
    CCSprite *gold;
    CCSprite *facebookshare;
    CCMenuItemSprite *retry;
    CCMenuItemSprite *gameover_menu;
}

@property (nonatomic, retain) CCMenuItemSprite *retry;
@property (nonatomic, retain) CCMenuItemSprite *gameover_menu;
@property (nonatomic, retain) CCSprite *gold;
@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCSprite *score;
@property (nonatomic, retain) CCSprite *facebookshare;

@end

