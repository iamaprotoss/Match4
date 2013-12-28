//
//  Match4TimeView.h
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
#import "Match4EngineTime.h"
#import "Match4Label.h"

@interface Match4TimeView : CCLayer
{
    Match4EngineTime *gameEngine;
    Match4Label *scoreLabel;
    Match4Label *timeLabel;
    GameController *gameController;
    
    CCSprite *bg;
    CCSprite *points;
    CCSprite *multiplier;
    CCSprite *panel;
    CCSprite *play_pause;
    
    BOOL isPlaying;
    BOOL isGameOver;
    float timer;
}

@property (nonatomic, retain) GameController *gameController;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isGameOver;
@property (nonatomic, retain) Match4EngineTime *gameEngine;
@property float timer;

@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCSprite *points;
@property (nonatomic, retain) CCSprite *multiplier;
@property (nonatomic, retain) CCSprite *panel;
@property (nonatomic, retain) CCSprite *play_pause;

+(CCScene *) scene;

-(void) addPoints:(int)points;
-(void) updateScore;

-(void) showComplete;
-(void) gameOver;
-(void) pause;
-(void) resume;

-(void) clues;
-(void) proposeReshuffle;

@end


