//
//  Match4ItemLayer.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
@class GameController;
@class Match4Label;

@protocol Match4ItemLayerDelegate <NSObject>

-(void)closeItemLayer;

@end

@interface Match4ItemLayer : CCLayer
{
    CCSprite *item_banner;
    CCSprite *item_bg;
    CCSprite *item_title;
    
    CCSprite *item_description;
    
    //CCSprite *selectbg;
    //CCMenuItemSprite *buygold;
    CCMenu *item_item[5];
        
    CCSprite *item_itembg[3];
    Match4Label *item_price_label[5];
    
    CCMenuItemSprite *close;
    
    //CCSprite *price;
    
    int numOfItemSelected;
    BOOL selectionSlot[3];
}

@property (retain, nonatomic) id<Match4ItemLayerDelegate> delegate;

/*
@property (retain, nonatomic) CCMenuItemSprite *buygold;
@property (retain, nonatomic) CCSprite *selectbg;
@property (retain, nonatomic) CCSprite *price;
*/

@end
