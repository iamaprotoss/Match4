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
//@synthesize play_bg, play_points, play_multiplier, play_board, score, gameScore, timer;
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
        
        if (IS_IPHONE_5) {
            play_bg = [CCSprite spriteWithFile:@"start_bg.png"];
            play_bg.anchorPoint = ccp(0, 0);
            play_bg.position = ccp(0, 0);
            [self addChild:play_bg];
            
            play_board = [CCSprite spriteWithFile:@"play_board.png"];
            play_board.position = ccp(160, 280);
            //play_board.opacity = 220;
            play_board.scale = 640.0/643;
            [self addChild:play_board];
            
            play_points_bg = [CCSprite spriteWithFile:@"play_points_bg.png"];
            play_points_bg.position = ccp(200, 500);
            [self addChild:play_points_bg];
            gameScore = 0;
            play_points_label = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", gameScore] fontSize:18];
            play_points_label.position = ccp(80, 13);
            [play_points_bg addChild:play_points_label];
            //score.color = ccc3(255, 255, 0);
            //score.opacity = 200;
            //[score enableStrokeWithColor:ccc3(255, 0, 0) size:1 updateImage:YES];
            //[score enableShadowWithOffset:CGSizeMake(3,4) opacity:255 blur:0.5 updateImage:YES];
            play_star = [CCSprite spriteWithFile:@"play_star.png"];
            play_star.position = ccp(0, 12);
            [play_points_bg addChild:play_star];
            play_star_hi = [CCSprite spriteWithFile:@"play_star_hi.png"];
            play_star_hi.position = ccp(30, 30);
            [play_star addChild:play_star_hi];
            
            gameMultiplier = 1;
            play_multimark = [CCSprite spriteWithFile:@"play_multimark.png"];
            play_multimark.position = ccp(280, 500);
            [self addChild:play_multimark];
            play_multi_label = [Match4Label labelWithString:@"1" fontSize:18];
            play_multi_label.color = ccc3(20, 120, 150);
            play_multi_label.position = ccp(290, 500);
            [self addChild:play_multi_label];
            
            CCSprite *play_pauseNormal = [CCSprite spriteWithFile:@"play_pause_button.png"];
            CCSprite *play_pauseSelected = [CCSprite spriteWithFile:@"play_pause_button_l.png"];
            CCMenuItemSprite *play_pause = [CCMenuItemSprite itemWithNormalSprite:play_pauseNormal selectedSprite:play_pauseSelected target:self selector:@selector(pause)];
            play_pause_btn= [CCMenu menuWithItems:play_pause, nil];
            play_pause_btn.position = ccp(35, 67);
            [self addChild:play_pause_btn];
            
            CCSprite *play_hintNormal = [CCSprite spriteWithFile:@"play_help_btn_bg.png"];
            //play_hintNormal.anchorPoint = ccp(0.5, 0.5);
            CCSprite *play_hintSelected = [CCSprite spriteWithFile:@"play_help_btn_bg_l.png"];
            //play_hintSelected.anchorPoint = ccp(0.5, 0.5);
            CCMenuItemSprite *play_hint = [CCMenuItemSprite itemWithNormalSprite:play_hintNormal selectedSprite:play_hintSelected target:self selector:@selector(hint)];
            play_hint_btn = [CCMenu menuWithItems:play_hint, nil];
            play_hint_btn.position = ccp(280, 67);
            [self addChild:play_hint_btn];
            play_hint_title = [CCSprite spriteWithFile:@"play_t.png"];
            play_hint_title.position = ccp(280, 67);
            [self addChild:play_hint_title];
            
            special = [thisDict copy];
            if ([[special objectForKey:@"Time Bonus"] boolValue]) {
                gameTime = 65;
            } else {
                gameTime = 60;
            }
            play_time_bg = [CCSprite spriteWithFile:@"play_time_bg.png"];
            play_time_bg.position = ccp(160, 67);
            [self addChild:play_time_bg];
            play_time_bar = [CCSprite spriteWithFile:@"play_time_progress.png"];
            play_time_bar.anchorPoint = ccp(0, 0);
            play_time_bar.position = ccp(66, 60);
            [self addChild:play_time_bar];
            play_time_tick = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", gameTime] fontSize:15];
            play_time_tick.position = ccp(160, 67);
            play_time_tick.color = ccc3(0, 255, 0);
            [self addChild:play_time_tick];

            isPlaying = YES;
            isGameOver = NO;
            gameEngine = [[Match4EngineGame alloc] initWithDictionary:special];
            //gameEngine = [[Match4EngineGame alloc] initWithTutorial];
            gameEngine.position = ccp(0, 120);
            [self addChild:gameEngine];

        } else {
            play_bg = [CCSprite spriteWithFile:@"start_bg.png"];
            play_bg.anchorPoint = ccp(0, 0);
            play_bg.position = ccp(0, 0);
            [self addChild:play_bg];
            
            play_board = [CCSprite spriteWithFile:@"play_board.png"];
            play_board.position = ccp(160, 260);
            //play_board.opacity = 220;
            play_board.scale = 640.0/643;
            [self addChild:play_board];
            
            play_points_bg = [CCSprite spriteWithFile:@"play_points_bg.png"];
            play_points_bg.position = ccp(200, 450);
            [self addChild:play_points_bg];
            gameScore = 0;
            play_points_label = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", gameScore] fontSize:18];
            play_points_label.position = ccp(80, 13);
            [play_points_bg addChild:play_points_label];
            //score.color = ccc3(255, 255, 0);
            //score.opacity = 200;
            //[score enableStrokeWithColor:ccc3(255, 0, 0) size:1 updateImage:YES];
            //[score enableShadowWithOffset:CGSizeMake(3,4) opacity:255 blur:0.5 updateImage:YES];
            play_star = [CCSprite spriteWithFile:@"play_star.png"];
            play_star.position = ccp(0, 12);
            [play_points_bg addChild:play_star];
            play_star_hi = [CCSprite spriteWithFile:@"play_star_hi.png"];
            play_star_hi.position = ccp(30, 30);
            [play_star addChild:play_star_hi];
            
            gameMultiplier = 1;
            play_multimark = [CCSprite spriteWithFile:@"play_multimark.png"];
            play_multimark.position = ccp(280, 450);
            [self addChild:play_multimark];
            play_multi_label = [Match4Label labelWithString:@"1" fontSize:18];
            play_multi_label.position = ccp(290, 450);
            [self addChild:play_multi_label];
            
            CCSprite *play_pauseNormal = [CCSprite spriteWithFile:@"play_pause_button.png"];
            CCSprite *play_pauseSelected = [CCSprite spriteWithFile:@"play_pause_button_l.png"];
            CCMenuItemSprite *play_pause = [CCMenuItemSprite itemWithNormalSprite:play_pauseNormal selectedSprite:play_pauseSelected target:self selector:@selector(pause)];
            play_pause_btn= [CCMenu menuWithItems:play_pause, nil];
            play_pause_btn.position = ccp(35, 67);
            [self addChild:play_pause_btn];
            
            CCSprite *play_hintNormal = [CCSprite spriteWithFile:@"play_help_btn_bg.png"];
            CCSprite *play_hintSelected = [CCSprite spriteWithFile:@"play_help_btn_bg_l.png"];
            CCMenuItemSprite *play_hint = [CCMenuItemSprite itemWithNormalSprite:play_hintNormal selectedSprite:play_hintSelected target:self selector:@selector(hint)];
            play_hint_btn = [CCMenu menuWithItems:play_hint, nil];
            play_hint_btn.position = ccp(280, 67);
            [self addChild:play_hint_btn];
            play_hint_title = [CCSprite spriteWithFile:@"play_t.png"];
            play_hint_title.position = ccp(280, 67);
            [self addChild:play_hint_title];
            
            special = [thisDict copy];
            if ([[special objectForKey:@"Time Bonus"] boolValue]) {
                gameTime = 65;
            } else {
                gameTime = 60;
            }
            play_time_bg = [CCSprite spriteWithFile:@"play_time_bg.png"];
            play_time_bg.position = ccp(160, 67);
            [self addChild:play_time_bg];
            
            play_time_bar = [CCSprite spriteWithFile:@"play_time_progress.png"];
            play_time_bar.anchorPoint = ccp(0, 0);
            play_time_bar.position = ccp(66, 60);
            [self addChild:play_time_bar];
            play_time_tick = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", gameTime] fontSize:15];
            play_time_tick.position = ccp(160, 67);
            play_time_tick.color = ccc3(0, 255, 0);
            [self addChild:play_time_tick];
            isPlaying = YES;
            isGameOver = NO;
            gameEngine = [[Match4EngineGame alloc] initWithDictionary:special];
            gameEngine.position = ccp(0, 100);
            [self addChild:gameEngine];
        }
        
        self.timer = gameTime;
        [self schedule:@selector(countDown) interval:1];
        
    }
    return self;
}

