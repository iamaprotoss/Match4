//
//  Match4FriendsLayer.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4FriendsLayer.h"
#import "GameController.h"
#import "Match4Label.h"

@implementation Match4FriendsLayer
@synthesize facebooklogin, friendsbanner, friendsbg, friendsrow;

- (id) init
{
    if ([super init]) {
        friendsbg = [CCSprite spriteWithFile:@"friends_bg.png"];
        friendsbg.position = ccp(160, 206);
        [self addChild:friendsbg];
        
        friendsbanner = [CCSprite spriteWithFile:@"friends_banner.png"];
        friendsbanner.position = ccp(160, 280);
        [self addChild:friendsbanner];
        
        facebooklogin = [CCSprite spriteWithFile:@"start_facebook_bg.png"];
        facebooklogin.position = ccp(160, 90);
        [self addChild:facebooklogin];
        
        friendsrow = [CCSprite spriteWithFile:@"friends_tag.png"];
        friendsrow.position = ccp(160, 220);
        [self addChild:friendsrow];
        
        highScoreLabel = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", [GameController sharedController].statsManager.highScore] fontSize:20];
        highScoreLabel.position = ccp(50, 20);
        [friendsrow addChild:highScoreLabel];
        
        //self.position = ccp(160, 320);
    }
    return self;
}

@end
