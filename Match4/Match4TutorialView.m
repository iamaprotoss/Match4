//
//  Match4TutorialView.m
//  Match4
//
//  Created by Zhenwei on 14-1-21.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4TutorialView.h"

@implementation Match4TutorialView
@synthesize gameOverView, pauseLayer;
@synthesize gameController;
@synthesize gameEngine;
//@synthesize play_bg, play_points, play_multiplier, play_board, score, gameScore, timer;
@synthesize isGameOver, isPlaying;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    Match4TutorialView *layer = [[Match4TutorialView alloc] initWithDictionary:[GameController sharedController].gameItems];
    
    [scene addChild:layer];
    
    return scene;
}

-(id) initWithDictionary:(NSMutableDictionary *)thisDict
{
    if (self = [super init]) {
        [GameController sharedController].tutorialView = self;
        
        play_bg = [CCSprite spriteWithFile:@"start_bg.png"];
        play_bg.anchorPoint = ccp(0, 0);
        play_bg.position = ccp(0, 0);
        [self addChild:play_bg];
        
        play_board = [CCSprite spriteWithFile:@"play_board2.png"];
        play_board.position = ccp(160, 260);
        //play_board.opacity = 220;
        play_board.scale = 640.0/643;
        [self addChild:play_board];
        
        play_points_bg = [CCSprite spriteWithFile:@"play_points_bg.png"];
        play_points_bg.position = ccp(200, 450);
        [self addChild:play_points_bg];
        gameScore = 0;
        play_points_label = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", gameScore] fontSize:15];
        play_points_label.position = ccp(50, 12);
        [play_points_bg addChild:play_points_label];
        //score.color = ccc3(255, 255, 0);
        //score.opacity = 200;
        //[score enableStrokeWithColor:ccc3(255, 0, 0) size:1 updateImage:YES];
        //[score enableShadowWithOffset:CGSizeMake(3,4) opacity:255 blur:0.5 updateImage:YES];
        play_star = [CCSprite spriteWithFile:@"play_star.png"];
        play_star.position = ccp(0, 12);
        [play_points_bg addChild:play_star];
        play_star_hi = [CCSprite spriteWithFile:@"play_star_hi.png"];
        play_star_hi.position = ccp(20, 20);
        [play_star addChild:play_star_hi];
        
        play_multimark = [CCSprite spriteWithFile:@"play_multimark.png"];
        play_multimark.position = ccp(270, 450);
        [self addChild:play_multimark];
        
        play_time_bg = [CCSprite spriteWithFile:@"play_time_bg.png"];
        play_time_bg.position = ccp(160, 77);
        [self addChild:play_time_bg];
        
        play_time_bar = [CCSprite spriteWithFile:@"play_time_progress.png"];
        play_time_bar.anchorPoint = ccp(0, 0);
        play_time_bar.position = ccp(66, 70);
        //play_timeBar.scaleX = 1.32;
        [self addChild:play_time_bar];
        
        CCSprite *play_pauseNormal = [CCSprite spriteWithFile:@"play_pause_button.png"];
        //play_pauseNormal.anchorPoint = ccp(0.5, 0.5);
        CCSprite *play_pauseSelected = [CCSprite spriteWithFile:@"play_pause_button_I.png"];
        //play_pauseSelected.anchorPoint = ccp(0.5, 0.5);
        CCMenuItemSprite *play_pause = [CCMenuItemSprite itemWithNormalSprite:play_pauseNormal selectedSprite:play_pauseSelected target:self selector:@selector(pause)];
        play_pause_btn= [CCMenu menuWithItems:play_pause, nil];
        play_pause_btn.position = ccp(40, 77);
        [self addChild:play_pause_btn];
        
        CCSprite *play_hintNormal = [CCSprite spriteWithFile:@"play_hint_btn_bg.png"];
        //play_hintNormal.anchorPoint = ccp(0.5, 0.5);
        CCSprite *play_hintSelected = [CCSprite spriteWithFile:@"play_hint_btn_bg_I.png"];
        //play_hintSelected.anchorPoint = ccp(0.5, 0.5);
        CCMenuItemSprite *play_hint = [CCMenuItemSprite itemWithNormalSprite:play_hintNormal selectedSprite:play_hintSelected target:self selector:@selector(hint)];
        play_hint_btn = [CCMenu menuWithItems:play_hint, nil];
        play_hint_btn.position = ccp(280, 77);
        [self addChild:play_hint_btn];
        play_hint_title = [CCSprite spriteWithFile:@"play_hint.png"];
        play_hint_title.position = ccp(280, 77);
        [self addChild:play_hint_title];
        
        /*
         if ([GameController sharedController].localStore.currentGame) {
         [GameController sharedController].localStore.currentGame = [GameItem new];
         } else {
         [GameController sharedController].statsManager.currentMoney = [GameController sharedController].localStore.currentGame.stats.currentMoney;
         [GameController sharedController].statsManager.currentLevel = [GameController sharedController].localStore.currentGame.stats.currentLevel;
         [GameController sharedController].statsManager.currentLife = [GameController sharedController].localStore.currentGame.stats.currentLife;
         }*/
        
        special = [thisDict copy];
        if ([[special objectForKey:@"Time Bonus"] boolValue]) {
            gameTime = 65;
        } else {
            gameTime = 60;
        }
        isPlaying = YES;
        isGameOver = NO;
        gameEngine = [[Match4EngineGame alloc] initWithDictionary:special];
        gameEngine = [[Match4EngineGame alloc] initWithTutorial];
        gameEngine.position = ccp(0, 100);
        [self addChild:gameEngine];
        
        self.timer = gameTime;
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
        play_time_bar.scaleX = self.timer/gameTime;//*1.32;
        //play_timeBar.anchorPoint = ccp(0, 0);
        play_time_bar.position = ccp(66, 70);
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
    gameScore += points;
    [self updateScore];
}

-(void) updateScore
{
    [play_points_label setString:[NSString stringWithFormat:@"%i",gameScore]];
}

-(void) gameOver
{
    isPlaying = NO;
    int totalScore;
    if ([[special objectForKey:@"Score bonus"] boolValue]) {
        totalScore = gameScore * 1.1 * (int)pow([GameController sharedController].statsManager.currentLevel, 1/2);
    } else {
        totalScore = gameScore * (int)pow([GameController sharedController].statsManager.currentLevel, 1/2);
    }
    [GameController sharedController].statsManager.currentExperience += totalScore;
    [self computeLevel];
    int moneyObtained = (int)pow(gameScore/100, 1/2)*100;
    [[GameController sharedController].moneyManager addCoins:moneyObtained];
    gameOverView = [[Match4GameOverLayer alloc] initWithScore:totalScore money:moneyObtained];
    gameOverView.position = ccp(0, 120);
    [self addChild:gameOverView];
}

-(void) computeLevel
{
    int experience = [GameController sharedController].statsManager.currentExperience;
    int level = [GameController sharedController].statsManager.currentLevel;
    int residual = experience - (level-1)*level*(2*level-1)/6*1000;
    while (residual > 0) {
        residual -= pow(level, 2)*1000;
        level ++;
    }
    [GameController sharedController].statsManager.currentLevel = level;
}

-(void) computeMoney
{
    int money = [GameController sharedController].statsManager.currentMoney;
    money += (int)pow(gameScore, 1/2);
    [GameController sharedController].statsManager.currentMoney = money;
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
    gameScore = 0;
    [self updateScore];
    self.timer = 60;
    //play_time_bar.scaleX = 1.32;
    [gameEngine resetGame];
    [self schedule:@selector(countDown) interval:1];
}

-(void)hint
{
    CGPoint hintPos = [gameEngine getHint];
    if (hintPos.x == -1) {
        [self proposeReshuffle];
    } else {
        [gameEngine showHint:hintPos];
    }
}

-(void)proposeReshuffle
{
    [gameEngine reshuffle];
}



@end
