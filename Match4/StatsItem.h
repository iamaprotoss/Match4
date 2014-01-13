//
//  StatsItem.h
//  Match4
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatsItem : NSObject
{
    int currentMoney;
    int currentLevel;
    int currentLife;
    int currentExperience;
}

@property int currentMoney;
@property int currentLevel;
@property int currentLife;
@property int currentExperience;

-(id)initWithDictionary:(NSDictionary*)statsDictionary;
-(NSDictionary *)getDataInDictionary;

@end
