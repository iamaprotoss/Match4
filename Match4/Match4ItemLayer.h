//
//  Match4ItemLayer.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
@class GameController;

@interface Match4ItemLayer : CCLayer
{
    CCMenuItemSprite *start;
    CCSprite *selectbg;
    CCSprite *buygold;
    CCMenuItemSprite *item1;
    CCMenuItemSprite *item2;
    CCMenuItemSprite *item3;
    CCMenuItemSprite *item4;
    CCMenuItemSprite *item5;
    
    CCSprite *price;
    
    int numOfItemSelected;
    
    
}

@property (retain, nonatomic) CCMenuItemSprite *start;
@property (retain, nonatomic) CCSprite *selectbg;
@property (retain, nonatomic) CCSprite *buygold;
@property (retain, nonatomic) CCSprite *item;
@property (retain, nonatomic) CCSprite *price;

@end
