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
        highScore[0] = 5;
        highScore[1] = 4;
        highScore[2] = 3;
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
    [stats setHighScore:[self getHighScore:0] atRank:0];
    [stats setHighScore:[self getHighScore:1] atRank:1];
    [stats setHighScore:[self getHighScore:2] atRank:2];
    
    //stats.score = self.score;
    //stats.scoreMultiplier = self.scoreMultiplier;
    
    return stats;
}

- (void)clearGameStats{
    currentMoney = 0;
    currentLife = 5;
    currentLife = 1;
    currentExperience = 0;
    [self setHighScore:0 atRank:0];
    [self setHighScore:0 atRank:1];
    [self setHighScore:0 atRank:2];
}

- (void)setStats {
    [userDefaults setInteger:currentLife forKey:@"life"];
    [userDefaults setInteger:currentLevel forKey:@"level"];
    [userDefaults setInteger:currentMoney forKey:@"money"];
    [userDefaults setInteger:currentExperience forKey:@"experience"];
    [userDefaults setInteger:highScore[0] forKey:@"high score 1st"];
    [userDefaults setInteger:highScore[1] forKey:@"high score 2nd"];
    [userDefaults setInteger:highScore[2] forKey:@"high score 3rd"];
    //[userDefaults setInteger:score forKey:score];
    //[userDefaults setInteger:scoreMultiplier forKey:scoreMultiplier];
}

- (void)getStats {
    currentLife = [userDefaults integerForKey:@"life"];
    currentLevel = [userDefaults integerForKey:@"level"];
    currentMoney = [userDefaults integerForKey:@"money"];
    currentExperience = [userDefaults integerForKey:@"experience"];
    highScore[0] = [userDefaults integerForKey:@"high score 1st"];
    highScore[1] = [userDefaults integerForKey:@"high score 2nd"];
    highScore[2] = [userDefaults integerForKey:@"high score 3rd"];
    //score = [userDefaults integerForKey:@"score"];
    //scoreMultiplier = [userDefaults integerForKey:@"scoreMultiplier"];
}

- (int)getHighScore:(int)rank
{
    if (rank >= 3 || rank < 0) {
        return -1;
    } else {
        return highScore[rank];
    }
}

- (void)setHighScore:(int)score atRank:(int)rank
{
    if (rank<3 || rank >= 0) {
        highScore[rank] = score;
    }
}

-(BOOL)insertHighScore:(int)score
{
    BOOL success = NO;
    if (score > highScore[2]) {
        highScore[2] = score;
        success = YES;
    }
    if (score > highScore[1]) {
        highScore[2] = highScore[1];
        highScore[1] = score;
    }
    if (score > highScore[0]) {
        highScore[1] = highScore[0];
        highScore[0] = score;
    }
    return success;
}


- (void)dealloc {
    [userDefaults release];
    [NSMutableArray release];
    [super dealloc];
}

@end
