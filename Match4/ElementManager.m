//
//  ElementManager.m
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "ElementManager.h"

@implementation ElementManager
@synthesize explodingElementFrames, LShapeFrames, glowingElementFrames;


- (id) init
{
    if (self = [super init]) {
        normalFrame = CGRectMake(0, 0, 40, 40);
        engageFrame = CGRectMake(0, 0, 37, 37);
        explosionFrame = CGRectMake(-20, -20, 80, 80);
        
        explodingElementFrames = [[CCAnimation alloc] init];
        for (int i = 0; i < 10; i ++) {
            [explodingElementFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"SFX1_0%i.png", i]];
        }
        for (int i = 10; i < 18; i++) {
            [explodingElementFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"SFX1_%i.png", i]];
        }
        explodingElementFrames.delayPerUnit = 0.1;
        
        LShapeFrames = [[CCAnimation alloc] init];
        for (int i = 0; i < 10; i ++) {
            [LShapeFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"SFX3_0%i.png", i]];
        }
        for (int i = 10; i < 21; i++) {
            [LShapeFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"SFX3_%i.png", i]];
        }
        LShapeFrames.delayPerUnit = 2;
        
        glowingElementFrames = [[CCAnimation alloc] init];
        for (int i = 0; i < 10; i ++) {
            [glowingElementFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"2ndAE_0%i.png", i]];
        }
        for (int i = 10; i < 18; i ++) {
            [glowingElementFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"2ndAE_%i.png", i]];
        }
        glowingElementFrames.delayPerUnit = 0.1;
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
    [explodingElementFrames release];
    explodingElementFrames = nil;
    [LShapeFrames release];
    LShapeFrames = nil;
}

- (Match4Element *)randomElementWithMaxType:(int)maxTypes
{
    Match4Element *newElement = [[[Match4Element alloc] init] autorelease];
    
    int i = arc4random()%maxTypes;
    newElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"element%d.png", i]];
    
    [newElement addChild:newElement.ElementImage];
    newElement.isOfType = i;
    newElement.isVisible = YES;
    newElement.scale = 0.8;
    return newElement;
}

- (Match4Element *)ElementWithType:(int)thisType
{
    Match4Element *newElement = [[[Match4Element alloc] init] autorelease];
    newElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"element%d.png", thisType]];
    [newElement addChild:newElement.ElementImage];
    newElement.isOfType = thisType;
    newElement.scale = 0.8;
    return newElement;
}


// need work
- (void)shiftElement:(Match4Element *)thisElement toType:(int)thisType
{
    thisElement.isOfType = thisType;
    //thisElement.opacity = 1;
    [thisElement removeAllChildren];
    //[thisElement.ElementImage release];
    thisElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"element%d.png", thisType]];;
    thisElement.scale = 0.8;
    [thisElement addChild:thisElement.ElementImage];
}

- (void)turnToExplosiveElement:(Match4Element *)thisElement
{
    if (!thisElement.isExplosive) {
        thisElement.isExplosive = YES;
        [thisElement removeAllChildren];
        thisElement.ElementImageGlow = [[CCSprite spriteWithFile:[NSString stringWithFormat:@"element%d.png", thisElement.isOfType]] autorelease];
        [thisElement addChild:thisElement.ElementImageGlow];
        [self animGlowElement:thisElement];
    }
}

- (void)turnToSuperElement:(Match4Element *)thisElement
{
    [self animShiftToSuperElement:thisElement];
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
/*- (void)animGlowElement:(Match4Element *)thisElement
{
    [thisElement runAction:
     [CCRepeatForever actionWithAction:[CCBlink actionWithDuration:1 blinks:1]]];
    thisElement.tag = 1;
}*/

- (void)animGlowElement:(Match4Element *)thisElement
{
    thisElement.ElementAnimation = [[CCSprite alloc] init];
    [thisElement addChild:thisElement.ElementAnimation];
    [thisElement.ElementAnimation runAction:
     [CCRepeatForever actionWithAction:
      [CCAnimate actionWithAnimation:glowingElementFrames]]];
    thisElement.tag = 1;
}

- (void)animExplodeElement:(Match4Element *)thisElement withDelay:(float)thisDelay
{
    thisElement.ElementAnimation = [[CCSprite alloc] init];
    [thisElement addChild:thisElement.ElementAnimation];
    [thisElement.ElementAnimation runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:thisDelay],
      [CCAnimate actionWithAnimation:explodingElementFrames],
      [CCCallBlock actionWithBlock:^{
         [thisElement.ElementAnimation release];
         thisElement.ElementAnimation = nil;
         [thisElement removeFromParent];
     }],
      nil]];
}
     
/*- (void)animShiftToSuperElement:(Match4Element *)thisElement
{
    thisElement.ElementAnimation = [
}*/

- (void)animSuperElement:(Match4Element *)thisElement
{
    
}

- (void)animSuperEliminateElement:(Match4Element *)thisElement
{
    
}

- (void)animFlashElement:(Match4Element *)thisElement
{
    
}

- (void)animLShapeOnElement:(Match4Element *)thisElement
{
    //CGRect beamFrame = CGRectMake(0, 0, MAX((320 + 2 * abs(thisElement.center.x - 165)), (320 + 2 * abs(thisElement.center.y - 165))), 40);
    CCAnimation *rotatedLShapeFrames = [[CCAnimation alloc] init];
    for (int i = 0; i < 10; i ++) {
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTextureFilename:@"beam0%i.png" rect:CGRectMake(0, 0, MAX(320 + 2 * abs(thisElement.position.x - 165), (320 + 2 * abs(thisElement.position.y - 165))), 40)];
        frame.rotated = YES;
        [LShapeFrames addSpriteFrame:frame];
    }
    for (int i = 10; i < 16; i++) {
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTextureFilename:@"beam0%i.png" rect:CGRectMake(0, 0, MAX(320 + 2 * abs(thisElement.position.x - 165), (320 + 2 * abs(thisElement.position.y - 165))), 40)];
        frame.rotated = YES;
        [LShapeFrames addSpriteFrame:frame];
    }
    rotatedLShapeFrames.delayPerUnit = 2;
    thisElement.ElementAnimation = [[CCSprite alloc] init];
    [thisElement addChild:thisElement.ElementAnimation];
    [thisElement.ElementAnimation runAction:
     [CCSequence actions:
      [CCSpawn actionOne:[CCAnimate actionWithAnimation:LShapeFrames] two:[CCAnimate actionWithAnimation:rotatedLShapeFrames]],
      nil]];
    
    [self animHideElement:thisElement withDelay:0];
    
}

- (void)animHideElement:(Match4Element *)thisElement withDelay:(float)thisDelay
{
    id action = [CCSequence actions:[CCFadeIn actionWithDuration:0.01], [CCBlink actionWithDuration:0.1], nil];
    [thisElement runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:thisDelay],
      [CCRepeat actionWithAction:action times:3],
      [CCCallBlock actionWithBlock:^{
         if (thisElement.isVisible) {
             [thisElement removeFromParent];
             //[thisElement release];
         }
     }],
      nil]];
}

@end
