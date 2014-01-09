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
    [thisLabel runAction:
     [CCSequence actions:
      [CCScaleTo actionWithDuration:0.7 scale:0.5],
      [CCFadeOut actionWithDuration:0.5],
      [CCCallBlock actionWithBlock:^{
         [thisLabel removeFromParent];
     }],
      nil]];
}

@end
