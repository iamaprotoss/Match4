//
//  LocalStorageManager.h
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameItem.h"
#import "statsItem.h"

@interface LocalStorageManager : NSObject
{
    GameItem *currentGame;
    StatsItem *stats;
}

@property (nonatomic, retain) GameItem *currentGame;
@property (nonatomic, retain) StatsItem *stats;

- (void)load;
- (void)synchronize;

@end
