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

- (id) init
{
    if ([super init]) {
        NSMutableArray *str = [NSMutableArray arrayWithObjects:@"1st", @"2nd", @"3rd", nil];
        friendsbg = [CCSprite spriteWithFile:@"friends_bg_1@2x.png"];
        friendsbg.position = ccp(160, 206);
        [self addChild:friendsbg];
        
        start_title = [CCSprite spriteWithFile:@"start_title1@2x.png"];
        start_title.position = ccp(160, 280);
        [friendsbg addChild:start_title];
        
        friendsbanner = [CCSprite spriteWithFile:@"item_banner@2x.png"];
        friendsbanner.position = ccp(160, 315);
        [self addChild:friendsbanner];
        
        for (int i = 0; i < 3; i++) {
            friendsrow[i] = [CCSprite spriteWithFile:@"friends_tag.png"];
            friendsrow[i].position = ccp(160, 260-60*i);
            [self addChild:friendsrow[i]];
            Match4Label *rank = [Match4Label labelWithString:[str objectAtIndex:i] fontSize:20];
            rank.position = ccp(50, 20);
            [friendsrow[i] addChild:rank];
            highScoreLabel = [Match4Label labelWithString:[NSString stringWithFormat:@"%i",[[GameController sharedController].statsManager getHighScore:i]] fontSize:20];
            highScoreLabel.position = ccp(200, 20);
            [friendsrow[i] addChild:highScoreLabel];
        }
        
        //self.position = ccp(160, 320);
    }
    return self;
}

@end
