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
#import "LabelManager.h"

@interface Match4EngineGame : CCLayer
{
    BOOL isVisible;
    BOOL canTouch;
    //GameController *gameController;
    ElementManager *elementManager;
    LabelManager *labelManager;
    Match4Element *firstTouchedElement;
    NSMutableArray *gameGrid;
    NSMutableArray *hintGrid;
    NSMutableSet *elementsToRemove;
    NSMutableSet *elementsToMove;
    NSMutableSet *elementsToSkip;
    
    int initialSuperiorIndex[3];
    
    NSMutableArray *partitionOfGrid;
    NSMutableArray *partitionOfHintGrid;
    NSInteger group[8][8];
    NSInteger hintGroup[8][8];
    
    BOOL isNormalMatch;
    BOOL isExplosion;
    BOOL isColorElimination;
    BOOL isLShapeElimination;
    BOOL isNuclearBomb;
    BOOL isCascading;
    
    float explosionDelay;
    
    BOOL isShockWave;
    CGPoint shockwaveCentre;
    
    int noOfStandardEliminate;
    int noOfSuperiorSingle;
    int noOfSuperiorSingleOther;
    int noOfSuperiorDouble;
    int noOfSuperiorDoubleOther;
    int noOfSuperiorTriple;
    int noOfSuperiorTripleOther;
    int noOfSuperiorAll;
    int noOfSuperiorAllOther;
    int noOfNormal;
    int levelOfCascading;
    
    int multiplier;
    
    //int levelOfChain;
    
    int totalPointsToAdd;
    int pointsForOneStroke;
    // Special effects
    NSMutableDictionary *special;
    
    BOOL isMoveValid;
    CCAnimation *hintAnimationFrames;
    
    CCSprite *hintAnim;
    
    // Tutorial part
    BOOL isTutorial;
    int tutorialStep;
    CCSprite *mask1;
    CCSprite *mask2;
    CCSprite *mask3;
    CCSprite *mask4;
}

@property (nonatomic, retain) NSMutableArray *gameGrid;
@property (nonatomic, retain) Match4Element *firstTouchedElement;
@property (nonatomic) BOOL canTouch;

- (id)initWithDictionary:(NSMutableDictionary *)thisDict;

- (void)selectElement:(Match4Element *)thisElement;
- (BOOL)element:(CGPoint)firstIndex isNeighbourToElement:(CGPoint)secondIndex;
- (void)swapElement:(Match4Element *)firstElement withElement:(Match4Element *)secondElement;
- (void)swapBackElement:(Match4Element *)firstElement withElement:(Match4Element *)secondElement;

- (int)eliminateNeighboursOfElementAtIndex:(CGPoint)thisIndex levelOfChain:(int)levelOfChain;
- (int)eliminateAllElementsOfType:(int)thisType;
- (int)eliminateAllElementsInLineWithElementAtIndex:(CGPoint)thisIndex;

- (void)searchPatterns;
//- (void)searchPatternForElement:(Match4Element *)thisElement;

- (void)resetGame;
- (void)populateGameField;
- (void)refillGameField;
- (void)checkIfElementNotMakingPattern:(Match4Element *)thisElement;
- (void)findPartition;
- (int)findConnectedComponent:(Match4Element *)thisElement;
- (void)repositionAllElements;
- (void)checkIfAllElementsRepositioned;
- (void)reshuffle;
- (CGPoint)getHint;
- (void)showHint:(CGPoint)hintIndex;

- (void)eraseElements;

- (CGPoint) positionFromIndex:(CGPoint)thisIndex;
- (CGPoint) indexFromPosition:(CGPoint)thisPosition;

- (id) initWithTutorial;
- (void) refillGameFieldForTutorial;
@end

