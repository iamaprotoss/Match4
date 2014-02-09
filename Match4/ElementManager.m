//
//  ElementManager.m
//  Match4
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "ElementManager.h"
#import "Match4Label.h"
#import "GameController.h"
#import "Match4TimeView.h"

@implementation ElementManager
@synthesize explodingElementFrames, colorEliminateFrames, LShapeFrames, rotatedLShapeFrames, glowingElementFrames;


- (id) init
{
    if (self = [super init]) {
        normalFrame = CGRectMake(0, 0, 40, 40);
        engageFrame = CGRectMake(0, 0, 37, 37);
        explosionFrame = CGRectMake(-20, -20, 80, 80);
        
        explodingElementFrames = [[CCAnimation alloc] init];
        for (int i = 1; i < 10; i ++) {
            [explodingElementFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"SFX1_0%i.png", i]];
        }
        for (int i = 10; i < 18; i++) {
            [explodingElementFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"SFX1_%i.png", i]];
        }
        explodingElementFrames.delayPerUnit = 0.04;
        
        colorEliminateFrames = [[CCAnimation alloc] init];
        for (int i = 1; i < 10; i++) {
            [colorEliminateFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"SFX2_0%i.png", i]];
        }
        for (int i = 10; i < 21; i++) {
            [colorEliminateFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"SFX2_%i.png", i]];
        }
        colorEliminateFrames.delayPerUnit = 0.04;
        
        LShapeFrames = [[CCAnimation alloc] init];
        for (int i = 0; i < 10; i ++) {
            [LShapeFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"lightening_0%i.png", i]];
        }
        for (int i = 10; i < 24; i++) {
            [LShapeFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"lightening_%i.png", i]];
        }
        LShapeFrames.delayPerUnit = 0.04;
        
        rotatedLShapeFrames = [[CCAnimation alloc] init];
        for (int i = 1; i < 10; i ++) {
            [rotatedLShapeFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"lighteningv_0%i.png", i]];
        }
        for (int i = 10; i < 24; i++) {
            [rotatedLShapeFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"lighteningv_%i.png", i]];
        }
        rotatedLShapeFrames.delayPerUnit = 0.04;

        
        glowingElementFrames = [[CCAnimation alloc] init];
        for (int i = 80; i < 100; i ++) {
            [glowingElementFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"2nd00%i.png", i]];
        }
        for (int i = 100; i < 121; i ++) {
            [glowingElementFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"2nd0%i.png", i]];
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
    newElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"element%dp.png", i]];
    /*NSString *elementName;
    switch (i) {
        case 0:
            elementName = @"element_baiyang.png";
            break;
        case 1:
            elementName = @"element_chunv.png";
            break;
        case 2:
            elementName = @"element_jinniu.png";
            break;
        case 3:
            elementName = @"element_juxie.png";
            break;
        case 4:
            elementName = @"element_mojie.png";
            break;
        case 5:
            elementName = @"element_sheshou.png";
            break;
        case 6:
            elementName = @"element_shizi.png";
            break;
        case 7:
            elementName = @"element_shuangyu.png";
            break;
        case 8:
            elementName = @"element_shuangzi.png";
            break;
        case 9:
            elementName = @"element_shuiping.png";
            break;
        case 10:
            elementName = @"element_tianping.png";
            break;
        case 11:
            elementName = @"element_tianxie.png";
            break;
        default:
            break;
    }
    newElement.ElementImage = [CCSprite spriteWithFile:elementName];*/
    
    [newElement addChild:newElement.ElementImage];
    newElement.isOfType = i;
    newElement.isVisible = YES;
    newElement.pointsToAdd = 0;
    newElement.animDelay = 0;
    newElement.scale = 0.9;
    return newElement;
}

- (Match4Element *)ElementWithType:(int)thisType
{
    Match4Element *newElement = [[[Match4Element alloc] init] autorelease];
    newElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"element%dp.png", thisType]];
    [newElement addChild:newElement.ElementImage];
    newElement.isOfType = thisType;
    newElement.isVisible = YES;
    newElement.pointsToAdd = 0;
    newElement.animDelay = 0;
    newElement.scale = 0.9;
    return newElement;
}


// need work
- (void)shiftElement:(Match4Element *)thisElement toType:(int)thisType
{
    thisElement.isOfType = thisType;
    //thisElement.opacity = 1;
    [thisElement removeAllChildren];
    //[thisElement.ElementImage release];
    thisElement.ElementImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"element%dp.png", thisType]];;
    thisElement.scale = 0.9;
    [thisElement addChild:thisElement.ElementImage];
}

