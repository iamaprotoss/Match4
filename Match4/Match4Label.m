//
//  Match4Label.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4Label.h"

@implementation Match4Label

+ (id) labelWithString:(NSString *)string fontSize:(int)thisSize
{
    return [CCLabelTTF labelWithString:string fontName:@"Dimbo" fontSize:thisSize];
}

- (void)animGlitchWithDelay:(float)thisDelay andDoRepeat:(BOOL)doRepeat
{
    
}

- (void)animGlitchWithAction:(void (^)(void))action
{
    
}

- (void)animUpdateWithText:(NSString *)thisString
{
    
}

- (void)stopAnimatingLabel
{
    canAnimate = NO;
}

- (void)dealloc
{
    canAnimate = NO;
    [super dealloc];
}

@end
