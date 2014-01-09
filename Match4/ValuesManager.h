//
//  ValuesManager.h
//  Match4
//
//  Created by Zhenwei on 14-1-5.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValuesManager : NSObject <NSURLConnectionDataDelegate>
{
    NSUserDefaults *userDefaults;
    BOOL isNotFirstTime;
    NSURLConnection *plistConnection;
    NSMutableData *plistResponse;
    
    int kPointsStandardEliminate;
    int kPointsSuperiorSingle;
    int kPointsSuperiorSingleOther;
    int kPointsSuperiorDouble;
    int kPointsSuperiorDoubleOther;
    int kPointsSuperiorTriple;
    int kPointsSuperiorTripleOther;
    int kPointsSuperiorAll;
    int kPointsSuperiorAllOther;
    int kPointsNormal;
}

@property (nonatomic) int kPointsStandardEliminate;
@property (nonatomic) int kPointsSuperiorSingle;
@property (nonatomic) int kPointsSuperiorSingleOther;
@property (nonatomic) int kPointsSuperiorDouble;
@property (nonatomic) int kPointsSuperiorDoubleOther;
@property (nonatomic) int kPointsSuperiorTriple;
@property (nonatomic) int kPointsSuperiorTripleOther;
@property (nonatomic) int kPointsSuperiorAll;
@property (nonatomic) int kPointsSuperiorAllOther;
@property (nonatomic) int kPointsNormal;

- (void) firstInitValues;
- (void) initValues;
- (void) setValuesFromDictionary:(NSDictionary *)thisDictionary;

@end
