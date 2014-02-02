//
//  GameCenterManager.h
//  Match4
//
//  Created by Zhenwei on 14-1-25.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

//#define APP_HANDLED_URL @"APP_HANDLED_URL"
#define HIGH_SCORE_LEADERBOARD @"com.sincerupt.match4.HighScores"
#define DEEP_LINK @"https://m.facebook.com/apps/vivastampede/?deeplink=news"
#define FB_ICON @"http://brightnewt.com/wp-content/uploads/2013/08/iTunesArtwork@2x.png"

@interface GameCenterManager : NSObject <GKLeaderboardViewControllerDelegate, GKGameCenterControllerDelegate>//GKMatchmakerViewControllerDelegate, GKMatchDelegate, > {
{
    BOOL isGameCenterAvailable;
    BOOL isUserAuthenticated;
    //BOOL isMatchStarted;
    //BOOL isWaitingForOtherPlayer;
    //BOOL isOtherPlayerWaiting;
    //GKMatch *myMatch;
    //GKPlayer *otherPlayer;
    //GKInvite *pendingInvite;
    //NSArray *pendingPlayersToInvite;
    unsigned long long fbplayerID;
}

@property (nonatomic) BOOL isUserAuthenticated;
//@property (nonatomic) BOOL isMatchStarted;
//@property (nonatomic) BOOL isWaitingForOtherPlayer;
//@property (nonatomic) BOOL isOtherPlayerWaiting;
//@property (nonatomic, retain) GKMatch *myMatch;
//@property (nonatomic, retain) GKPlayer *otherPlayer;
//@property (nonatomic, retain) GKInvite *pendingInvite;
//@property (nonatomic, retain) NSArray *pendingPlayersToInvite;

- (BOOL)isGameCenterAPIAvailable;
- (void)authenticationChanged;
- (void)authenticateLocalUser;
//- (void)checkInvites;
//- (void)disconnect;

//- (void)startMatch;
//- (void)restartMatch;
//- (void)checkRestart;
//- (void)lookupPlayers;
//- (void)sendPacket:(NSData *)thisPacket;
- (void)submitHighScore:(NSInteger)score;
- (void)showLeaderboards;//(UIViewController *)view;
- (void)showLeaderboard;
- (void)submitScoreToFB:(NSInteger)score;


 
@end