-(void) dealloc
{
    [super dealloc];
}

-(void) countDown
{
    if (isPlaying) {
        if (self.timer > 0) {
            self.timer --;
        }
        play_time_bar.scaleX = 1.0*self.timer/gameTime;
        play_time_bar.position = ccp(66, 60);
        play_time_tick.string = [NSString stringWithFormat:@"%i", self.timer];
        if (self.timer < 10) {
            play_time_tick.color = ccc3(255, 0, 0);
        }
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

-(void) increaseMultiplier
{
    gameMultiplier ++;
    [play_multi_label setString:[NSString stringWithFormat:@"%i", gameMultiplier]];
}

-(void) gameOver
{
    isPlaying = NO;
    gameEngine.canTouch = NO;
    totalScore = 0;
    if ([[special objectForKey:@"Score Bonus"] boolValue]) {
        totalScore = gameScore * (1 +[GameController sharedController].statsManager.currentLevel*1.0/100)*1.1;
    } else {
        totalScore = gameScore * (1 + [GameController sharedController].statsManager.currentLevel*1.0/100);
    }
    if (totalScore > [[GameController sharedController].statsManager getHighScore:0]) {
        [[GameController sharedController].gameCenterManager submitHighScore:totalScore];
    }
    [[GameController sharedController].statsManager insertHighScore:totalScore];
    [self computeLevelAndExperience];
    moneyEarned = [self computeMoney];
    [[GameController sharedController].statsManager setStats];
    
    if (IS_IPHONE_5) {
        mask_bg = [CCSprite spriteWithFile:@"help_bg_4.png"];
        mask_bg.anchorPoint = ccp(0, 0);
        mask_bg.position = ccp(0, 0);
        [self addChild:mask_bg];
        gameOverView = [[Match4GameOverLayer alloc] initWithScore:totalScore money:moneyEarned];
        gameOverView.position = ccp(0, 100);
    } else {
        mask_bg = [CCSprite spriteWithFile:@"help_bg_3.5.png"];
        mask_bg.anchorPoint = ccp(0, 0);
        mask_bg.position = ccp(0, 0);
        [self addChild:mask_bg];
        gameOverView = [[Match4GameOverLayer alloc] initWithScore:totalScore money:moneyEarned];
        gameOverView.position = ccp(0, 80);
    }
    
    [self addChild:gameOverView];
}

-(void) computeLevelAndExperience
{
    int experience = [GameController sharedController].statsManager.currentExperience;
    int level = [GameController sharedController].statsManager.currentLevel;
    int residual = experience + totalScore;
    NSLog(@"%f",pow(level, 2));
    while ((residual - pow(level, 2)*10000) >= 0) {
        residual -= pow(level, 2)*10000;
        level ++;
    }
    [GameController sharedController].statsManager.currentExperience = residual;
    [GameController sharedController].statsManager.currentLevel = level;
}

-(int) computeMoney
{
    int money = (int)(gameScore+200)/5000*100;
    [GameController sharedController].statsManager.currentMoney += money;
    return money;
}

-(void) pause
{
    [[GameController sharedController].soundController playSound:@"GeneralMenuButton"];
    if (isPlaying) {
        if (IS_IPHONE_5) {
            mask_bg = [CCSprite spriteWithFile:@"help_bg_4.png"];
            mask_bg.anchorPoint = ccp(0, 0);
            mask_bg.position = ccp(0, 0);
            [self addChild:mask_bg];
            pauseLayer = [Match4PauseLayer node];
            pauseLayer.position = ccp(0, 220);
            [self addChild:pauseLayer];

        } else {
            mask_bg = [CCSprite spriteWithFile:@"help_bg_3.5.png"];
            mask_bg.anchorPoint = ccp(0, 0);
            mask_bg.position = ccp(0, 0);
            [self addChild:mask_bg];
            pauseLayer = [Match4PauseLayer node];
            pauseLayer.position = ccp(0, 200);
            [self addChild:pauseLayer];

        }
        isPlaying = NO;
        gameEngine.canTouch = NO;
        [self unschedule:@selector(countDown)];
    } else {
        if (pauseLayer != nil) {
            [self resume];
        }
    }
}

-(void)resume
{
    [mask_bg removeFromParent];
    mask_bg = nil;
    [self removeChild:pauseLayer];
    pauseLayer = nil;
    isPlaying = YES;
    gameEngine.canTouch = YES;
    [self schedule:@selector(countDown) interval:1];
}

-(void)restart
{
    BOOL isItem = TRUE;
    [[GameController sharedController] showMainView:isItem];
}

-(void)hint
{
    [[GameController sharedController].soundController playSound:@"GeneralMenuButton"];
    if (isPlaying) {
        CGPoint hintPos = [gameEngine getHint];
        if (hintPos.x == -1) {
            [self proposeReshuffle];
        } else {
            [gameEngine showHint:hintPos];
        }

    }
}

-(void)proposeReshuffle
{
    [gameEngine reshuffle];
}


@end
