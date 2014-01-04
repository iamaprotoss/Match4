//
//  Match4Element.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4Element.h"

@implementation Match4Element

@synthesize isOfType, isVisible, isSelected, isExplosive, isToExplode, isLShapeCorner, isIndex, dropSize, isInGroup;
@synthesize isOfSuperSingle, isOfSuperDouble, isOfSuperTriple;
@synthesize ElementImage, ElementImageGlow, ElementAnimation, ElementCoin, ElementMultiplier, ElementSelectionBox;


-(id)duplicate
{
    Match4Element *element = [[[Match4Element alloc] init] autorelease];
    element.isOfType = self.isOfType;
    element.isVisible = self.isVisible;
    return element;
}


 
@end