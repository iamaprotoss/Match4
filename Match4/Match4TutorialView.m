//
//  Match4TutorialView.m
//  Match4
//
//  Created by Zhenwei on 14-1-21.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4TutorialView.h"

@implementation HelpView
+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    HelpView *layer = [[HelpView alloc] init];
    
    [scene addChild:layer];
    
    return scene;
}

-(id) init
{
    if (self = [super init]) {
        /*CCMenuItemSprite *helpBg = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"help_bg_3.5.png"] selectedSprite:[CCSprite spriteWithFile:@"help_bg_3.5.png"] target:self selector:@selector(clickToContinue)];
        CCMenu *h = [CCMenu menuWithItems:helpBg, nil];
        h.anchorPoint = ccp(0, 0);
        h.position = ccp(0, 0);
        [self addChild:h];*/
        NSMutableArray *str = [[NSMutableArray alloc] initWithObjects:
                               @"Swipe to connect at least",
                               @"4 elements together(not ",
                               @"necessarily in a line) to ",
                               @"eliminate them. Combination ",
                               @"of a group of blazing jades ",
                               @"will result in special effect.",
                               nil];
        for (int i = 0; i < 6; i++) {
            Match4Label *helpLabel = [Match4Label labelWithString:[str objectAtIndex:i] fontSize:16];
            helpLabel.position = ccp(160, 400-i*40);
            [self addChild:helpLabel];
        }
        Match4Label *helpLabel = [Match4Label labelWithString:@"click to continue" fontSize:12];
        helpLabel.position = ccp(160, 100);
        [self addChild:helpLabel];
        [self setTouchEnabled:YES];
    }
    return self;
}

-(void) registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0  swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self removeAllChildren];
    Match4TutorialView *layer = [[Match4TutorialView alloc] init];
    [self addChild:layer];
    return YES;
}


@end

@implementation Match4TutorialView
@synthesize gameOverView, pauseLayer;
@synthesize gameController;
@synthesize gameEngine;
@synthesize timer;
//@synthesize play_bg, play_points, play_multiplier, play_board, score, gameScore, timer;
@synthesize isGameOver, isPlaying;

