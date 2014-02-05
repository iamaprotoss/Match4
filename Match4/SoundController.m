//
//  SoundController.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "SoundController.h"

@implementation SoundController

@synthesize isSFXOff;

-(id)init
{
    if (self = [super init]) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        NSBundle *bundle = [[NSBundle mainBundle] retain];
        
        isSFXOff = [userDefaults boolForKey:@"isSFXOff"];
        
        SFX = [[NSMutableDictionary alloc] init];
        
        NSString *path = [bundle pathForResource:@"SFX-GeneralMenuButton" ofType:@"caf"];
        NSData *soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"GeneralMenuButton"];
        
        path = [bundle pathForResource:@"SFX-WildcardMenu_Open" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"WildcardMenu_Open"];
        
        path = [bundle pathForResource:@"SFX-Match" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"Match"];
        
        path = [bundle pathForResource:@"SFX-4Match" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"explosionMatch"];
        
        path = [bundle pathForResource:@"SFX-5Match" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"colorMatch"];
        
        path = [bundle pathForResource:@"SFX-LMatch" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"LShapeMatch"];
        
        [bundle release];
    }
    return self;
}

- (void)playSound:(NSString *)thisSound
{
    if (!isSFXOff) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            AVAudioPlayer *sound = [[AVAudioPlayer alloc] initWithData:[SFX objectForKey:thisSound] error:nil];
            sound.delegate = self;
            [sound prepareToPlay];
            [sound play];
        });
    }
}

- (void)turnSoundOn {
    isSFXOff = NO;
    [userDefaults setBool:isSFXOff forKey:@"isSFXOff"];
}

- (void)turnSoundOff {
    isSFXOff = YES;
    [userDefaults setBool:isSFXOff forKey:@"isSFXOff"];
}

- (void)dealloc {
    [userDefaults release];
    [SFX removeAllObjects];
    [SFX release];
    [super dealloc];
}

#pragma AVAudioPlayerDelegate Methods
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [player release];
}

@end
