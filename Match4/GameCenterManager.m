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
            [self authenticateLocalUser];
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
        } else if (viewController) {
            [[CCDirector sharedDirector] pause];
            [self presentViewController:viewController];
        } else {
            NSLog(@"local player not authenticated");
        }
    };
}

-(void) setLastError:(NSError *)error
{
    if (error) {
        NSLog(@"GameCenterManager ERROR: %@", [[error userInfo] description]);
    }
}

-(void)presentViewController:(UIViewController*)vc
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:vc animated:YES completion:nil];
}

@end
