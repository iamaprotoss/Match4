//
//  GameOverView.h
//  Match4
//
//  Created by apple on 13-12-31.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "CCLayer.h"

@interface GameOverView : CCLayer
{
    CCSprite *back;
    CCSprite *banner;
    CCSprite *bg;
    CCSprite *retry;
    CCSprite *score;
}

@property (nonatomic, retain) CCSprite *back;
@property (nonatomic, retain) CCSprite *banner;
@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCSprite *retry;
@property (nonatomic, retain) CCSprite *score;

+(CCScene *)scene;

@end
