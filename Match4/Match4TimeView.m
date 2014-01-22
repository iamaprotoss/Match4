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
@synthesize play_bg, play_points, play_multiplier, play_board, score, gameScore, timer;
@synthesize isGameOver, isPlaying;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    Match4TimeView *layer = [[Match4TimeView alloc] initWithDictionary:[GameController sharedController].gameItems];
    
    [scene addChild:layer];
    
    return scene;
}

-(id) initWithDictionary:(NSMutableDictionary *)thisDict
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
        gameScore = 0;
        score = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", gameScore] fontSize:20];
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
        menu.position = ccp(280, 40);
        [self addChild:menu];
        
        CCSprite *play_hintNormal = [CCSprite spriteWithFile:@"play_help_btn_bg.png"];
        play_hintNormal.anchorPoint = ccp(0.5, 0.5);
        CCSprite *play_hintSelected = [CCSprite spriteWithFile:@"play_help_btn_bg.png"];
        play_hintSelected.anchorPoint = ccp(0.5, 0.5);
        CCMenuItemSprite *play_hint = [CCMenuItemSprite itemWithNormalSprite:play_hintNormal selectedSprite:play_hintSelected target:self selector:@selector(hint)];
        CCMenu *hint = [CCMenu menuWithItems:play_hint, nil];
        hint.position = ccp(280, 77);
        [self addChild:hint];
        
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
        //gameEngine = [[Match4EngineGame alloc] initWithDictionary:special];
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
        play_timeBar.scaleX = self.timer/gameTime*1.32;
        //play_timeBar.anchorPoint = ccp(0, 0);
        play_timeBar.position = ccp(66, 70);
        //[self addChild:play_timeBar];
        /*if (self.timer <= 0 && gameEngine.canTouch == YES) {
            gameEngine.canTouch = NO;
            [self unschedule:@selector(countDown)];
            isGameOver = YES;
            [self gameOver];
        }*/
    }
}

-(void) addPoints:(int)points
{
    gameScore += points;
    [self updateScore];
}

-(void) updateScore
{
    [score setString:[NSString stringWithFormat:@"%i",gameScore]];
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
    play_timeBar.scaleX = 1.32;
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
