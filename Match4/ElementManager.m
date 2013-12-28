//
//  ElementManager.m
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "ElementManager.h"

@implementation ElementManager

- (id) init
{
    if (self = [super init]) {
        normalFrame = CGRectMake(0, 0, 40, 40);
        engageFrame = CGRectMake(0, 0, 37, 37);
        explosionFrame = CGRectMake(-20, -20, 80, 80);
        
        explodingElementFrames = [[NSArray alloc] initWithObjects:
                                  [CCSprite spriteWithFile:@"explodingSymbol00.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol01.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol02.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol03.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol04.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol05.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol06.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol07.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol08.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol09.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol10.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol11.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol13.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol14.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol15.png"],
                                  [CCSprite spriteWithFile:@"explodingSymbol16.png"], nil];
        
        crossShapeFrames = [[NSArray alloc] initWithObjects:
                            [CCSprite spriteWithFile:@"beam00.png"],
                            [CCSprite spriteWithFile:@"beam01.png"],
                            [CCSprite spriteWithFile:@"beam02.png"],
                            [CCSprite spriteWithFile:@"beam03.png"],
                            [CCSprite spriteWithFile:@"beam04.png"],
                            [CCSprite spriteWithFile:@"beam05.png"],
                            [CCSprite spriteWithFile:@"beam06.png"],
                            [CCSprite spriteWithFile:@"beam07.png"],
                            [CCSprite spriteWithFile:@"beam08.png"],
                            [CCSprite spriteWithFile:@"beam09.png"],
                            [CCSprite spriteWithFile:@"beam10.png"],
                            [CCSprite spriteWithFile:@"beam11.png"],
                            [CCSprite spriteWithFile:@"beam12.png"],
                            [CCSprite spriteWithFile:@"beam13.png"],
                            [CCSprite spriteWithFile:@"beam14.png"],
                            [CCSprite spriteWithFile:@"beam15.png"], nil];
    }
    return self;
}

- (Match4Element *)randomElementWithMaxType:(int)maxTypes
{
    Match4Element *newElement = [[[Match4Element alloc] init] autorelease];
    
    int i = arc4random()%maxTypes;
    newElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"symbol%d.png", i]];
    
    [newElement addChild:newElement.ElementImage];
    newElement.isOfType = i;
    return newElement;
}

- (Match4Element *)ElementWithType:(int)thisType
{
    Match4Element *newElement = [[[Match4Element alloc] init] autorelease];
    newElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"symbol%d.png", thisType]];
    [newElement addChild:newElement.ElementImage];
    newElement.isOfType = thisType;
    return newElement;
}


// need work
- (void)shiftElement:(Match4Element *)thisElement toType:(int)thisType
{
    thisElement.isOfType = thisType;
    //thisElement.opacity = 1;
    [thisElement removeAllChildren];
    //[thisElement.ElementImage release];
    thisElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"symbol%d.png", thisType]];;
    [thisElement addChild:thisElement.ElementImage];
}

- (void)turnToSuperElement:(Match4Element *)thisElement
{
    if (!thisElement.isSuper) {
        thisElement.isSuper = YES;
        [thisElement removeAllChildren];
        thisElement.ElementImageGlow = [[CCSprite spriteWithFile:[NSString stringWithFormat:@"symbol%d-glow.png", thisElement.isOfType]] autorelease];
        [thisElement addChild:thisElement.ElementImageGlow];
        [self animGlowElement:thisElement];
    }
}

- (void)selectElement:(Match4Element *)thisElement
{
    if (!thisElement.isSelected) {
        thisElement.isSelected = YES;
        thisElement.ElementSelectionBox = [CCSprite spriteWithFile:@"selectionBox.png"];
        [thisElement addChild:thisElement.ElementSelectionBox];
    }
}

- (void)deselectElement:(Match4Element *)thisElement
{
    if (thisElement.isSelected) {
        thisElement.isSelected = NO;
        [thisElement.ElementSelectionBox removeFromParent];
        //[thisElement.ElementSelectionBox release];
        thisElement.ElementSelectionBox = nil;
    }
}

#pragma animations///////////////////////
- (void)animGlowElement:(Match4Element *)thisElement
{
    [thisElement runAction:
     [CCRepeatForever actionWithAction:[CCBlink actionWithDuration:1 blinks:1]]];
    thisElement.tag = 1;
}

- (void)animExplodeElement:(Match4Element *)thisElement withDelay:(float)thisDelay
{
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:explodingElementFrames delay:0.2f];
    [thisElement runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:thisDelay],
      [CCAnimate actionWithAnimation:anim],
      [CCCallBlock actionWithBlock:^{
         [thisElement release];
     }],
      nil]];
}
     

- (void)animSuperElement:(Match4Element *)thisElement
{
    
}

- (void)animSuperEliminateElement:(Match4Element *)thisElement
{
    
}

- (void)animFlashElement:(Match4Element *)thisElement
{
    
}

- (void)animCrossShapeOnElement:(Match4Element *)thisElement
{
    
}

- (void)animHideElement:(Match4Element *)thisElement withDelay:(float)thisDelay
{
    id action = [CCSequence actions:[CCFadeIn actionWithDuration:1/30], [CCFadeOut actionWithDuration:1/30], nil];
    [thisElement runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:thisDelay],
      [CCRepeat actionWithAction:action times:3],
      [CCCallBlock actionWithBlock:^{
         if (thisElement.isVisible) {
             [thisElement removeFromParent];
             [thisElement release];
         }
     }],
      nil]];
}

@end
