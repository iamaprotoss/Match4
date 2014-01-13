//
//  ElementItem.h
//  Match4
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match4Element.h"

@interface ElementItem : NSObject
{
    int isOfType;
    BOOL isVisible;
    BOOL isSelected;
    BOOL isExplosive;
    BOOL isOfSuperSingle;
    BOOL isOfSuperDouble;
    BOOL isOfSuperTriple;
    CGPoint isIndex;
    int dropSize;
}

@property (nonatomic) int isOfType;
@property (nonatomic) BOOL isVisible;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isExplosive;
@property (nonatomic) BOOL isOfSuperSingle;
@property (nonatomic) BOOL isOfSuperDouble;
@property (nonatomic) BOOL isOfSuperTriple;
@property (nonatomic) CGPoint isIndex;
@property (nonatomic) int dropSize;

-(id) initWithDictionary:(NSDictionary *)elementDictionary;
-(id)initWithElement:(Match4Element*)symbolObj;
-(NSDictionary*)getDataInDictionary;

@end
