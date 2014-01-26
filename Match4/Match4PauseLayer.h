//
//  Match4PauseLayer.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"

@interface Match4PauseLayer : CCLayer
{
    CCSprite *paused_bg;
    CCSprite *paused_banner;
    CCSprite *paused_title;
    CCMenuItemSprite *paused_resume;
    CCMenuItemSprite *paused_music;
    CCMenuItemSprite *paused_sound;
    CCMenuItemSprite *paused_menu;
    CCMenuItemSprite *paused_restart;
}
/*
@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCMenuItemSprite *resume;
@property (nonatomic, retain) CCMenuItemSprite *music;
@property (nonatomic, retain) CCMenuItemSprite *sound;
@property (nonatomic, retain) CCMenuItemSprite *pause_menu;
*/
@end
