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
//@synthesize bg, resume, music, sound, pause_menu;

-(id)init
{
    if ([super init]) {
        paused_bg = [CCSprite spriteWithFile:@"paused_bg.png"];
        paused_bg.position = ccp(160, 50);
        [self addChild:paused_bg];
        
        paused_banner = [CCSprite spriteWithFile:@"paused_banner.png"];
        paused_banner.position = ccp(160, 95);
        [self addChild:paused_banner];
        
        paused_title = [CCSprite spriteWithFile:@"paused_paused.png"];
        paused_title.position = ccp(160, 100);
        [self addChild:paused_title];
        
        CCSprite *resumeNormal = [CCSprite spriteWithFile:@"paused_resume.png"];
        CCSprite *resumeSelected = [CCSprite spriteWithFile:@"paused_resume_l.png"];
        paused_resume = [CCMenuItemSprite itemWithNormalSprite:resumeNormal selectedSprite:resumeSelected target:self selector:@selector(buttonPressed:)];
        paused_resume.tag = 0;
        
        CCSprite *restartNormal = [CCSprite spriteWithFile:@"paused_restart.png"];
        CCSprite *restartSelected = [CCSprite spriteWithFile:@"paused_restart_l.png"];
        paused_restart = [CCMenuItemSprite itemWithNormalSprite:restartNormal selectedSprite:restartSelected target:self selector:@selector(buttonPressed:)];
        paused_restart.tag = 1;
        
        CCSprite *musicNormal = [CCSprite spriteWithFile:@"paused_music.png"];
        CCSprite *musicSelected = [CCSprite spriteWithFile:@"paused_music_l.png"];
        paused_music = [CCMenuItemSprite itemWithNormalSprite:musicNormal selectedSprite:musicSelected target:self selector:@selector(buttonPressed:)];
        paused_music.tag = 2;
        
        CCSprite *soundNormal = [CCSprite spriteWithFile:@"paused_sound.png"];
        CCSprite *soundSelected = [CCSprite spriteWithFile:@"paused_sound_l.png"];
        paused_sound = [CCMenuItemSprite itemWithNormalSprite:soundNormal selectedSprite:soundSelected target:self selector:@selector(buttonPressed:)];
        paused_sound.tag = 3;

        CCSprite *menuNormal = [CCSprite spriteWithFile:@"paused_menu.png"];
        CCSprite *menuSelected = [CCSprite spriteWithFile:@"paused_menu_l.png"];
        paused_menu = [CCMenuItemSprite itemWithNormalSprite:menuNormal selectedSprite:menuSelected target:self selector:@selector(buttonPressed:)];
        paused_menu.tag = 4;

        CCMenu *menu = [CCMenu menuWithItems:paused_resume, paused_restart, paused_music, paused_sound, paused_menu, nil];
        [menu alignItemsHorizontallyWithPadding:10];
        menu.position = ccp(160, 45);
        [self addChild:menu];
    }
    return self;
}

-(void)buttonPressed:(id)target
{
    if (((CCNode *)target).tag == 0) {
        [[GameController sharedController].timeView resume];
    } else if (((CCNode *)target).tag == 1) {
        [[GameController sharedController].timeView restart];
    } else if (((CCNode *)target).tag == 2) {
    } else if (((CCNode *)target).tag == 3) {
    } else if (((CCNode *)target).tag == 4) {
        [[GameController sharedController] showMainView:NO];
    }
}

@end
