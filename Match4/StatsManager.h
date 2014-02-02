//
//  StatsManager.h
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatsManager : NSObject<NSCopying> {
    NSUserDefaults *userDefaults;
    int currentMoney;
    int currentLevel;
    int currentExperience;
    int currentLife;
    int highScore;
    //int score;
    //int scoreMultiplier;
}

@property (nonatomic) int currentMoney;
@property (nonatomic) int currentLevel;
@property (nonatomic) int currentExperience;
@property (nonatomic) int currentLife;
@property (nonatomic) int highScore;
//@property int score;
//@property int scoreMultiplier;

- (id)initForTheFirstTime;
- (void)clearGameStats;
//- (BOOL)didSeePopUpForSpecialType:(int)thisType;
- (void)setStats;
- (void)getStats;
- (void)setHighScore;
- (int)getHighScore;

@end
