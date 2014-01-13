//
//  GameItem.m
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "GameItem.h"
#import "ElementItem.h"

@implementation GameItem

@synthesize gameGrid, isPaused, isActive, timer, score, scoreMultiplier;

- (id)init
{
    if (self = [super init]) {
        gameGrid = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
            [gameGrid addObject:[NSMutableArray array]];
        }
        //stats = [StatsManager new];
        isPaused = NO;
        isActive = NO;
        timer = 0.0f;
        score = 1;
        scoreMultiplier = 1;
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
            score = [[gameDictionary objectForKey:@"score"] intValue];
            scoreMultiplier = [[gameDictionary objectForKey:@"scoreMultiplier"] intValue];
        }
    }
    return self;
}

- (NSDictionary*)getDataInDictionary {
    NSMutableDictionary * tempReturnDictionary = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *gameGridArray = [NSMutableArray new];
    
    for (NSMutableArray *row in gameGrid) {
        
        NSMutableArray *elementItems = [NSMutableArray new];
        
        for(ElementItem *elementItem in row){
            [elementItems addObject:[elementItem getDataInDictionary]];
        }
        
        [gameGridArray addObject:elementItems];
        
    }
    
    [tempReturnDictionary setObject:gameGridArray forKey:@"gameGrid"];
    [tempReturnDictionary setObject:[NSNumber numberWithBool:self.isPaused] forKey:@"isPaused"];
    [tempReturnDictionary setObject:[NSNumber numberWithBool:self.isActive] forKey:@"isActive"];
    [tempReturnDictionary setObject:[NSNumber numberWithFloat:self.timer] forKey:@"timer"];
    [tempReturnDictionary setObject:[NSNumber numberWithInt:self.score] forKey:@"score"];
    [tempReturnDictionary setObject:[NSNumber numberWithInt:self.scoreMultiplier] forKey:@"scoreMultiplier"];
    
    return tempReturnDictionary;
}

@end
