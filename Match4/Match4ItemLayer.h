//
//  Match4ItemLayer.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
@class GameController;

@protocol Match4ItemLayerDelegate <NSObject>

-(void)closeItemLayer;

@end

@interface Match4ItemLayer : CCLayer
{
    CCSprite *item_banner;
    CCSprite *item_bg;
    CCSprite *item_item;
    
    CCSprite *item_description;
    
    //CCSprite *selectbg;
    //CCMenuItemSprite *buygold;
    CCMenuItemSprite *item_item1;
    CCMenuItemSprite *item_item2;
    CCMenuItemSprite *item_item3;
    CCMenuItemSprite *item_item4;
    CCMenuItemSprite *item_item5;
    
    CCMenuItemSprite *item_itembg[3];
    CCMenuItemSprite *item_price[5];
    
    CCMenuItemSprite *close;
    
    //CCSprite *price;
    
    int numOfItemSelected;
}

@property (retain, nonatomic) id<Match4ItemLayerDelegate> delegate;

/*
@property (retain, nonatomic) CCMenuItemSprite *buygold;
@property (retain, nonatomic) CCSprite *selectbg;
@property (retain, nonatomic) CCSprite *price;
*/

@end
