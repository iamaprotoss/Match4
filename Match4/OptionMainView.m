//
//  OptionMainView.m
//  Match4
//
//  Created by apple on 13-12-31.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "OptionMainView.h"
#import "GameController.h"

@implementation OptionMainView

-(id) init
{
    if (self = [super init]) {
        start_setting_bg = [CCSprite spriteWithFile:@"start_setting_bg.png"];
        start_setting_bg.position = ccp(270, 50);
        [self addChild:start_setting_bg];
        
        CCMenuItemSprite *musicSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_setting_music.png"] selectedSprite:[CCSprite spriteWithFile:@"start_setting_music.png"] target:self selector:@selector(option:)];
        musicSprite.tag = 1;
        start_setting_music = [CCMenu menuWithItems:musicSprite, nil];
        start_setting_music.position = ccp(20, 60);
        start_setting_music.userData = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], @"is disabled", nil];
        [start_setting_bg addChild:start_setting_music];
        
        CCMenuItemSprite *soundSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_setting_sound.png"] selectedSprite:[CCSprite spriteWithFile:@"start_setting_sound.png"] target:self selector:@selector(option:)];
        musicSprite.tag = 2;
        start_setting_sound = [CCMenu menuWithItems:soundSprite, nil];
        start_setting_sound.position = ccp(20, 40);
        start_setting_sound.userData = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], @"is disabled", nil];
        [start_setting_bg addChild:start_setting_sound];
        
        CCMenuItemSprite *helpSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_setting_help.png"] selectedSprite:[CCSprite spriteWithFile:@"start_setting_help.png"] target:self selector:@selector(option:)];
        musicSprite.tag = 3;
        start_setting_help = [CCMenu menuWithItems:helpSprite, nil];
        start_setting_help.position = ccp(20, 20);
        start_setting_help.userData = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], @"is disabled", nil];
        [start_setting_bg addChild:start_setting_help];
    }
    
    return self;
    
}

-(void) option:(id)target
{
    NSMutableDictionary *uData = ((CCSprite *)target).userData;
    int tag = ((CCSprite *)target).tag;
    if (tag == 1) {
        if (![uData objectForKey:@"is disabled"]) {
            CCSprite *ban = [CCSprite spriteWithFile:@"start_setting_ban.png"];
            ban.position = start_setting_music.position;
            ban.tag = 10;
            [start_setting_bg addChild:ban];
        } else {
            [start_setting_bg removeChildByTag:10];
        }
    } else if (tag == 2) {
        if (![uData objectForKey:@"is disabled"]) {
            CCSprite *ban = [CCSprite spriteWithFile:@"start_setting_ban.png"];
            ban.position = start_setting_sound.position;
            ban.tag = 20;
            [start_setting_bg addChild:ban];
        } else {
            [start_setting_bg removeChildByTag:20];
        }
    } else if (tag == 3) {
        if (![uData objectForKey:@"is disabled"]) {
            CCSprite *ban = [CCSprite spriteWithFile:@"start_setting_ban.png"];
            ban.position = start_setting_help.position;
            ban.tag = 30;
            [start_setting_bg addChild:ban];
        } else {
            [start_setting_bg removeChildByTag:30];
        }
    }
}

@end
