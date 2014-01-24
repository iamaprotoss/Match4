//
//  LabelManager.m
//  Match4
//
//  Created by apple on 14-1-9.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "LabelManager.h"

@implementation LabelManager

- (void)animGlitch:(Match4Label *)thisLabel WithDelay:(float)thisDelay andDoRepeat:(BOOL)doRepeat
{
    thisLabel.zOrder = 200;
    [thisLabel runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:thisDelay],
      [CCScaleTo actionWithDuration:0.7 scale:0.6],
      [CCFadeOut actionWithDuration:0.5],
      [CCCallBlock actionWithBlock:^{
         [thisLabel removeFromParent];
     }],
      nil]];
}

@end