-(id) init
{
    if (self = [super init]) {
        [GameController sharedController].tutorialView = self;
        
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
            play_multi_label.position = ccp(290, 500);
            [self addChild:play_multi_label];
            
            play_time_bg = [CCSprite spriteWithFile:@"play_time_bg.png"];
            play_time_bg.position = ccp(160, 67);
            [self addChild:play_time_bg];
            
            play_time_bar = [CCSprite spriteWithFile:@"play_time_progress.png"];
            play_time_bar.anchorPoint = ccp(0, 0);
            play_time_bar.position = ccp(66, 60);
            //play_timeBar.scaleX = 1.32;
            [self addChild:play_time_bar];
            
            CCSprite *play_pauseNormal = [CCSprite spriteWithFile:@"play_pause_button.png"];
            //play_pauseNormal.anchorPoint = ccp(0.5, 0.5);
            CCSprite *play_pauseSelected = [CCSprite spriteWithFile:@"play_pause_button_l.png"];
            //play_pauseSelected.anchorPoint = ccp(0.5, 0.5);
            CCMenuItemSprite *play_pause = [CCMenuItemSprite itemWithNormalSprite:play_pauseNormal selectedSprite:play_pauseSelected target:self selector:@selector(pause)];
            play_pause_btn= [CCMenu menuWithItems:play_pause, nil];
            play_pause_btn.position = ccp(40, 67);
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
            
            gameTime = 60;
            isPlaying = NO;
            isGameOver = NO;
            gameEngine = [[Match4EngineGame alloc] initWithDictionary:special];
            gameEngine = [[Match4EngineGame alloc] initWithTutorial];
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
            
            play_time_bg = [CCSprite spriteWithFile:@"play_time_bg.png"];
            play_time_bg.position = ccp(160, 67);
            [self addChild:play_time_bg];
            
            play_time_bar = [CCSprite spriteWithFile:@"play_time_progress.png"];
            play_time_bar.anchorPoint = ccp(0, 0);
            play_time_bar.position = ccp(66, 60);
            //play_timeBar.scaleX = 1.32;
            [self addChild:play_time_bar];
            
            CCSprite *play_pauseNormal = [CCSprite spriteWithFile:@"play_pause_button.png"];
            //play_pauseNormal.anchorPoint = ccp(0.5, 0.5);
            CCSprite *play_pauseSelected = [CCSprite spriteWithFile:@"play_pause_button_l.png"];
            //play_pauseSelected.anchorPoint = ccp(0.5, 0.5);
            CCMenuItemSprite *play_pause = [CCMenuItemSprite itemWithNormalSprite:play_pauseNormal selectedSprite:play_pauseSelected target:self selector:@selector(pause)];
            play_pause_btn= [CCMenu menuWithItems:play_pause, nil];
            play_pause_btn.position = ccp(40, 67);
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
            
            gameTime = 60;
            isPlaying = NO;
            isGameOver = NO;
            gameEngine = [[Match4EngineGame alloc] initWithDictionary:special];
            gameEngine = [[Match4EngineGame alloc] initWithTutorial];
            gameEngine.position = ccp(0, 100);
            [self addChild:gameEngine];

        }
        
        self.timer = gameTime;
        [self schedule:@selector(countDown) interval:1];
        canTouch = NO;
        
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
        play_time_bar.position = ccp(66, 60);
        //[self addChild:play_timeBar];
        if (self.timer <= 0 && gameEngine.canTouch == YES) {
            gameEngine.canTouch = NO;
            [self unschedule:@selector(countDown)];
            isGameOver = YES;
            //[self gameOver];
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


-(void) pause
{
    if (canTouch) {
        pauseLayer = [Match4PauseLayer node];
        pauseLayer.position = ccp(0, 200);
        [self addChild:pauseLayer];
        isPlaying = NO;
        [self unschedule:@selector(countDown)];
    }
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
    if (canTouch) {
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

-(void) quit
{
    if (IS_IPHONE_5) {
        CCSprite *helpBg = [CCSprite spriteWithFile:@"help_bg_4.png"];
        helpBg.anchorPoint = ccp(0, 0);
        helpBg.position = ccp(0, 0);
        [self addChild:helpBg];
        
        CCMenuItemSprite *help_exit = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"help_exit_bg.png"] selectedSprite:[CCSprite spriteWithFile:@"help_exit_bg.png"] target:self selector:@selector(showMenu)];
        CCMenu *helpMenu = [CCMenu menuWithItems:help_exit, nil];
        helpMenu.position = ccp(160, 260);
        [self addChild:helpMenu];
        
        CCSprite *help_exit_label = [CCSprite spriteWithFile:@"help_exit_exit.png"];
        help_exit_label.position = ccp(160, 260);
        [self addChild:help_exit_label];
    } else {
        CCSprite *helpBg = [CCSprite spriteWithFile:@"help_bg_3.5.png"];
        helpBg.anchorPoint = ccp(0, 0);
        helpBg.position = ccp(0, 0);
        [self addChild:helpBg];
        
        CCMenuItemSprite *help_exit = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"help_exit_bg.png"] selectedSprite:[CCSprite spriteWithFile:@"help_exit_bg.png"] target:self selector:@selector(showMenu)];
        CCMenu *helpMenu = [CCMenu menuWithItems:help_exit, nil];
        helpMenu.position = ccp(160, 240);
        [self addChild:helpMenu];
        
        CCSprite *help_exit_label = [CCSprite spriteWithFile:@"help_exit_exit.png"];
        help_exit_label.position = ccp(160, 240);
        [self addChild:help_exit_label];
    }
    
}

-(void) showMenu
{
    [[GameController sharedController] showMainView:NO];
}


@end
