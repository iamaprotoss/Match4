//
//  Match4EngineTime.h
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
#import "Match4Element.h"
#import "GameController.h"
#import "ElementManager.h"

@interface Match4EngineTime : CCLayer
{
    BOOL isVisible;
    BOOL canTouch;
    GameController *gameController;
    ElementManager *elementManager;
    Match4Element *firstTouchedElement;
    NSMutableArray *gameGrid;
    NSMutableArray *hintGrid;
    NSMutableSet *elementsToRemove;
    NSMutableSet *elementsToMove;
    NSMutableSet *elementsToSkip;
    
    BOOL isShockwave;
    CGPoint shockwaveCentre;
    
    int noOfNormalMatches;
    int noOfDoubleMatches;
    int noOfShifterMatches;
    int noOfMatchesOf4;
    int noOfMatchesOf4Explosion;
    int noOfMatchesOf5;
    int noOfSuperEliminated;
    int noOfLShapedMatches;
    int noOfCorruptedCleared;
    int noOfCascadingMatches;
    
    int pointsToAdd;
    
    BOOL isMoveValid;
}

@property (nonatomic, retain) NSMutableArray *gameGrid;
@property (nonatomic, retain) Match4Element *firstTouchedElement;
@property (nonatomic) BOOL canTouch;

- (id)init;

- (void)selectElement:(Match4Element *)thisElement;
- (BOOL)element:(CGPoint)firstIndex isNeighbourToElement:(CGPoint)secondIndex;
- (void)swapElement:(Match4Element *)firstElement withElement:(Match4Element *)secondElement;
- (void)swapBackElement:(Match4Element *)firstElement withElement:(Match4Element *)secondElement;

- (void)eliminateNeighboursOfElementAtIndex:(CGPoint)thisIndex;
- (void)eliminateAllElementsOfType:(int)thisType;
- (void)eliminateAllElementsInLineWithElementAtIndex:(CGPoint)thisIndex;

- (void)searchPatterns;
- (void)searchPatternForElement:(Match4Element *)thisElement;

- (void)populateGameField;
- (void)refillGameField;
- (void)checkIfElementNotMakingPattern:(Match4Element *)thisElement;
- (void)repositionAllElements;
- (void)checkIfAllElementsRepositioned;
- (void)reshuffle;

- (void)eraseElements;

- (CGPoint) positionFromIndex:(CGPoint)thisIndex;

@end
