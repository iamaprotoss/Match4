//
//  Match4TimeView.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4TimeView.h"
#import "GameController.h"
#import "Match4Label.h"

@implementation Match4TimeView
@synthesize gameOverView, pauseLayer;
@synthesize gameController;
@synthesize gameEngine;
@synthesize play_bg, play_points, play_multiplier, play_board, score, timer;
@synthesize isGameOver, isPlaying;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    Match4TimeView *layer = [Match4TimeView node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id) init
{
    if (self = [super init]) {
        [GameController sharedController].timeView = self;
        
        play_bg = [CCSprite spriteWithFile:@"start_bg.png"];
        play_bg.anchorPoint = ccp(0, 0);
        play_bg.position = ccp(0, 0);
        [self addChild:play_bg];
        
        play_board = [CCSprite spriteWithFile:@"play_board_1.png"];
        play_board.position = ccp(160, 260);
        play_board.opacity = 220;
        play_board.scale = 640.0/965;
        [self addChild:play_board];
        
        play_points = [CCSprite spriteWithFile:@"play_points.png"];
        play_points.position = ccp(200, 450);
        [self addChild:play_points];
        score = [Match4Label labelWithString:@"0" fontSize:20];
        [play_points addChild:score];
        score.position = ccp(50, 12);
        score.color = ccc3(255, 255, 0);
        score.opacity = 200;
        //[score enableStrokeWithColor:ccc3(255, 0, 0) size:1 updateImage:YES];
        //[score enableShadowWithOffset:CGSizeMake(3,4) opacity:255 blur:0.5 updateImage:YES];
        
        
        play_multiplier = [CCSprite spriteWithFile:@"play_multimark.png"];
        play_multiplier.position = ccp(270, 450);
        [self addChild:play_multiplier];
        
        play_timeBg = [CCSprite spriteWithFile:@"play_time_bg.png"];
        play_timeBg.position = ccp(160, 77);
        [self addChild:play_timeBg];
        
        play_timeBar = [CCSprite spriteWithFile:@"play_time_bar.png"];
        play_timeBar.anchorPoint = ccp(0, 0);
        play_timeBar.position = ccp(66, 70);
        play_timeBar.scaleX = 1.32;
        [self addChild:play_timeBar];
        
        CCSprite *play_pauseNormal = [CCSprite spriteWithFile:@"play_pause_button.png"];
        play_pauseNormal.anchorPoint = ccp(0.5, 0.5);
        CCSprite *play_pauseSelected = [CCSprite spriteWithFile:@"play_pause_button.png"];
        play_pauseSelected.anchorPoint = ccp(0.5, 0.5);
        CCMenuItemSprite *play_pause = [CCMenuItemSprite itemWithNormalSprite:play_pauseNormal selectedSprite:play_pauseSelected target:self selector:@selector(pause)];
        CCMenu *menu = [CCMenu menuWithItems:play_pause, nil];
        menu.position = ccp(280, 77);
        [self addChild:menu];
        
        if ([GameController sharedController].localStore.currentGame) {
            [GameController sharedController].localStore.currentGame = [GameItem new];
        } else {
            [GameController sharedController].statsManager.currentMoney = [GameController sharedController].localStore.currentGame.stats.currentMoney;
            [GameController sharedController].statsManager.currentLevel = [GameController sharedController].localStore.currentGame.stats.currentLevel;
            [GameController sharedController].statsManager.currentLife = [GameController sharedController].localStore.currentGame.stats.currentLife;
            [GameController sharedController].statsManager.score = 0;
        }
        
        isPlaying = YES;
        isGameOver = NO;
        gameEngine = [[Match4EngineGame alloc] init];
        gameEngine.position = ccp(0, 100);
        [self addChild:gameEngine];        
        
        self.timer = 60;
        [self schedule:@selector(countDown) interval:1];
    }
    return self;
}

-(void) countDown
{
    if (isPlaying) {
        if (self.timer > 0) {
            self.timer --;
        }
        //[play_timeBar removeFromParent];
        //play_timeBar = [CCSprite spriteWithFile:@"play_time_bar.png"]; //rect:CGRectMake(0, 0, 100, 5*self.timer)];
        //play_timeBar.rotation = 90;
        play_timeBar.scaleX = self.timer/60*1.32;
        //play_timeBar.anchorPoint = ccp(0, 0);
        play_timeBar.position = ccp(66, 70);
        //[self addChild:play_timeBar];
        if (self.timer <= 0 && gameEngine.canTouch == YES) {
            gameEngine.canTouch = NO;
            [self unschedule:@selector(countDown)];
            isGameOver = YES;
            [self gameOver];
        }
    }
}

-(void) addPoints:(int)points
{
    [GameController sharedController].statsManager.score += points;
    [self updateScore];
}

-(void) updateScore
{
    [score setString:[NSString stringWithFormat:@"%i",[GameController sharedController].statsManager.score]];
}

-(void) gameOver
{
    isPlaying = NO;
    gameOverView = [Match4GameOverLayer node];
    gameOverView.position = ccp(0, 120);
    [self addChild:gameOverView];
}

-(void) pause
{
    pauseLayer = [Match4PauseLayer node];
    pauseLayer.position = ccp(0, 200);
    [self addChild:pauseLayer];
    isPlaying = NO;
    [self unschedule:@selector(countDown)];
}

-(void)resume
{
    [self removeChild:pauseLayer];
    pauseLayer = nil;
    isPlaying = YES;
    [self schedule:@selector(countDown) interval:1];
}

-(void)restart
{
    [self removeChild:gameOverView];
    gameOverView = nil;
    isPlaying = YES;
    isGameOver = NO;
    [GameController sharedController].statsManager.score = 0;
    [self updateScore];
    self.timer = 60;
    play_timeBar.scaleX = 1.32;
    [gameEngine resetGame];
    [self schedule:@selector(countDown) interval:1];
}

@end
