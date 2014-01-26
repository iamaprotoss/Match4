//
//  StatsManager.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

//
//  StatsManager.m
//  Syntax
//
//  Created by Bright Newt on 1/2/12.
//  Copyright (c) 2012 Bright Newt. All rights reserved.
//

#import "StatsManager.h"

@implementation StatsManager

@synthesize currentMoney;
@synthesize currentLevel;
@synthesize currentExperience;
@synthesize currentLife;
//@synthesize score;
//@synthesize scoreMultiplier;

- (id)init {
	if (self = [super init]) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        [self getStats];
    }
	return self;
}

- (id)initForTheFirstTime
{
    if (self = [super init]) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        currentMoney = 1000;
        currentLife = 5;
        currentExperience = 0;
        currentLevel = 1;
        [self setStats];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    
    StatsManager *stats = [[[self class] allocWithZone:zone] init];
    stats.currentLevel = self.currentLevel;
    stats.currentMoney = self.currentMoney;
    stats.currentLife = self.currentLife;
    stats.currentExperience = self.currentExperience;
    //stats.score = self.score;
    //stats.scoreMultiplier = self.scoreMultiplier;
    
    return stats;
}

- (void)clearGameStats{
    currentMoney = 0;
    currentLife = 5;
    currentLife = 1;
    currentExperience = 0;
}

- (void)setStats {
    [userDefaults setInteger:currentLife forKey:@"life"];
    [userDefaults setInteger:currentLevel forKey:@"level"];
    [userDefaults setInteger:currentMoney forKey:@"money"];
    [userDefaults setInteger:currentExperience forKey:@"experience"];
    //[userDefaults setInteger:score forKey:score];
    //[userDefaults setInteger:scoreMultiplier forKey:scoreMultiplier];
}

- (void)getStats {
    currentLife = [userDefaults integerForKey:@"life"];
    currentLevel = [userDefaults integerForKey:@"level"];
    currentMoney = [userDefaults integerForKey:@"money"];
    currentExperience = [userDefaults integerForKey:@"experience"];
    //score = [userDefaults integerForKey:@"score"];
    //scoreMultiplier = [userDefaults integerForKey:@"scoreMultiplier"];
}

- (void)dealloc {
    [userDefaults release];
    [super dealloc];
}

@end
