//
//  GameController.m
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "GameController.h"
#import "Match4MainView.h"
#import "Match4TimeView.h"
#import "Match4ItemView.h"

@implementation GameController
@synthesize localStore, statsManager, soundController, musicController, elementManager, timeView, mainView, isInGame;

+(GameController *)sharedController
{
    static GameController *sharedController;
    
    @synchronized(self)
    {
        if (!sharedController) {
            sharedController = [[GameController alloc] init];
        }
        return sharedController;
    }
}

- (id) init
{
    if (self = [super init]) {
        statsManager = [[StatsManager alloc] init];
        soundController = [[SoundController alloc] init];
        musicController = [[MusicController alloc] init];
        elementManager = [[ElementManager alloc] init];
    }
    return self;
}

- (void)showMainView
{
    [[CCDirector sharedDirector] replaceScene:[Match4MainView scene]];
}

- (void)showGameView
{
    [[CCDirector sharedDirector] replaceScene:[Match4TimeView scene]];
}

- (void)showItemView
{
    [[CCDirector sharedDirector] replaceScene:[Match4ItemView scene]];
}

@end
