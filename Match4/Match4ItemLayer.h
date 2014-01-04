//
//  Match4ItemLayer.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"

@interface Match4ItemLayer : CCLayer
{
    CCMenuItemSprite *start;
    CCSprite *selectbg;
    CCSprite *buygold;
    CCSprite *item;
    CCSprite *price;
}

@property (retain, nonatomic) CCMenuItemSprite *start;
@property (retain, nonatomic) CCSprite *selectbg;
@property (retain, nonatomic) CCSprite *buygold;
@property (retain, nonatomic) CCSprite *item;
@property (retain, nonatomic) CCSprite *price;

@end
