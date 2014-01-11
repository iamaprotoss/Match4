//
//  GameController.h
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalStorageManager.h"
#import "StatsManager.h"
#import "SoundController.h"
#import "MusicController.h"
#import "ElementManager.h"
#import "LabelManager.h"
#import "ValuesManager.h"
@class Match4MainView;
@class Match4TimeView;
@class Match4ItemLayer;

@interface GameController : NSObject
{
    LocalStorageManager *localStore;
    StatsManager *statsManager;
    SoundController *soundController;
    MusicController *musicController;
    ElementManager *elementManager;
    LabelManager *labelManager;
    ValuesManager *valuesManager;
    
    Match4MainView *mainView; // Match4MainView
    Match4TimeView *timeView; // Match4TimeView
    Match4ItemLayer *itemView; // Match4ItemLayer
    
    NSMutableDictionary *gameItems;
    
    BOOL isInGame;
}

@property (nonatomic, retain) LocalStorageManager *localStore;
@property (nonatomic, retain) StatsManager *statsManager;
@property (nonatomic, retain) SoundController *soundController;
@property (nonatomic, retain) MusicController *musicController;
@property (nonatomic, retain) ElementManager *elementManager;
@property (nonatomic, retain) LabelManager *labelManager;
@property (nonatomic, retain) ValuesManager *valuesManager;

@property (nonatomic, retain) Match4MainView *mainView;
@property (nonatomic, retain) Match4TimeView *timeView;
@property (nonatomic, retain) Match4ItemLayer *itemView;

@property (nonatomic, retain) NSMutableDictionary *gameItems;

@property (nonatomic) BOOL isInGame;

+ (GameController *)sharedController;
//- (void)showIntroView;
- (void)showMainView;
//- (void)showPrimaryView;
- (void)showGameView;
- (void)showItemView;

- (BOOL) addItem:(int)thisTag;
- (void) resetItem;
/*- (void)showInfinityView;
//- (void)showEngageView;
//- (void)showPowerUpViewInView:(MSSView *)thisView;
//- (void)showIAPViewInView:(MSSView *)thisView;
- (void)showMoreView;
- (void)showInfoView;
- (void)showShortenedInfoView;
- (void)showTopScores;

- (void)showchooseBackgroundView;
-(void)chooseBackgroundBackButton;


- (void)pauseGame;
- (void)resumeGame;
- (void)backToMenuFromPause;

- (void)gameOverWithReason:(NSString *)thisReason;
- (void)restartGame;
- (void)restartLevel;
- (void)backToMenuFromGameOver;

- (void)removeMainView;
- (void)removeView:(UIView *)thisView;

- (void)showFullScreenAd;
- (void)cacheFullScreenAd;
- (void)getFreeApp;

- (void)removeBanner: (id)sender;

- (void)showFlurryBanner;
- (void)hideFlurryBanner;
//- (void)showBannerExitButton;
- (void)bottomBanner;

- (void)showbackgroundOVerlay;
- (void)showLockedBackground;
- (void)removeLockedBackground;


-(void)changeBackground1;
-(void)changeBackground2;
-(void)changeBackground3;
-(void)changeBackground4;
-(void)changeBackground5;

- (void)removeAdForever;
- (void)moreAppsForFull;
-(void)logAllViews;
*/
@end
