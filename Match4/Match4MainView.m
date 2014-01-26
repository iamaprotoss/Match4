//
//  Match4MainView.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4MainView.h"
#import "Match4TimeView.h"
#import "GameController.h"

@implementation Match4MainView
//@synthesize bg, friendsbg, moneybg, money, level, lives, option, points, start, title, facebooklogin;
@synthesize friendsLayer, itemLayer, storeLayer, optionMainLayer, canTouch;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    Match4MainView *layer = [Match4MainView node];
    
    [scene addChild:layer];
    
    return scene;
}

- (void)dealloc
{
    [super dealloc];
}

-(id) init
{
    if (self = [super init]) {
        [GameController sharedController].mainView = self;
        canTouch = YES;
        
        start_bg = [CCSprite spriteWithFile:@"start_bg.png"];
        start_bg.anchorPoint = ccp(0, 0);
        start_bg.position = ccp(0, -100);
        [self addChild:start_bg];
        /*
        friendsbg = [CCSprite spriteWithFile:@"start_friendsbg.png"];
        friendsbg.position = ccp(156, 190);
        [self addChild:friendsbg];
        */
        /*
        for (int i = 0; i < 5; i++) {
            CCSprite *life = [CCSprite spriteWithFile:@"start_live.png"];
            life.position = ccp(10+30*i, 450);
            [self addChild:life];
            [lives addObject:life];
        }*/
        
        /*facebooklogin = [CCSprite spriteWithFile:@"start_facebook_login.png"];
        facebooklogin.position = ccp(160, 200);
        [self addChild:facebooklogin];*/
        
        start_facebook_bg = [CCSprite spriteWithFile:@"start_facebook_bg.png"];
        start_facebook_bg.position = ccp(160, 300);
        [start_bg addChild:start_facebook_bg];
        
        start_facebook = [CCSprite spriteWithFile:@"start_facebook.png"];
        start_facebook.position = ccp(160, 300);
        [start_bg addChild:start_facebook];
        
        start_gold_bg = [CCSprite spriteWithFile:@"start_gold_bg.png"];
        start_gold_bg.position = ccp(250, 550);
        [start_bg addChild:start_gold_bg];
        
        CCSprite *storeNormal = [CCSprite spriteWithFile:@"start_store_btn.png"];
        CCSprite *storeSelected = [CCSprite spriteWithFile:@"start_store_btn_I.png"];
        start_store_btn = [CCMenuItemSprite itemWithNormalSprite:storeNormal selectedSprite:storeSelected target:self selector:@selector(mainToStore)];
        CCMenu *storeMenu = [CCMenu menuWithItems:start_store_btn, nil];
        storeMenu.position = ccp(285, 550);
        [start_bg addChild:storeMenu];
        
        start_gold_coin = [CCSprite spriteWithFile:@"start_gold_coin.png"];
        start_gold_coin.position = ccp(213, 550);
        [start_bg addChild:start_gold_coin];
        start_gold_hi = [CCSprite spriteWithFile:@"start_gold_hi.png"];
        start_gold_hi.position = ccp(20, 20);
        [start_gold_coin addChild:start_gold_hi];
        
        start_money = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", [GameController sharedController].moneyManager.coins] fontSize:12];
        start_money.position = ccp(250, 550);
        [start_bg addChild:start_money];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMoney:) name:@"updateMoney" object:nil];

        start_lv = [CCSprite spriteWithFile:@"start_lv.png"];
        start_lv.position = ccp(20, 550);
        [start_bg addChild:start_lv];
        
        start_lv_bg = [CCSprite spriteWithFile:@"start_lv_bg.png"];
        start_lv_bg.position = ccp(100, 550);
        [start_bg addChild:start_lv_bg];
        
        start_lv_progress = [CCSprite spriteWithFile:@"start_lv_progress.png"];
        start_lv_progress.position = ccp(100, 550);
        [start_bg addChild:start_lv_progress];
        
        CCSprite *startNormal = [CCSprite spriteWithFile:@"start_start_bg.png"];
        //startNormal.anchorPoint = ccp(0.5, 0.5);
        CCSprite *startSelected = [CCSprite spriteWithFile:@"start_start_bg_I.png"];
        //startSelected.anchorPoint = ccp(0.5, 0.5);
        start_start_btn = [CCMenuItemSprite itemWithNormalSprite:startNormal selectedSprite:startSelected target:self selector:@selector(mainToItem)];
        CCMenu *startMenu = [CCMenu menuWithItems:start_start_btn, nil];
        startMenu.position = ccp(160, 150);
        [start_bg addChild:startMenu];
        start_start = [CCSprite spriteWithFile:@"start_start.png"];
        start_start.position = ccp(160, 150);
        [start_bg addChild:start_start];
        
        start_title = [CCSprite spriteWithFile:@"start_title1.png"];
        start_title.position = ccp(160, 465);
        [start_bg addChild:start_title];
        
        CCMenuItemSprite *optionSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_option_button_base.png"] selectedSprite:[CCSprite spriteWithFile:@"start_option_button_base_I.png"] target:self selector:@selector(showStartOption)];
        start_option_btn = [CCMenu menuWithItems:optionSprite, nil];
        start_option_btn.position = ccp(280, 140);
        [start_bg addChild:start_option_btn z:50];
        start_option_gear = [CCSprite spriteWithFile:@"start_option_gear.png"];
        start_option_gear.position = ccp(280, 140);
        [start_bg addChild:start_option_gear z:51];
        
        friendsLayer = [Match4FriendsLayer node];
        friendsLayer.position = ccp(0, 120);
        [start_bg addChild:friendsLayer];
    }
    return self;
}

-(void) mainToItem
{
    if (canTouch) {
        if (friendsLayer!=nil) {
            [friendsLayer removeFromParent];
            friendsLayer = nil;
            itemLayer = [Match4ItemLayer node];
            itemLayer.position = ccp(0, 150);
            [start_bg addChild:itemLayer];
            itemLayer.delegate = self;
        } else {
            [[GameController sharedController] showGameView];
        }
    }
}

-(void) mainToStore
{
    if (storeLayer == nil) {
        storeLayer = [StoreLayer node];
        storeLayer.position = ccp(0, 120);
        [start_bg addChild:storeLayer];
        storeLayer.delegate = self;
        canTouch = NO;
    } else {
        [storeLayer removeFromParent];
        storeLayer = nil;
        canTouch = YES;
    }
}

-(void) showStartOption
{
    if (canTouch) {
        if (optionMainLayer == nil) {
            optionMainLayer = [OptionMainLayer node];
            optionMainLayer.position = ccp(10, 140);
            [start_bg addChild:optionMainLayer z:49];
        } else {
            [optionMainLayer removeFromParent];
            optionMainLayer = nil;
        }

    }
}

-(void) updateMoney:(NSNotification *)aNotificaiton
{
    int money = [[aNotificaiton object] intValue];
    start_money.string = [NSString stringWithFormat:@"%i", money];
}

#pragma mark StoreViewDelegate
-(void) closeStoreLayer
{
    if (storeLayer!=nil) {
        [storeLayer removeFromParent];
        storeLayer = nil;
        canTouch = YES;
    }
}

#pragma mark Match4ItemLayerDelegate
-(void) closeItemLayer
{
    if (itemLayer!=nil) {
        [itemLayer removeFromParent];
        itemLayer = nil;
        friendsLayer = [Match4FriendsLayer node];
        friendsLayer.position = ccp(0, 120);
        [start_bg addChild:friendsLayer];
    }
}

@end
