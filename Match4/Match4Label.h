//
//  Match4Label.h
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "CCLabelTTF.h"

@interface Match4Label : CCLabelTTF
{
    BOOL canAnimate;
    float size;
}

+ (id) labelWithString:(NSString *)name fontSize:(int)size;
//- (void)styleWithSize:(float)thisSize;
- (void)shadowSizeRatio:(float)thisRatio;
- (void)animGlitchWithDelay:(float)thisDelay andDoRepeat:(BOOL)doRepeat;
- (void)animGlitchWithAction:(void (^)(void))action;
- (void)animUpdateWithText:(NSString *)thisString;
- (void)stopAnimatingLabel;

@end
