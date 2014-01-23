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
#import "StoreView.h"
#import "Match4Label.h"
#import "OptionMainView.h"
@class Match4TimeView;

@interface Match4MainView : CCLayer<Match4ItemLayerDelegate, StoreViewDelegate>
{
    CCSprite *start_bg;
    CCSprite *start_facebook;
    CCSprite *start_facebook_bg;
    CCSprite *start_gold_bg;
    CCSprite *start_gold_coin;
    CCSprite *start_gold_hi;
    CCSprite *start_lv;
    CCSprite *start_lv_bg;
    CCSprite *start_lv_progress;
    CCMenuItemSprite *start_start_btn;
    CCMenuItemSprite *start_store_btn;
    CCSprite *start_start;
    CCSprite *start_title;
    Match4Label *start_money;
    CCMenu *start_option_btn;
    CCSprite *start_option_gear;
    
    /*
    CCSprite *friendsbg;
    CCSprite *moneybg;
    Match4Label *money;
    Match4Label *level;
    CCSprite *facebookbg;
    CCSprite *facebook;
    NSMutableArray *lives;
    CCMenuItemSprite *option;
    CCSprite *points;
    CCMenuItemSprite *start;
    CCSprite *title;
     */
    Match4FriendsLayer *friendsLayer;
    Match4ItemLayer *itemLayer;
    StoreView *storeView;
    OptionMainView *optionMainView;
}

/*
@property (retain, nonatomic) CCSprite *bg;
@property (retain, nonatomic) CCSprite *friendsbg;
@property (retain, nonatomic) CCSprite *moneybg;
@property (retain, nonatomic) Match4Label *money;
@property (retain, nonatomic) Match4Label *level;
@property (retain, nonatomic) CCSprite *facebooklogin;
@property (retain, nonatomic) NSMutableArray *lives;
@property (retain, nonatomic) CCMenuItemSprite *option;
@property (retain, nonatomic) CCSprite *points;
@property (retain, nonatomic) CCMenuItemSprite *start;
@property (retain, nonatomic) CCSprite *title;
*/

@property (retain, nonatomic) CCLayer *friendsLayer;
@property (retain, nonatomic) CCLayer *itemLayer;
@property (retain, nonatomic) CCLayer *storeView;
@property (retain, nonatomic) CCLayer *optionMainView;

+(CCScene *) scene;
-(void)mainToItem;
-(void)mainToStore;
@end
