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
    CCSprite *bg;
    CCMenuItemSprite *resume;
    CCMenuItemSprite *music;
    CCMenuItemSprite *sound;
    CCMenuItemSprite *pause_menu;
}

@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCMenuItemSprite *resume;
@property (nonatomic, retain) CCMenuItemSprite *music;
@property (nonatomic, retain) CCMenuItemSprite *sound;
@property (nonatomic, retain) CCMenuItemSprite *pause_menu;

@end
