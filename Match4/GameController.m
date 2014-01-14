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
@synthesize localStore, statsManager, soundController, musicController, elementManager, labelManager, valuesManager, moneyManager, timeView, mainView, itemView, gameItems, isInGame;

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

- (BOOL) addItem:(int)thisTag
{
    switch (thisTag) {
        case 1:
            if (![[gameItems objectForKey:@"Time Bonus"] boolValue]) {
                [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Time Bonus"];
                return YES;
            } else {
                return NO;
            }
            break;
        case 2:
            if (![[gameItems objectForKey:@"Score Bonus"] boolValue]) {
                [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Score Bonus"];
                return YES;
            } else {
                return NO;
            }
            break;
        case 3:
            if (![[gameItems objectForKey:@"Initial Superior Element"] boolValue]) {
                [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Initial Superior Element"];
                return YES;
            } else {
                return NO;
            }
            break;
        case 4:
            if (![[gameItems objectForKey:@"Initial Double Score"] boolValue]) {
                [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Initial Double Score"];
                return YES;
            } else {
                return NO;
            }
            break;
        case 5:
            if (![[gameItems objectForKey:@"Random Superior Element"] boolValue]) {
                [gameItems setObject:[NSNumber numberWithBool:YES] forKey:@"Random Superior Element"];
                return YES;
            } else {
                return NO;
            }
            break;
        default:
            return NO;
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
