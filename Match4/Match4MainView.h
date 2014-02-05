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
#import "StoreLayer.h"
#import "Match4Label.h"
#import "OptionMainLayer.h"
@class Match4TimeView;

@interface Match4MainView : CCLayer<Match4ItemLayerDelegate, StoreLayerDelegate>
{
    CCSprite *start_bg;
    CCSprite *start_gold_bg;
    CCSprite *start_gold_coin;
    CCSprite *start_gold_hi;
    CCSprite *start_lv;
    Match4Label *start_lv_label;
    CCSprite *start_lv_bg;
    CCSprite *start_lv_progress;
    CCMenuItemSprite *start_start_btn;
    CCMenuItemSprite *start_store_btn;
    CCSprite *start_start;
    //CCSprite *start_title;
    Match4Label *start_money;
    CCMenu *start_option_btn;
    CCSprite *start_option_gear;
    CCMenu *back;
    
    int level;
    int experience;
    
    BOOL canTouch;
    
    // state 1: highScore 2: item 3: store
    int oldState;
    int state;
    
    Match4FriendsLayer *friendsLayer;
    Match4ItemLayer *itemLayer;
    StoreLayer *storeLayer;
    OptionMainLayer *optionMainLayer;
}


@property (retain, nonatomic) CCLayer *friendsLayer;
@property (retain, nonatomic) CCLayer *itemLayer;
@property (retain, nonatomic) CCLayer *storeLayer;
@property (retain, nonatomic) CCLayer *optionMainLayer;
@property (nonatomic) BOOL canTouch;

+(CCScene *) scene:(BOOL)isItem;
-(id)initWithItem:(BOOL)isItem;
-(void)mainToItem;
-(void)goToStore;
@end
