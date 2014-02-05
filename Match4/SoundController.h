//
//  SoundController.h
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundController : NSObject <AVAudioPlayerDelegate> {
    NSUserDefaults *userDefaults;
    BOOL isSFXOff;
    NSMutableDictionary *SFX;
}

@property (nonatomic) BOOL isSFXOff;

- (void)playSound:(NSString *)thisSound;
- (void)turnSoundOn;
- (void)turnSoundOff;

@end
