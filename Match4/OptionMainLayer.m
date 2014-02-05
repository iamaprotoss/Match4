//
//  OptionMainView.m
//  Match4
//
//  Created by apple on 13-12-31.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "OptionMainLayer.h"
#import "GameController.h"
#import "Match4TutorialView.h"

@implementation OptionMainLayer

-(id) init
{
    if (self = [super init]) {
        start_setting_bg = [CCSprite spriteWithFile:@"start_setting_bg_1.png"];
        start_setting_bg.position = ccp(270, 107);
        [self addChild:start_setting_bg];
        
        CCMenuItemSprite *musicSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_setting_music.png"] selectedSprite:[CCSprite spriteWithFile:@"start_setting_music.png"] target:self selector:@selector(option:)];
        musicSprite.tag = 1;
        start_setting_music = [CCMenu menuWithItems:musicSprite, nil];
        start_setting_music.position = ccp(25, 215);
        start_setting_music.userData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithBool:NO], @"is disabled", nil];
        [start_setting_bg addChild:start_setting_music];
        
        CCMenuItemSprite *soundSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_setting_sound.png"] selectedSprite:[CCSprite spriteWithFile:@"start_setting_sound.png"] target:self selector:@selector(option:)];
        soundSprite.tag = 2;
        start_setting_sound = [CCMenu menuWithItems:soundSprite, nil];
        start_setting_sound.position = ccp(25, 155);
        //start_setting_sound.userData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithBool:NO], @"is disabled", nil];
        [start_setting_bg addChild:start_setting_sound];
        if ([GameController sharedController].soundController.isSFXOff) {
            CCSprite *ban = [CCSprite spriteWithFile:@"start_setting_ban.png"];
            ban.position = start_setting_sound.position;
            ban.tag = 20;
            [start_setting_bg addChild:ban];
        }
        NSLog(@"%i",[GameController sharedController].soundController.isSFXOff);
        
        CCMenuItemSprite *helpSprite = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_setting_help.png"] selectedSprite:[CCSprite spriteWithFile:@"start_setting_help.png"] target:self selector:@selector(option:)];
        helpSprite.tag = 3;
        start_setting_help = [CCMenu menuWithItems:helpSprite, nil];
        start_setting_help.position = ccp(25, 95);
        start_setting_help.userData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithBool:NO], @"is disabled", nil];
        [start_setting_bg addChild:start_setting_help];
    }
    
    return self;
    
}

-(void) option:(id)target
{
    int tag = ((CCSprite *)target).tag;
    if (tag == 1) {
        NSMutableDictionary *uData = start_setting_music.userData;
        if (![[uData objectForKey:@"is disabled"] boolValue]) {
            [uData setObject:[NSNumber numberWithBool:YES] forKey:@"is disabled"];
            CCSprite *ban = [CCSprite spriteWithFile:@"start_setting_ban.png"];
            ban.position = start_setting_music.position;
            ban.tag = 10;
            [start_setting_bg addChild:ban];
        } else {
            [uData setObject:[NSNumber numberWithBool:NO] forKey:@"is disabled"];
            [start_setting_bg removeChildByTag:10];
        }
    } else if (tag == 2) {
        //NSMutableDictionary *uData = start_setting_sound.userData;
        if (![GameController sharedController].soundController.isSFXOff) {
            [[GameController sharedController].soundController turnSoundOff];
            //[uData setObject:[NSNumber numberWithBool:YES] forKey:@"is disabled"];
            CCSprite *ban = [CCSprite spriteWithFile:@"start_setting_ban.png"];
            ban.position = start_setting_sound.position;
            ban.tag = 20;
            [start_setting_bg addChild:ban];
        } else {
            //[uData setObject:[NSNumber numberWithBool:NO] forKey:@"is disabled"];
            [[GameController sharedController].soundController turnSoundOn];
            [start_setting_bg removeChildByTag:20];
        }
    } else if (tag == 3) {
        /*NSMutableDictionary *uData = start_setting_help.userData;
        if (![[uData objectForKey:@"is disabled"] boolValue]) {
            [uData setObject:[NSNumber numberWithBool:YES] forKey:@"is disabled"];
            CCSprite *ban = [CCSprite spriteWithFile:@"start_setting_ban.png"];
            ban.position = start_setting_help.position;
            ban.tag = 30;
            [start_setting_bg addChild:ban];
        } else {
            [uData setObject:[NSNumber numberWithBool:NO] forKey:@"is disabled"];
            [start_setting_bg removeChildByTag:30];
        }*/
        [self removeFromParent];
        [[GameController sharedController] showTutorialView];
    }
}

@end
