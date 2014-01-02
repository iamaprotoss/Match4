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
#import "GameOverView.h"

@interface Match4TimeView : CCLayer
{
    Match4EngineTime *gameEngine;
    Match4Label *scoreLabel;
    Match4Label *timeLabel;
    GameController *gameController;
    
    GameOverView *gameOverView;
    
    CCSprite *play_bg;
    CCSprite *play_points;
    CCSprite *play_multiplier;
    CCSprite *play_panel;
    CCSprite *play_timeBg;
    CCSprite *play_timeBar;
    //CCSprite *play_pause;
    Match4Label *score;
    
    BOOL isPlaying;
    BOOL isGameOver;
    float timer;
}

@property (nonatomic, retain) CCLayer *gameOverView;

@property (nonatomic, retain) GameController *gameController;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isGameOver;
@property (nonatomic, retain) Match4EngineTime *gameEngine;
@property float timer;

@property (nonatomic, retain) CCSprite *play_bg;
@property (nonatomic, retain) CCSprite *play_points;
@property (nonatomic, retain) CCSprite *play_multiplier;
@property (nonatomic, retain) CCSprite *play_panel;
//@property (nonatomic, retain) CCSprite *play_pause;
@property (nonatomic, retain) Match4Label *score;

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


