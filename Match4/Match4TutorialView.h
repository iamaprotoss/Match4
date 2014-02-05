//
//  Match4TutorialView.h
//  Match4
//
//  Created by Zhenwei on 14-1-21.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
#import "Match4EngineGame.h"
#import "Match4Label.h"
#import "Match4GameOverLayer.h"
#import "Match4PauseLayer.h"

@interface HelpView : CCLayer
@end


@interface Match4TutorialView : CCLayer
{
    Match4EngineGame *gameEngine;
    //Match4Label *timeLabel;
    GameController *gameController;
    
    Match4GameOverLayer *gameOverView;
    Match4PauseLayer *pauseLayer;
    
    CCSprite *play_bg;
    CCSprite *play_points_bg;
    Match4Label *play_points_label;
    CCSprite *play_star;
    CCSprite *play_star_hi;
    CCSprite *play_multimark;
    Match4Label *play_multi_label;
    CCSprite *play_board;
    CCSprite *play_time_bg;
    CCSprite *play_time_bar;
    CCMenu *play_pause_btn;
    CCMenu *play_hint_btn;
    CCSprite *play_hint_title;
    int gameScore;
    int gameMultiplier;
    
    NSMutableDictionary *special;
    
    BOOL isPlaying;
    BOOL isGameOver;
    float timer;
    float gameTime;
    
    BOOL canTouch;
    
    CCAnimation *hintAnimationFrames;
}

@property (nonatomic, retain) Match4GameOverLayer *gameOverView;
@property (nonatomic, retain) Match4PauseLayer *pauseLayer;

@property (nonatomic, retain) GameController *gameController;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isGameOver;
@property (nonatomic, retain) Match4EngineGame *gameEngine;
@property float timer;

/*@property (nonatomic, retain) CCSprite *play_bg;
 @property (nonatomic, retain) CCSprite *play_points;
 @property (nonatomic, retain) CCSprite *play_multiplier;
 @property (nonatomic, retain) CCSprite *play_board;
 //@property (nonatomic, retain) CCSprite *play_pause;
 @property (nonatomic, retain) Match4Label *score;
 @property (nonatomic) int gameScore;
 */

+(CCScene *) scene;

-(void) addPoints:(int)points;
-(void) updateScore;

-(void) showComplete;
-(void) gameOver;
-(void) pause;
-(void) resume;
-(void) restart;
-(void) hint;

-(void) clues;
-(void) proposeReshuffle;
-(void) quit;

@end
