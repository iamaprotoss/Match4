//
//  LabelManager.h
//  Match4
//
//  Created by apple on 14-1-9.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match4Label.h"

@interface LabelManager : NSObject

- (void)animGlitch:(Match4Label *)thisLabel WithDelay:(float)thisDelay andDoRepeat:(BOOL)doRepeat;

@end
