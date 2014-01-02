//
//  GameOverView.m
//  Match4
//
//  Created by apple on 13-12-31.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "GameOverView.h"

@implementation GameOverView
@synthesize back, banner, bg, retry, score;

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    GameOverView *layer = [GameOverView node];
    
    [scene addChild:layer];
    
    return scene;
}


-(id) init
{
    if (self = [super init]) {
        bg = [CCSprite spriteWithFile:@"win_bg.png"];
        bg.position = ccp(160, 284);
        [self addChild:bg];
        
        banner = [CCSprite spriteWithFile:@"win_banner.png"];
        banner.position = ccp(160, 450);
        [self addChild:banner];
        
        CCSprite *bg2 = [CCSprite spriteWithFile:@"win_bg2.png"];
        bg2.position = ccp(160, 400);
        [self addChild:bg2];
        
        retry = [CCSprite spriteWithFile:@"win_retry.png"];
        retry.position = ccp(80, 200);
        [self addChild:retry];
        
        back = [CCSprite spriteWithFile:@"win_back.png"];
        back.position = ccp(200, 200);
        [self addChild:back];
        
        score = [CCSprite spriteWithFile:@"win_score.png"];
        score.position = ccp(160, 300);
        [self addChild:score];
    }
    return self;
}

@end
