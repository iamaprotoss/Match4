//
//  GameItem.h
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatsManager.h"

@interface GameItem : NSObject
{
    NSMutableArray *gameGrid;
    BOOL isPaused;
    BOOL isActive;
    float timer;
    int score;
    int scoreMultiplier;

    StatsManager *stats;
}

@property (nonatomic, retain) NSMutableArray *gameGrid;
@property (nonatomic, assign) BOOL isPaused;
@property (nonatomic, assign) BOOL isActive;
@property float timer;
@property int score;
@property int scoreMultiplier;
@property (nonatomic, retain) StatsManager *stats;

- (id)initWithDictionary:(NSDictionary*)gameDictionary;
- (NSDictionary *)getDataInDictionary;

@end
