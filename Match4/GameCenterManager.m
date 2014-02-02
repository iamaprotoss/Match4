//
//  GameCenterManager.m
//  Match4
//
//  Created by Zhenwei on 14-1-25.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "GameCenterManager.h"

@implementation GameCenterManager

@synthesize isUserAuthenticated;

-(id) init
{
    if (self = [super init]) {
        isUserAuthenticated = NO;
        isGameCenterAvailable = [self isGameCenterAPIAvailable];
        if (isGameCenterAvailable) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
    }
    return self;
}

-(BOOL) isGameCenterAPIAvailable
{
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (localPlayerClassAvailable && osVersionSupported);
}

-(void) authenticateLocalUser
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
        [self setLastError:error];
        if ([CCDirector sharedDirector].isPaused) {
            [[CCDirector sharedDirector] resume];
        } else if (viewController != nil) {
            [[CCDirector sharedDirector] pause];
            [self presentViewController:viewController];
        } else if (localPlayer.isAuthenticated) {
            
        } else {
            NSLog(@"local player not authenticated");
        }
    };
    /*
    if (!isGameCenterAvailable) return;
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    } else {
        NSLog(@"Already authenticated!");
    }*/
}

-(void) setLastError:(NSError *)error
{
    if (error) {
        NSLog(@"GameCenterManager ERROR: %@", [[error userInfo] description]);
    }
}


-(void)presentViewController:(UIViewController*)vc
{
    [[CCDirector sharedDirector] presentViewController:vc animated:YES completion:nil];
}

- (void)authenticationChanged {
    if ([GKLocalPlayer localPlayer].isAuthenticated && !isUserAuthenticated) {
        isUserAuthenticated = TRUE;
        //[self checkInvites];
    }
    else if (![GKLocalPlayer localPlayer].isAuthenticated && isUserAuthenticated) {
        isUserAuthenticated = FALSE;
    }
}

- (void)submitHighScore:(NSInteger)score
{
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:HIGH_SCORE_LEADERBOARD];
    scoreReporter.value = score;
    scoreReporter.context = 0;
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)showLeaderboards
{
    
    GKGameCenterViewController *gameCenterController = [[[GKGameCenterViewController alloc] init] autorelease];
    
    if (gameCenterController != nil)
        
    {
        
        //Sun
        gameCenterController.gameCenterDelegate = self;//view;//view;
        
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        
        //gameCenterController.leaderboardTimeScope = GKLeaderboardTimeScopeToday;//sun GKLeaderboardTimeScopeToday;
        
        
        // gameCenterController.leaderboardCategory = nil; Sun
        
        //[view presentViewController: gameCenterController animated: YES completion:nil];
        [self presentViewController:gameCenterController];
        
    }
    
}

- (void) reloadHighScores
{
	GKLeaderboard* leaderBoard= [[[GKLeaderboard alloc] init] autorelease];
	leaderBoard.category= HIGH_SCORE_LEADERBOARD;
	leaderBoard.timeScope= GKLeaderboardTimeScopeAllTime;
	leaderBoard.range= NSMakeRange(1, 1);
	
	/*[leaderBoard loadScoresWithCompletionHandler:  ^(NSArray *scores, NSError *error)
     {
         [self callDelegateOnMainThread: @selector(reloadScoresComplete:error:) withArg: leaderBoard error: error];
     }];*/
}

#pragma mark GAME CENTER
- (void) showLeaderboard
{
	GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
	if (leaderboardController != NULL)
	{
		leaderboardController.category = @"com.sincerupt.match4.HighScores";
		leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
		leaderboardController.leaderboardDelegate = self;
		[[CCDirector sharedDirector] presentViewController:leaderboardController animated:YES completion:nil];
	}
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [[CCDirector sharedDirector] dismissViewControllerAnimated:YES completion:nil];
    [viewController release];
}



@end
