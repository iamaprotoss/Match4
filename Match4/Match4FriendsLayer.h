//
//  Match4FriendsLayer.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
@class Match4Label;

@interface Match4FriendsLayer : CCLayer
{
    CCSprite *friendsbg;
    CCSprite *facebooklogin;
    CCSprite *friendsbanner;
    CCSprite *friendsrow;
    Match4Label *highScoreLabel;
}

@property (retain, nonatomic) CCSprite *friendsbg;
@property (retain, nonatomic) CCSprite *facebooklogin;
@property (retain, nonatomic) CCSprite *friendsbanner;
@property (retain, nonatomic) CCSprite *friendsrow;
@property (retain, nonatomic) CCSprite *highScoreLabel;


@end
