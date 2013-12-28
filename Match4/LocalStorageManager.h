//
//  LocalStorageManager.h
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameItem.h"

@interface LocalStorageManager : NSObject
{
    GameItem *currentGame;
}

@property (nonatomic, retain) GameItem *currentGame;

- (void)load;
- (void)synchronize;

@end
