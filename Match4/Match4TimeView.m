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
@synthesize gameOverView;
@synthesize gameController;
@synthesize play_bg, play_points, play_multiplier, play_panel, score;
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
        
        play_points = [CCSprite spriteWithFile:@"play_points.png"];
        play_points.position = ccp(144, 447);
        [self addChild:play_points];
        score = [Match4Label labelWithString:@"0" fontSize:30];
        [play_points addChild:score];
        score.position = ccp(10, 10);
        
        play_multiplier = [CCSprite spriteWithFile:@"play_multi.png"];
        play_multiplier.anchorPoint = ccp(273, 449);
        [self addChild:play_multiplier];
        
        play_panel = [CCSprite spriteWithFile:@"play_down.png"];
        play_panel.position = ccp(160, 70);
        [self addChild:play_panel];
        
        play_timeBg = [CCSprite spriteWithFile:@"play_timebar.png"];
        play_timeBg.position = ccp(160, 80);
        [self addChild:play_timeBg];
        
        CCSprite *play_pauseNormal = [CCSprite spriteWithFile:@"play_pause.png"];
        play_pauseNormal.anchorPoint = ccp(0.5, 0.5);
        CCSprite *play_pauseSelected = [CCSprite spriteWithFile:@"play_pause.png"];
        play_pauseSelected.anchorPoint = ccp(0.5, 0.5);
        CCMenuItemSprite *play_pause = [CCMenuItemSprite itemWithNormalSprite:play_pauseNormal selectedSprite:play_pauseSelected target:self selector:@selector(gameOver)];
        CCMenu *menu = [CCMenu menuWithItems:play_pause, nil];
        menu.position = ccp(287, 27);
        [self addChild:menu];
        
        if ([GameController sharedController].localStore.currentGame) {
            [GameController sharedController].localStore.currentGame = [GameItem new];
        } else {
            [GameController sharedController].statsManager.currentMoney = [GameController sharedController].localStore.currentGame.stats.currentMoney;
            [GameController sharedController].statsManager.currentLevel = [GameController sharedController].localStore.currentGame.stats.currentLevel;
            [GameController sharedController].statsManager.currentLife = [GameController sharedController].localStore.currentGame.stats.currentLife;
            [GameController sharedController].statsManager.score = 0;
        }
        
        gameEngine = [[Match4EngineTime alloc] init];
        gameEngine.position = ccp(0, 100);
        [self addChild:gameEngine];        
        
        self.timer = 60;
        [self schedule:@selector(countDown) interval:1];
    }
    return self;
}

-(void) countDown
{
    self.timer --;
    [play_timeBar removeFromParent];
    play_timeBar = [CCSprite spriteWithFile:@"SFX3_20.png" rect:CGRectMake(0, 0, 100, 5*self.timer)];
    play_timeBar.rotation = 90;
    play_timeBar.anchorPoint = ccp(0, 0);
    play_timeBar.position = ccp(20, 105);
    [self addChild:play_timeBar];
    if (self.timer <= 0) {
        [self unschedule:@selector(countDown)];
        isGameOver = YES;
        [self gameOver];
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
    gameOverView = [GameOverView node];
    [self addChild:gameOverView];
}

@end