- (void)turnToExplosiveElement:(Match4Element *)thisElement
{
    if (!thisElement.isExplosive) {
        thisElement.isExplosive = YES;
        [thisElement removeAllChildren];
        thisElement.ElementImageGlow = [[CCSprite spriteWithFile:[NSString stringWithFormat:@"element%dp.png", thisElement.isOfType]] autorelease];
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
    thisElement.ElementAnimation.zOrder = thisElement.ElementImage.zOrder-1;
    [thisElement.ElementAnimation runAction:
     [CCRepeatForever actionWithAction:
      [CCAnimate actionWithAnimation:glowingElementFrames]]];
    //thisElement.tag = 1;
}

- (void)animExplodeElement:(Match4Element *)thisElement withDelay:(float)thisDelay
{
    if (thisElement.ElementAnimation) {
        [thisElement.ElementAnimation stopAllActions];
        //[thisElement.ElementAnimation release];
    }
    thisElement.zOrder = 100;
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

- (void)animColorEliminateElement:(Match4Element *)thisElement withDelay:(float)thisDelay
{
    if (thisElement.ElementAnimation) {
        [thisElement.ElementAnimation stopAllActions];
    }
    thisElement.zOrder = 100;
    thisElement.ElementAnimation = [[CCSprite alloc] init];
    [thisElement addChild:thisElement.ElementAnimation];
    [thisElement.ElementAnimation runAction:
     [CCSequence actions:
      //[CCDelayTime actionWithDuration:thisDelay],
      [CCAnimate actionWithAnimation:colorEliminateFrames],
      [CCCallBlock actionWithBlock:^{
         [thisElement.ElementAnimation release];
         thisElement.ElementAnimation = nil;
         [thisElement removeFromParent];
     }],
      nil]];
    //[self animHideElement:thisElement withDelay:thisDelay];
}

- (void)animFlashElement:(Match4Element *)thisElement
{
    
}

- (void)animLShapeOnElement:(Match4Element *)thisElement
{
    //thisElement.ElementAnimation = [[CCSprite alloc] init];
    //[thisElement addChild:thisElement.ElementAnimation];
    CCSprite *LShapeHorizontal = [[CCSprite alloc] init];
    LShapeHorizontal.position = ccp(160, 20+thisElement.isIndex.y*40);
    [[thisElement parent] addChild:LShapeHorizontal];
    [LShapeHorizontal runAction:
     [CCSequence actions:
      [CCAnimate actionWithAnimation:LShapeFrames],
      [CCCallBlock actionWithBlock:^{
         [LShapeHorizontal removeFromParent];
         [LShapeHorizontal release];
         [thisElement removeFromParent];
     }],
      nil]];
    
    CCSprite *LShapeVertical = [[CCSprite alloc] init];
    LShapeVertical.position = ccp(20+thisElement.isIndex.x*40, 160);
    [[thisElement parent] addChild:LShapeVertical];
    [LShapeVertical runAction:
     [CCSequence actions:
      [CCAnimate actionWithAnimation:rotatedLShapeFrames],
      [CCCallBlock actionWithBlock:^{
         [LShapeVertical removeFromParent];
         [LShapeVertical release];
     }],
      nil]];
    
    /*
    [thisElement.ElementAnimation runAction:
     [CCSequence actions:
      [CCSpawn actionOne:
       [CCAnimate actionWithAnimation:LShapeFrames]
       two:
       [CCAnimate actionWithAnimation:rotatedLShapeFrames]],
      [CCCallBlock actionWithBlock:^{
         [thisElement.ElementAnimation release];
         thisElement.ElementAnimation = nil;
         [thisElement removeFromParent];
     }],
      nil]];*/
}

- (void)animHideElement:(Match4Element *)thisElement withDelay:(float)thisDelay
{
    /*id action = [CCSequence actions:[CCFadeIn actionWithDuration:0.01], [CCBlink actionWithDuration:0.1], nil];
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
      nil]];*/
    [thisElement runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:thisDelay],
      [CCScaleTo actionWithDuration:0.3 scale:0.5],
      [CCCallBlock actionWithBlock:^{
         if (thisElement.isVisible) {
             [thisElement removeFromParent];
         }
     }],
      nil]];
}

- (void)animHintElement:(Match4Element *)thisElement
{
    Match4Label *label = [Match4Label labelWithString:@"OK" fontSize:16];
    [thisElement addChild:label];
}

@end
