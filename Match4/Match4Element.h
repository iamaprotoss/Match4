//
//  Match4Element.h
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

@interface Match4Element : CCNodeRGBA<NSCopying>
{
    int isOfType;
    BOOL isVisible;
    BOOL isSelected;
    BOOL isExplosive;
    BOOL isToExplode;
    BOOL isToColorEliminate;
    BOOL isLShapeCorner;
    //BOOL isSuperEliminated;
    CGPoint isIndex;
    int dropSize;
    
    int isInGroup;
    
    BOOL isOfSuperSingle;
    BOOL isOfSuperDouble;
    BOOL isOfSuperTriple;
    
    int pointsToAdd;
    float animDelay;
    
    CCSprite *ElementImage;
    CCSprite *ElementImageGlow;
    CCSprite *ElementHint;
    CCSprite *ElementAnimation;
    CCSprite *ElementCoin;
    CCSprite *ElementMultiplier;
    CCSprite *ElementSelectionBox;
}

@property (nonatomic) int isOfType;
@property (nonatomic) BOOL isVisible;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isExplosive;
@property (nonatomic) BOOL isToExplode;
@property (nonatomic) BOOL isToColorEliminate;
@property (nonatomic) BOOL isLShapeCorner;
@property (nonatomic) CGPoint isIndex;
@property (nonatomic) int dropSize;
@property (nonatomic) int isInGroup;
@property (nonatomic) BOOL isOfSuperSingle;
@property (nonatomic) BOOL isOfSuperDouble;
@property (nonatomic) BOOL isOfSuperTriple;
@property (nonatomic) int pointsToAdd;
@property (nonatomic) float animDelay;
@property (nonatomic, retain) CCSprite *ElementImage;
@property (nonatomic, retain) CCSprite *ElementImageGlow;
@property (nonatomic, retain) CCSprite *ElementHint;
@property (nonatomic, retain) CCSprite *ElementAnimation;
@property (nonatomic, retain) CCSprite *ElementCoin;
@property (nonatomic, retain) CCSprite *ElementMultiplier;
@property (nonatomic, retain) CCSprite *ElementSelectionBox;

-(id) duplicate;

@end
