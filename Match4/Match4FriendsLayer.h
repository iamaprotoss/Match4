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
    CCSprite *friendsbanner;
    CCSprite *friendsrow[3];
    Match4Label *highScoreLabel;
    CCSprite *start_title;
}


@end
