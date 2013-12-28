//
//  Match4TimeView.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4TimeView.h"

@implementation Match4TimeView

@synthesize gameController;
@synthesize bg, points, multiplier, panel, play_pause;

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
        /*bg = [CCSprite spriteWithFile:@"start_bg.png"];
        bg.scaleX = 0.33;
        bg.scaleY = 0.3;
        bg.anchorPoint = ccp(0, 0);
        bg.position = ccp(0, 0);
        [self addChild:bg];
        
        points = [CCSprite spriteWithFile:@"start_points.png"];
        points.scaleX = 0.33;
        points.scaleY = 0.3;
        points.position = ccp(144, 447);
        [self addChild:points];
        
        multiplier = [CCSprite spriteWithFile:@"play_multi.png"];
        multiplier.scaleX = 0.33;
        multiplier.scaleY = 0.3;
        multiplier.anchorPoint = ccp(273, 449);
        [self addChild:multiplier];
        
        panel = [CCSprite spriteWithFile:@"play_down.png"];
        panel.scaleX = 0.33;
        panel.scaleY = 0.3;
        panel.position = ccp(160, 70);
        [self addChild:panel];
        
        play_pause = [CCSprite spriteWithFile:@"play_pause.png"];
        play_pause.scaleX = 0.33;
        play_pause.scaleY = 0.3;
        play_pause.position = ccp(287, 27);
        [self addChild:play_pause];*/
        
        gameController = [GameController sharedController];
        if (gameController.localStore.currentGame) {
            gameController.localStore.currentGame = [GameItem new];
        } else {
            gameController.statsManager.currentMoney = gameController.localStore.currentGame.stats.currentMoney;
            gameController.statsManager.currentLevel = gameController.localStore.currentGame.stats.currentLevel;
            gameController.statsManager.currentLife = gameController.localStore.currentGame.stats.currentLife;
        }
        
        gameEngine = [[Match4EngineTime alloc] init];
        gameEngine.position = ccp(0, 100);
        [self addChild:gameEngine];        
        
    }
    return self;
}

-(void) addPoints:(int)points
{
    gameController.statsManager.score += points;
    [self updateScore];
}

-(void) updateScore
{
    
}

@end
