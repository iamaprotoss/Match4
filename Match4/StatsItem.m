//
//  StatsItem.m
//  Match4
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "StatsItem.h"

@implementation StatsItem
@synthesize currentLevel, currentLife, currentMoney, currentExperience;

-(id) init
{
    if (self = [super init]) {
        currentLevel = 1;
        currentLife = 5;
        currentMoney = 0;
        currentExperience = 0;
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)statsDictionary
{
    if (self = [super init]) {
        if (statsDictionary) {
            currentLevel = [[statsDictionary objectForKey:@"currentLevel"] intValue];
            currentLife = [[statsDictionary objectForKey:@"currentScore"] intValue];
            currentMoney = [[statsDictionary objectForKey:@"currentLife"] intValue];
            currentExperience = [[statsDictionary objectForKey:@"currentExperience"] intValue];
        }
    }
    return self;
}

-(NSDictionary *) getDataInDictionary
{
    NSMutableDictionary *tempReturnDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                 [NSNumber numberWithInt:currentLevel], @"currentLevel",
                                                 [NSNumber numberWithInt:currentLife], @"currentLife",
                                                 [NSNumber numberWithInt:currentMoney], @"currentMoney",
                                                 [NSNumber numberWithInt:currentExperience], @"currentExperience",
                                                 nil];
    return tempReturnDictionary;
}

@end
