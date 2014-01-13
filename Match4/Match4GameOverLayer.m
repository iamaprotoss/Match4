//
//  Match4GameOverLayer.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4GameOverLayer.h"
#import "GameController.h"
#import "Match4TimeView.h"

@implementation Match4GameOverLayer
@synthesize gameover_menu, moneyTag, bg, retry, scoreTag, facebookshare;


-(id) initWithScore:(int)thisScore money:(int)thisMoney;
{
    if (self = [super init]) {
        bg = [CCSprite spriteWithFile:@"win_bg.png"];
        bg.position = ccp(160, 190);
        [self addChild:bg];
        
        facebookshare = [CCSprite spriteWithFile:@"win_facebook.png"];
        facebookshare.position = ccp(160, 140);
        [self addChild:facebookshare];
        
        CCSprite *retryNormal = [CCSprite spriteWithFile:@"win_replay.png"];
        CCSprite *retrySelected = [CCSprite spriteWithFile:@"win_replay.png"];
        retry = [CCMenuItemSprite itemWithNormalSprite:retryNormal selectedSprite:retrySelected target:self selector:@selector(buttonPressed:)];
        retry.tag = 0;
        
        CCSprite *menuNormal = [CCSprite spriteWithFile:@"win_menu.png"];
        CCSprite *menuSelected = [CCSprite spriteWithFile:@"win_menu.png"];
        gameover_menu = [CCMenuItemSprite itemWithNormalSprite:menuNormal selectedSprite:menuSelected target:self selector:@selector(buttonPressed:)];
        gameover_menu.position = ccp(175, 100);
        gameover_menu.tag = 1;
        
        CCMenu *menu = [CCMenu menuWithItems:retry, gameover_menu, nil];
        [menu alignItemsHorizontallyWithPadding:40];
        menu.position = ccp(160, 100);
        [self addChild:menu];
        
        moneyTag = [CCSprite spriteWithFile:@"win_gold.png"];
        moneyTag.position = ccp(120, 175);
        [self addChild:moneyTag];
        
        money = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", thisMoney] fontSize:20];
        money.position = ccp(150, 175);
        money.color = ccc3(0, 0, 0);
        money.opacity = 200;
        [self addChild:money];
        
        scoreTag = [CCSprite spriteWithFile:@"win_score--.png"];
        scoreTag.position = ccp(140, 240);
        [self addChild:scoreTag];
        
        score = [Match4Label labelWithString:[NSString stringWithFormat:@"%i", thisScore] fontSize:20];
        [self addChild:score];
        score.position = ccp(140, 220);
        score.color = ccc3(0, 0, 0);
        score.opacity = 200;
    }
    return self;
}

-(void) buttonPressed:(id)target;
{
    if (((CCNode *)target).tag == 0) {
        [[GameController sharedController].timeView restart];
    } else if (((CCNode *)target).tag == 1) {
        [[GameController sharedController] showMainView];
    }
}

@end
