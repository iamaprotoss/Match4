//
//  Match4FriendsLayer.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4FriendsLayer.h"

@implementation Match4FriendsLayer
@synthesize facebooklogin, friendsbanner, friendsbg, friendsrow;

- (id) init
{
    if ([super init]) {
        friendsbg = [CCSprite spriteWithFile:@"friends_bg.png"];
        friendsbg.position = ccp(160, 206);
        [self addChild:friendsbg];
        
        friendsbanner = [CCSprite spriteWithFile:@"friends_-banner.png"];
        friendsbanner.position = ccp(160, 280);
        [self addChild:friendsbanner];
        
        facebooklogin = [CCSprite spriteWithFile:@"start_facebook_login.png"];
        facebooklogin.position = ccp(160, 90);
        [self addChild:facebooklogin];
        
        //self.position = ccp(160, 320);
    }
    return self;
}

@end
