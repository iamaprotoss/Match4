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
#import "Match4ItemLayer.h"

@implementation GameController
@synthesize localStore, statsManager, soundController, musicController, elementManager, labelManager, valuesManager, moneyManager, storeObserver, timeView, mainView, itemView, gameItems, isInGame;

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
        labelManager = [[LabelManager alloc] init];
        valuesManager = [[ValuesManager alloc] init];
        moneyManager = [[MoneyManager alloc] init];
        storeObserver = [[StoreObserver alloc] init];
        storeObserver.delegate = moneyManager;
        gameItems = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
         [NSNumber numberWithBool:NO], @"Time Bonus",
         [NSNumber numberWithBool:NO], @"Score Bonus",
         [NSNumber numberWithBool:NO], @"Initial Superior Element",
         [NSNumber numberWithBool:NO], @"Initial Double Score",
         [NSNumber numberWithBool:NO], @"Random Superior Element", 
         nil];
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
    [self resetItem];
}

- (void) addItem:(int)thisTag
{
    switch (thisTag) {
        case 1:
            [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Time Bonus"];
            break;
        case 2:
            [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Score Bonus"];
            break;
        case 3:
            [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Initial Superior Element"];
            break;
        case 4:
            [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Initial Double Score"];
            break;
        case 5:
            [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Random Superior Element"];
            break;
        default:
            break;
    }
}

-(void) deleteItem:(int)thisTag
{
    switch (thisTag) {
        case 1:
            [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Time Bonus"];
            break;
        case 2:
            [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Score Bonus"];
            break;
        case 3:
            [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Initial Superior Element"];
            break;
        case 4:
            [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Initial Double Score"];
            break;
        case 5:
            [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Random Superior Element"];
            break;
        default:
            break;
    }
}

-(void) resetItem
{
    [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Time Bonus"];
    [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Score Bonus"];
    [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Initial Superior Element"];
    [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Initial Double Score"];
    [gameItems setObject:[NSNumber numberWithBool:NO] forKey:@"Random Superior Element"];
}

@end
