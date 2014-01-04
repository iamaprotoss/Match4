//
//  Match4MainView.h
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
#import "Match4FriendsLayer.h"
#import "Match4ItemLayer.h"
@class Match4TimeView;

@interface Match4MainView : CCLayer
{
    CCSprite *bg;
    CCSprite *friendsbg;
    CCSprite *gold;
    CCSprite *facebooklogin;
    NSMutableArray *lives;
    CCMenuItemSprite *option;
    CCSprite *points;
    CCMenuItemSprite *start;
    CCSprite *title;
    CCLayer *friendLayer;
    CCLayer *itemLayer;
}

@property (retain, nonatomic) CCSprite *bg;
@property (retain, nonatomic) CCSprite *friendsbg;
@property (retain, nonatomic) CCSprite *gold;
@property (retain, nonatomic) CCSprite *facebooklogin;
@property (retain, nonatomic) NSMutableArray *lives;
@property (retain, nonatomic) CCMenuItemSprite *option;
@property (retain, nonatomic) CCSprite *points;
@property (retain, nonatomic) CCMenuItemSprite *start;
@property (retain, nonatomic) CCSprite *title;

@property (retain, nonatomic) CCLayer *friendsLayer;
@property (retain, nonatomic) CCLayer *itemLayer;

+(CCScene *) scene;
-(void)mainToItem;
@end
