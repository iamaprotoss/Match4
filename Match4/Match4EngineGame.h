//
//  Match4EngineGame.h
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "CCLayer.h"
#import "Match4Element.h"
#import "GameController.h"
#import "ElementManager.h"

@interface Match4EngineGame : CCLayer
{
    BOOL isVisible;
    BOOL canTouch;
    //GameController *gameController;
    ElementManager *elementManager;
    Match4Element *firstTouchedElement;
    NSMutableArray *gameGrid;
    NSMutableArray *hintGrid;
    NSMutableSet *elementsToRemove;
    NSMutableSet *elementsToMove;
    NSMutableSet *elementsToSkip;
    
    NSMutableArray *partitionOfGrid;
    NSInteger group[8][8];
    
    BOOL isNuclearBomb;
    
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

- (void)resetGame;
- (void)populateGameField;
- (void)refillGameField;
- (void)checkIfElementNotMakingPattern:(Match4Element *)thisElement;
- (int)findConnectedComponent:(Match4Element *)thisElement;
- (void)repositionAllElements;
- (void)checkIfAllElementsRepositioned;
- (void)reshuffle;

- (void)eraseElements;

- (CGPoint) positionFromIndex:(CGPoint)thisIndex;
- (CGPoint) indexFromPosition:(CGPoint)thisPosition;

@end

