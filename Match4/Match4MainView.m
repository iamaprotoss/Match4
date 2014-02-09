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

+(CCScene*) scene:(BOOL)isItem
{
    CCScene *scene = [CCScene node];
    
    Match4MainView *layer = [[Match4MainView alloc] initWithItem:isItem];
    
    [scene addChild:layer];
    
    return scene;
}

- (void)dealloc
{
    [super dealloc];
}

-(id) initWithItem:(BOOL)isItem
{
    if (self = [super init]) {
        [GameController sharedController].mainView = self;
        canTouch = YES;
        
        if (IS_IPHONE_5) {
            start_bg = [CCSprite spriteWithFile:@"start_bg.png"];
            start_bg.anchorPoint = ccp(0, 0);
            start_bg.position = ccp(0, 0);
            [self addChild:start_bg];
            
            start_gold_bg = [CCSprite spriteWithFile:@"start_gold_bg.png"];
            start_gold_bg.position = ccp(250, 520);
            [start_bg addChild:start_gold_bg];
            
            CCSprite *storeNormal = [CCSprite spriteWithFile:@"store_btn.png"];
            CCSprite *storeSelected = [CCSprite spriteWithFile:@"store_btn.png"];
            start_store_btn = [CCMenuItemSprite itemWithNormalSprite:storeNormal selectedSprite:storeSelected target:self selector:@selector(goToStore)];
            CCMenu *storeMenu = [CCMenu menuWithItems:start_store_btn, nil];
            storeMenu.position = ccp(290, 520);
            [start_bg addChild:storeMenu];
            
            start_gold_coin = [CCSprite spriteWithFile:@"start_gold_coin.png"];
            start_gold_coin.position = ccp(203, 520);
            [start_bg addChild:start_gold_coin];
            start_gold_hi = [CCSprite spriteWithFile:@"start_gold_hi.png"];
            start_gold_hi.position = ccp(30, 30);
            [start_gold_coin addChild:start_gold_hi];
            
            start_money = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", [GameController sharedController].statsManager.currentMoney] fontSize:12];
            start_money.position = ccp(250, 520);
            [start_bg addChild:start_money];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMoney:) name:@"updateMoney" object:nil];
            
            level = [GameController sharedController].statsManager.currentLevel;
            experience = [GameController sharedController].statsManager.currentExperience;
            start_lv = [CCSprite spriteWithFile:@"start_lv.png"];
            start_lv.position = ccp(20, 520);
            [start_bg addChild:start_lv];
            
            start_lv_label = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", level] fontSize:20];
            start_lv_label.position = ccp(40, 520);
            start_lv_label.color = ccc3(20, 120, 150);
            [start_bg addChild:start_lv_label];
            
            start_lv_bg = [CCSprite spriteWithFile:@"start_lv_bg.png"];
            start_lv_bg.position = ccp(100, 520);
            [start_bg addChild:start_lv_bg];
            
            start_lv_progress = [CCSprite spriteWithFile:@"start_lv_progress.png"];
            start_lv_progress.anchorPoint = ccp(0, 0);
            start_lv_progress.position = ccp(61, 513);
            start_lv_progress.scaleX = 1.0 * experience / (pow(level, 2)*10000);
            [start_bg addChild:start_lv_progress];
            
            CCSprite *startNormal = [CCSprite spriteWithFile:@"start_start_bg.png"];
            CCSprite *startSelected = [CCSprite spriteWithFile:@"start_start_bg_l.png"];
            start_start_btn = [CCMenuItemSprite itemWithNormalSprite:startNormal selectedSprite:startSelected target:self selector:@selector(mainToItem)];
            CCMenu *startMenu = [CCMenu menuWithItems:start_start_btn, nil];
            startMenu.position = ccp(160, 50);
            [start_bg addChild:startMenu];
            start_start = [CCSprite spriteWithFile:@"start_start.png"];
            start_start.position = ccp(160, 50);
            [start_bg addChild:start_start];
            
            CCMenuItemSprite *optionSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_option_button_base.png"] selectedSprite:[CCSprite spriteWithFile:@"start_option_button_base_l.png"] target:self selector:@selector(showStartOption)];
            start_option_btn = [CCMenu menuWithItems:optionSprite, nil];
            start_option_btn.position = ccp(280, 45);
            [start_bg addChild:start_option_btn z:50];
            start_option_gear = [CCSprite spriteWithFile:@"start_option_gear.png"];
            start_option_gear.position = ccp(281, 46);
            [start_bg addChild:start_option_gear z:51];
            
            friendsLayer = [Match4FriendsLayer node];
            friendsLayer.position = ccp(0, 30);
            [start_bg addChild:friendsLayer];
            
            itemLayer = [Match4ItemLayer node];
            itemLayer.position = ccp(0, 100);
            [start_bg addChild:itemLayer];
            itemLayer.delegate = self;
            
            storeLayer = [StoreLayer node];
            storeLayer.position = ccp(0, 90);
            [start_bg addChild:storeLayer];
            storeLayer.delegate = self;
            
            CCMenuItemSprite *backM = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"store_back_button.png"] selectedSprite:[CCSprite spriteWithFile:@"store_back_button_l.png"] target:self selector:@selector(back)];
            back = [CCMenu menuWithItems:backM, nil];
            back.position = ccp(50, 50);
            [start_bg addChild:back];
            
        } else {
            start_bg = [CCSprite spriteWithFile:@"start_bg.png"];
            start_bg.anchorPoint = ccp(0, 0);
            start_bg.position = ccp(0, 0);
            [self addChild:start_bg];
            
            start_gold_bg = [CCSprite spriteWithFile:@"start_gold_bg.png"];
            start_gold_bg.position = ccp(250, 450);
            [start_bg addChild:start_gold_bg];
            
            CCSprite *storeNormal = [CCSprite spriteWithFile:@"store_btn.png"];
            CCSprite *storeSelected = [CCSprite spriteWithFile:@"store_btn.png"];
            start_store_btn = [CCMenuItemSprite itemWithNormalSprite:storeNormal selectedSprite:storeSelected target:self selector:@selector(goToStore)];
            CCMenu *storeMenu = [CCMenu menuWithItems:start_store_btn, nil];
            storeMenu.position = ccp(290, 450);
            [start_bg addChild:storeMenu];
            
            start_gold_coin = [CCSprite spriteWithFile:@"start_gold_coin.png"];
            start_gold_coin.position = ccp(203, 450);
            [start_bg addChild:start_gold_coin];
            start_gold_hi = [CCSprite spriteWithFile:@"start_gold_hi.png"];
            start_gold_hi.position = ccp(30, 30);
            [start_gold_coin addChild:start_gold_hi];
            
            start_money = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", [GameController sharedController].statsManager.currentMoney] fontSize:12];
            start_money.position = ccp(250, 450);
            [start_bg addChild:start_money];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMoney:) name:@"updateMoney" object:nil];
            
            level = [GameController sharedController].statsManager.currentLevel;
            experience = [GameController sharedController].statsManager.currentExperience;
            start_lv = [CCSprite spriteWithFile:@"start_lv.png"];
            start_lv.position = ccp(20, 450);
            [start_bg addChild:start_lv];
            
            start_lv_label = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", level] fontSize:20];
            start_lv_label.position = ccp(40, 450);
            start_lv_label.color = ccc3(20, 120, 150);
            [start_bg addChild:start_lv_label];
            
            start_lv_bg = [CCSprite spriteWithFile:@"start_lv_bg.png"];
            start_lv_bg.position = ccp(100, 450);
            [start_bg addChild:start_lv_bg];
            
            start_lv_progress = [CCSprite spriteWithFile:@"start_lv_progress.png"];
            start_lv_progress.anchorPoint = ccp(0, 0);
            start_lv_progress.position = ccp(61, 443);
            start_lv_progress.scaleX = 1.0 * experience / (pow(level, 2)*10000);
            [start_bg addChild:start_lv_progress];
            
            CCSprite *startNormal = [CCSprite spriteWithFile:@"start_start_bg.png"];
            //startNormal.anchorPoint = ccp(0.5, 0.5);
            CCSprite *startSelected = [CCSprite spriteWithFile:@"start_start_bg_l.png"];
            //startSelected.anchorPoint = ccp(0.5, 0.5);
            start_start_btn = [CCMenuItemSprite itemWithNormalSprite:startNormal selectedSprite:startSelected target:self selector:@selector(mainToItem)];
            CCMenu *startMenu = [CCMenu menuWithItems:start_start_btn, nil];
            startMenu.position = ccp(160, 50);
            [start_bg addChild:startMenu];
            start_start = [CCSprite spriteWithFile:@"start_start.png"];
            start_start.position = ccp(160, 50);
            [start_bg addChild:start_start];
            
            CCMenuItemSprite *optionSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_option_button_base.png"] selectedSprite:[CCSprite spriteWithFile:@"start_option_button_base_l.png"] target:self selector:@selector(showStartOption)];
            start_option_btn = [CCMenu menuWithItems:optionSprite, nil];
            start_option_btn.position = ccp(280, 45);
            [start_bg addChild:start_option_btn z:50];
            start_option_gear = [CCSprite spriteWithFile:@"start_option_gear.png"];
            start_option_gear.position = ccp(281, 46);
            [start_bg addChild:start_option_gear z:51];
            
            friendsLayer = [Match4FriendsLayer node];
            friendsLayer.position = ccp(0, 0);
            [start_bg addChild:friendsLayer];
            
            itemLayer = [Match4ItemLayer node];
            itemLayer.position = ccp(0, 70);
            [start_bg addChild:itemLayer];
            itemLayer.delegate = self;
            
            storeLayer = [StoreLayer node];
            storeLayer.position = ccp(0, 60);
            [start_bg addChild:storeLayer];
            storeLayer.delegate = self;
            
            CCMenuItemSprite *backM = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"store_back_button.png"] selectedSprite:[CCSprite spriteWithFile:@"store_back_button_l.png"] target:self selector:@selector(back)];
            back = [CCMenu menuWithItems:backM, nil];
            back.position = ccp(50, 50);
            [start_bg addChild:back];
            
        }
        
        if (!isItem) {
            oldState = 1;
            state = 1;
            friendsLayer.visible = YES;
            storeLayer.visible = NO;
            itemLayer.visible = NO;
            back.visible = NO;
        } else {
            oldState = 2;
            state = 2;
            friendsLayer.visible = NO;
            storeLayer.visible = NO;
            itemLayer.visible = YES;
            back.visible = YES;
        }

    }
    return self;
}

