//
//  Match4PauseLayer.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "Match4PauseLayer.h"
#import "GameController.h"
#import "Match4TimeView.h"

@implementation Match4PauseLayer
@synthesize bg, resume, music, sound, pause_menu;

-(id)init
{
    if ([super init]) {
        bg = [CCSprite spriteWithFile:@"paused_bg.png"];
        bg.position = ccp(160, 50);
        [self addChild:bg];
        
        CCSprite *resumeNormal = [CCSprite spriteWithFile:@"paused_resume.png"];
        CCSprite *resumeSelected = [CCSprite spriteWithFile:@"paused_resume.png"];
        resume = [CCMenuItemSprite itemWithNormalSprite:resumeNormal selectedSprite:resumeSelected target:self selector:@selector(buttonPressed:)];
        resume.tag = 0;
        
        CCSprite *musicNormal = [CCSprite spriteWithFile:@"paused_music.png"];
        CCSprite *musicSelected = [CCSprite spriteWithFile:@"paused_music.png"];
        music = [CCMenuItemSprite itemWithNormalSprite:musicNormal selectedSprite:musicSelected target:self selector:@selector(buttonPressed:)];
        music.tag = 1;
        
        CCSprite *soundNormal = [CCSprite spriteWithFile:@"paused_sound.png"];
        CCSprite *soundSelected = [CCSprite spriteWithFile:@"paused_sound.png"];
        sound = [CCMenuItemSprite itemWithNormalSprite:soundNormal selectedSprite:soundSelected target:self selector:@selector(buttonPressed:)];
        sound.tag = 2;

        CCSprite *menuNormal = [CCSprite spriteWithFile:@"win_menu.png"];
        CCSprite *menuSelected = [CCSprite spriteWithFile:@"win_menu.png"];
        pause_menu = [CCMenuItemSprite itemWithNormalSprite:menuNormal selectedSprite:menuSelected target:self selector:@selector(buttonPressed:)];
        pause_menu.tag = 3;

        CCMenu *menu = [CCMenu menuWithItems:resume, music, sound, pause_menu, nil];
        [menu alignItemsHorizontallyWithPadding:20];
        menu.position = ccp(160, 40);
        [self addChild:menu];
    }
    return self;
}

-(void)buttonPressed:(id)target
{
    if (((CCNode *)target).tag == 0) {
        [[GameController sharedController].timeView resume];
    } else if (((CCNode *)target).tag == 1) {
        
    } else if (((CCNode *)target).tag == 2) {
        
    } else if (((CCNode *)target).tag == 3) {
        [[GameController sharedController] showMainView];
    }
}

@end
