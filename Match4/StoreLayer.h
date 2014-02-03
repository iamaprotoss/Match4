//
//  StoreView.h
//  Match4
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
@class Match4Label;

@protocol StoreLayerDelegate <NSObject>

-(void)closeStoreLayer;

@end

@interface StoreLayer : CCLayer
{
    CCSprite *store_bg;
    CCSprite *store_banner;
    CCSprite *store_title;
    CCSprite *store_coinbg[5];
    CCMenu *store_buy[5];
    CCSprite *store_coin[5];
    Match4Label *store_coin_label[5];
    Match4Label *store_price_label[5];
    
    CCMenuItemSprite *back;
}

@property (nonatomic, retain) id<StoreLayerDelegate> delegate;

@end