-(void) mainToItem
{
    [[GameController sharedController].soundController playSound:@"WildcardMenu_Open"];
    if (optionMainLayer!=nil) {
        [optionMainLayer removeFromParent];
        optionMainLayer = nil;
    }
    if (state == 1) {
        friendsLayer.visible = NO;
        itemLayer.visible = YES;
        back.visible = YES;
        state = 2;
    } else if (state == 2) {
        [[GameController sharedController] showGameView];
    }
}

-(void) goToStore
{
    [[GameController sharedController].soundController playSound:@"WildcardMenu_Open"];
    if (optionMainLayer!=nil) {
        [optionMainLayer removeFromParent];
        optionMainLayer = nil;
    }
    if (state!=3) {
        if (state == 1) {
            friendsLayer.visible = NO;
        } else if (state == 2) {
            itemLayer.visible = NO;
        }
        start_start_btn.visible = NO;
        start_start.visible = NO;
        storeLayer.visible = YES;
        start_option_btn.visible = NO;
        start_option_gear.visible = NO;
        back.visible = YES;
        oldState = state;
        state = 3;
    } else {//state == 3)
        storeLayer.visible = NO;
        start_start_btn.visible = YES;
        start_start.visible = YES;
        start_option_btn.visible = YES;
        start_option_gear.visible = YES;
        if (oldState == 1) {
            friendsLayer.visible = YES;
            back.visible = NO;
            state = 1;
        } else if (oldState == 2) {
            itemLayer.visible = YES;
            state = 2;
        }
    }
}

