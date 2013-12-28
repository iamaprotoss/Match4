//
//  GameItem.m
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "GameItem.h"

@implementation GameItem

@synthesize gameGrid, isPaused, isActive, timer, stats;

- (id)init
{
    if (self = [super init]) {
        gameGrid = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
            [gameGrid addObject:[NSMutableArray array]];
            isPaused = NO;
            isActive = NO;
            timer = 0.0f;
        }
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [self.gameGrid release];
}

- (id)initWithDictionary:(NSDictionary *)gameDictionary
{
    if (self = [super init])
    {
        if (gameDictionary)
        {
            NSDictionary *statsDictionary = [gameDictionary objectForKey:@"stats"];
            if (statsDictionary) {
                
            }
            
            NSArray *gameGridArray = [gameDictionary objectForKey:@"gameGrid"];
            if (gameGridArray && gameGridArray.count == 8) {
                for (int i = 0; i < 8; i++) {
                    NSArray *row = [gameGridArray objectAtIndex:i];
                    if (row.count == 8) {
                        for (int j = 0; j < 8; j++) {
                            
                        }
                    }
                }
            }
            
            isPaused = [[gameDictionary objectForKey:@"isPaused"] boolValue];
            isActive = [[gameDictionary objectForKey:@"isActive"] boolValue];
            timer = [[gameDictionary objectForKey:@"timer"] floatValue];
            }
    }
    return self;
}

- (NSDictionary*)getDataInDictionary {
    NSMutableDictionary *temp;
}

@end
