//
//  Match4ItemView.h
//  Match4
//
//  Created by apple on 13-12-27.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "CCLayer.h"

@interface Match4ItemView : CCLayer
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

+(CCScene *) scene;
-(void) mainToTime;

@end
