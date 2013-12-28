//
//  ElementManager.h
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match4Element.h"

@interface ElementManager : NSObject
{
    CGRect normalFrame;
    CGRect engageFrame;
    CGRect explosionFrame;
    NSArray *explodingElementFrames;
    NSArray *crossShapeFrames;
}

@property (nonatomic, retain) Match4Element *thenewElement;

- (Match4Element *)randomElementWithMaxType:(int)maxTypes;
- (Match4Element *)ElementWithType:(int)thisType;
- (Match4Element *)ElementWithIsOfType:(int)isOfType;
- (void)selectElement:(Match4Element *)thisElement;
- (void)deselectElement:(Match4Element *)thisElement;
- (void)turnToSuperElement:(Match4Element *)thisElement;
- (void)animGlowElement:(Match4Element *)thisElement;
- (void)animExplodeElement:(Match4Element *)thisElement withDelay:(float)thisDelay;
- (void)animSuperElement:(Match4Element *)thisElement;
- (void)animSuperEliminateElement:(Match4Element *)thisElement;
- (void)animFlashElement:(Match4Element *)thisElement;
- (void)animCrossShapeOnElement:(Match4Element *)thisElement;
- (void)animHideElement:(Match4Element *)thisElement withDelay:(float)thisDelay;

- (void)shiftElement:(Match4Element *)thisElement toType:(int)thisType;

@end