-(void)back
{
    [[GameController sharedController].soundController playSound:@"WildcardMenu_Open"];
    if (state == 2) {
        [self closeItemLayer];
    } else if (state == 3) {
        [self closeStoreLayer];
    }
}

-(void) showStartOption
{
    [[GameController sharedController].soundController playSound:@"GeneralMenuButton"];
    //if (canTouch) {
        if (optionMainLayer == nil) {
            optionMainLayer = [OptionMainLayer node];
            optionMainLayer.position = ccp(10, 45);
            [start_bg addChild:optionMainLayer z:49];
        } else {
            [optionMainLayer removeFromParent];
            optionMainLayer = nil;
        }

    //}
}

-(void) updateMoney:(NSNotification *)aNotificaiton
{
    int money = [GameController sharedController].statsManager.currentMoney;
    start_money.string = [NSString stringWithFormat:@"%i", money];
}

#pragma mark StoreViewDelegate
-(void) closeStoreLayer
{
    if (optionMainLayer!=nil) {
        [optionMainLayer removeFromParent];
        optionMainLayer = nil;
    }
    storeLayer.visible = NO;
    start_start_btn.visible = YES;
    start_start.visible = YES;
    start_option_btn.visible = YES;
    start_option_gear.visible = YES;
    if (oldState == 1) {
        friendsLayer.visible = YES;
        back.visible = NO;
        state = 1;
    } else if (oldState == 2) {
        itemLayer.visible = YES;
        state = 2;
    }
}


#pragma mark Match4ItemLayerDelegate
-(void) closeItemLayer
{
    if (optionMainLayer!=nil) {
        [optionMainLayer removeFromParent];
        optionMainLayer = nil;
    }
    itemLayer.visible = NO;
    friendsLayer.visible = YES;
    back.visible = NO;
    state = 1;
}

@end
