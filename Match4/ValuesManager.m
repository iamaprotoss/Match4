//
//  ValuesManager.m
//  Match4
//
//  Created by Zhenwei on 14-1-5.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "ValuesManager.h"

@implementation ValuesManager
@synthesize kPointsStandardEliminate, kPointsSuperiorSingle, kPointsSuperiorSingleOther, kPointsSuperiorDouble, kPointsSuperiorDoubleOther, kPointsSuperiorTriple, kPointsSuperiorTripleOther, kPointsSuperiorAll, kPointsSuperiorAllOther, kPointsBonusForCascading, kPointsNormal;

- (id)init {
    if (self = [super init]) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        isNotFirstTime = [[userDefaults valueForKey:@"isNotFirstTime"] boolValue];
        //if (isNotFirstTime) {
            [self initValues];
        //} else {
            [self firstInitValues];
        //}
    }
    return self;
}

- (void)firstInitValues {
    isNotFirstTime = YES;
    [userDefaults setBool:isNotFirstTime forKey:@"isNotFirstTime"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Match4Values" ofType:@"plist"];
    NSDictionary *match4Values = [[NSDictionary alloc] initWithContentsOfFile:path];
    [self setValuesForKeysWithDictionary:match4Values];
    [userDefaults setObject:match4Values forKey:@"match4Values"];
    [match4Values release];
    [self initValues];
}

- (void)initValues {
    NSDictionary *match4Values = (NSDictionary *)[userDefaults dictionaryForKey:@"match4Values"];
    [self setValuesFromDictionary:match4Values];
}

- (void)setValuesFromDictionary:(NSDictionary *)thisDictionary {
    if (thisDictionary != nil) {
        kPointsStandardEliminate = [[thisDictionary valueForKey:@"kPointsStandardEliminate"] intValue];
        kPointsSuperiorSingle = [[thisDictionary valueForKey:@"kPointsSuperiorSingle"] intValue];
        kPointsSuperiorSingleOther = [[thisDictionary valueForKey:@"kPointsSuperiorSingleOther"] intValue];
        kPointsSuperiorDouble = [[thisDictionary valueForKey:@"kPointsSuperiorDouble"] intValue];
        kPointsSuperiorDoubleOther = [[thisDictionary valueForKey:@"kPointsSuperiorDoubleOther"] intValue];
        kPointsSuperiorTriple = [[thisDictionary valueForKey:@"kPointsSuperiorTriple"] intValue];
        kPointsSuperiorTripleOther = [[thisDictionary valueForKey:@"kPointsSuperiorTripleOther"] intValue];
        kPointsSuperiorAll = [[thisDictionary valueForKey:@"kPointsSuperiorAll"] intValue];
        kPointsSuperiorAllOther = [[thisDictionary valueForKey:@"kPointsSuperiorAllOther"] intValue];
        kPointsBonusForCascading = [[thisDictionary valueForKey:@"kPointsBonusForCascading"] intValue];
        NSLog(@"%i", kPointsBonusForCascading);
    }
}

@end
