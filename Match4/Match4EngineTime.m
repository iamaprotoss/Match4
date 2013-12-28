//
//  Match4EngineTime.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4EngineTime.h"

@implementation Match4EngineTime

@synthesize gameGrid;
@synthesize firstTouchedElement;
@synthesize canTouch;

- (id)init
{
    if (self = [super init]) {
        isVisible = NO;
        gameGrid = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i ++) {
            [gameGrid addObject:[NSMutableArray array]];
        }
        elementsToRemove = [[NSMutableSet alloc] init];
        elementsToMove = [[NSMutableSet alloc] init];
        elementsToSkip = [[NSMutableSet alloc] init];
        
        elementManager = [GameController sharedController].elementManager;
        firstTouchedElement = nil;
        [self populateGameField];
        [self setTouchEnabled:YES];
    }
    return self;
}

#pragma GRID MANAGEMENT

- (void) reshuffle
{
    
}

- (void) resetLocalStore
{
    
}

- (void) populateGameField
{
    NSMutableArray *gameGridArray = gameController.localStore.currentGame.gameGrid;
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            BOOL isElementLoaded = NO;
            Match4Element *element = nil;
            ///////////////////////
            // First check local store //
            ///////////////////////
            // Then
            if (!element) {
                element = [elementManager randomElementWithMaxType:6];
            }
            element.isIndex = CGPointMake(i, j);
            element.position = [self positionFromIndex:element.isIndex];
            [[gameGrid objectAtIndex:i] addObject:element];
            [self checkIfElementNotMakingPattern:element];
            element.opacity = 0.001;
            [self addChild:element];
            
            if (isElementLoaded) {
                
            }
        }
    }
    
    canTouch = YES;
    
    [self resetLocalStore];
}

- (void) checkIfElementNotMakingPattern:(Match4Element *)thisElement
{
    int x = thisElement.isIndex.x;
    int y = thisElement.isIndex.y;
    int typeToSkip = thisElement.isOfType;
    BOOL hasToChange = NO;
    Match4Element *ElementToCheck;
    if (x > 1) {
        ElementToCheck = [[gameGrid objectAtIndex:x - 1] objectAtIndex:y];
        if (ElementToCheck.isOfType == typeToSkip) {
            ElementToCheck = [[gameGrid objectAtIndex:x - 2] objectAtIndex:y];
            if (ElementToCheck.isOfType == typeToSkip) hasToChange = YES;
        }
    }
    if (y > 1) {
        ElementToCheck = [[gameGrid objectAtIndex:x] objectAtIndex:y - 1];
        if (ElementToCheck.isOfType == typeToSkip) {
            ElementToCheck = [[gameGrid objectAtIndex:x] objectAtIndex:y - 2];
            if (ElementToCheck.isOfType == typeToSkip) hasToChange = YES;
        }
    }
    if (hasToChange) {
        int k = (arc4random() % 6) + 1;
        int newType = (thisElement.isOfType + k) % 6;
        [elementManager shiftElement:thisElement toType:newType];
    }

}


#pragma SEARCH PATTERNS
- (void)searchPatterns {
    
    ///L-shaped pattern
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            Match4Element *searchedElement = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (![elementsToRemove containsObject:searchedElement]);
                //[self searchPatternLShapeForElement:searchedElement];
        }
    }
    
    ///horizontal patterns
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 8; j++) {
            Match4Element *searchedElement = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (![elementsToRemove containsObject:searchedElement])
                [self searchPatternHorizontalForElement:searchedElement];
        }
    }
    
    ///vertical patterns
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 6; j++) {
            Match4Element *searchedElement = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (![elementsToRemove containsObject:searchedElement])
                [self searchPatternVerticalForElement:searchedElement];
        }
    }
    
    if ([elementsToRemove count] > 0) {
        isMoveValid = YES;
        //if ((isDoubleMatch) & ([elementsToRemove count] > 5)) noOfDoubleMatches++;
        [self eraseElements];
    }
    else {
        /*if (viewController.actionView.isGameOver) {
            [viewController.actionView proposeReshuffle];
        }
        else {
            isCascading = NO;
            noOfCascadingMatches = 0;
            [self checkScore];
            [viewController.actionView checkForInfoPopUps];
            canTouch = YES;
        }*/
        canTouch = YES;
    }
    //isDoubleMatch = NO;
}

/*
- (void)searchPatternLShapeForElement:(Match4Element *)thisElement {
    int x = thisElement.isIndex.x;
    int y = thisElement.isIndex.y;
    BOOL hasHorizontal = NO;
    BOOL hasVertical = NO;
    
    if (x > 1) {
        Match4Element *nextElement = [[gameGrid objectAtIndex:x - 1] objectAtIndex:y];
        if (thisElement.isOfType == nextElement.isOfType) {
            nextElement = [[gameGrid objectAtIndex:x - 2] objectAtIndex:y];
            if (thisElement.isOfType == nextElement.isOfType) hasHorizontal = YES;
        }
    }
    if (x < 6) {
        Match4Element *nextElement = [[gameGrid objectAtIndex:x + 1] objectAtIndex:y];
        if (thisElement.isOfType == nextElement.isOfType) {
            nextElement = [[gameGrid objectAtIndex:x + 2] objectAtIndex:y];
            if (thisElement.isOfType == nextElement.isOfType) hasHorizontal = YES;
        }
    }
    if (y > 1) {
        Match4Element *nextElement = [[gameGrid objectAtIndex:x] objectAtIndex:y - 1];
        if (thisElement.isOfType == nextElement.isOfType) {
            nextElement = [[gameGrid objectAtIndex:x] objectAtIndex:y - 2];
            if (thisElement.isOfType == nextElement.isOfType) hasVertical = YES;
        }
    }
    if (y < 6) {
        Match4Element *nextElement = [[gameGrid objectAtIndex:x] objectAtIndex:y + 1];
        if (thisElement.isOfType == nextElement.isOfType) {
            nextElement = [[gameGrid objectAtIndex:x] objectAtIndex:y + 2];
            if (thisElement.isOfType == nextElement.isOfType) hasVertical = YES;
        }
    }
    
    if (hasHorizontal & hasVertical) {
        thisElement.isLShapeCorner = YES;
        noOfLShapedMatches++;
        [self eliminateAllElementsInLineWithElementAtIndex:thisElement.isIndex];
    }
}
*/

- (void)searchPatternHorizontalForElement:(Match4Element *)thisElement {
    int x = thisElement.isIndex.x + 1;
    int y = thisElement.isIndex.y;
    int matched = 1;
    BOOL canBreak = NO;
    BOOL canEliminateNeighbours = NO;
    
    if (thisElement.isSuper) canEliminateNeighbours = YES;
    
    while (x < 8) {
        Match4Element *nextElement = [[gameGrid objectAtIndex:x] objectAtIndex:y];
        if (thisElement.isOfType == nextElement.isOfType) {
            matched++;
            if (nextElement.isSuper) canEliminateNeighbours = YES;
        }
        else canBreak = YES;
        x++;
        if (canBreak) break;
    }
    
    x = thisElement.isIndex.x;
    switch (matched) {
        case 5:
            noOfMatchesOf5++;
            for (int i = 0; i < matched; i++) {
                Match4Element *elementToAdd = [[gameGrid objectAtIndex:thisElement.isIndex.x + i] objectAtIndex:thisElement.isIndex.y];
                if (i == 0) {
                    [elementsToSkip addObject:elementToAdd];
                    [elementManager turnToSuperElement:elementToAdd];
                }
                else {
                    if (![elementsToRemove containsObject:elementToAdd]) [elementsToRemove addObject:elementToAdd];
                }
            }
            break;
        case 4:
            noOfMatchesOf4++;
            for (int i = 0; i < matched; i++) {
                Match4Element *elementToAdd = [[gameGrid objectAtIndex:thisElement.isIndex.x + i] objectAtIndex:thisElement.isIndex.y];
                if (i == 0) {
                    [elementsToSkip addObject:elementToAdd];
                    [elementManager turnToSuperElement:elementToAdd];
                }
                else {
                    if (![elementsToRemove containsObject:elementToAdd]) [elementsToRemove addObject:elementToAdd];
                }
            }
            break;
        case 3:
            noOfNormalMatches++;
            for (int i = 0; i < matched; i++) {
                Match4Element *elementToAdd = [[gameGrid objectAtIndex:thisElement.isIndex.x + i] objectAtIndex:thisElement.isIndex.y];
                if (![elementsToRemove containsObject:elementToAdd]) [elementsToRemove addObject:elementToAdd];
            }
            break;
        default:
            break;
    }
    if (canEliminateNeighbours & (matched > 2)) {
        noOfMatchesOf4Explosion++;
        for (int i = 0; i < matched; i++) {
            Match4Element *elementToCheck = [[gameGrid objectAtIndex:thisElement.isIndex.x + i] objectAtIndex:thisElement.isIndex.y];
            elementToCheck.isToExplode = YES;
            [self eliminateNeighboursOfElementAtIndex:elementToCheck.isIndex];
        }
        isShockwave = YES;
        shockwaveCentre = CGPointMake(x, y);
    }
}

- (void)searchPatternVerticalForElement:(Match4Element *)thisElement {
    int x = thisElement.isIndex.x;
    int y = thisElement.isIndex.y + 1;
    int matched = 1;
    BOOL canBreak = NO;
    BOOL canEliminateNeighbours = NO;
    
    if (thisElement.isSuper) canEliminateNeighbours = YES;
    
    while (y < 8) {
        Match4Element *nextElement = [[gameGrid objectAtIndex:x] objectAtIndex:y];
        if (thisElement.isOfType == nextElement.isOfType) {
            matched++;
            if (nextElement.isSuper) canEliminateNeighbours = YES;
        }
        else canBreak = YES;
        y++;
        if (canBreak) break;
    }
    
    y = thisElement.isIndex.y;
    switch (matched) {
        case 5:
            noOfMatchesOf5++;
            for (int j = 0; j < matched; j++) {
                Match4Element *elementToAdd = [[gameGrid objectAtIndex:thisElement.isIndex.x] objectAtIndex:thisElement.isIndex.y + j];
                if (j == 0) {
                    [elementsToSkip addObject:elementToAdd];
                    [elementManager turnToSuperElement:elementToAdd];
                }
                else {
                    if (![elementsToRemove containsObject:elementToAdd]) [elementsToRemove addObject:elementToAdd];
                }
            }
            break;
        case 4:
            noOfMatchesOf4++;
            for (int j = 0; j < matched; j++) {
                Match4Element *elementToAdd = [[gameGrid objectAtIndex:thisElement.isIndex.x] objectAtIndex:thisElement.isIndex.y + j];
                if (j == 0) {
                    [elementsToSkip addObject:elementToAdd];
                    [elementManager turnToSuperElement:elementToAdd];
                }
                else {
                    if (![elementsToRemove containsObject:elementToAdd]) [elementsToRemove addObject:elementToAdd];
                }
            }
            break;
        case 3:
            noOfNormalMatches++;
            for (int j = 0; j < matched; j++) {
                Match4Element *elementToAdd = [[gameGrid objectAtIndex:thisElement.isIndex.x] objectAtIndex:thisElement.isIndex.y + j];
                if (![elementsToRemove containsObject:elementToAdd]) [elementsToRemove addObject:elementToAdd];
            }
            break;
        default:
            break;
    }
    if (canEliminateNeighbours & (matched > 2)) {
        noOfMatchesOf4Explosion++;
        for (int j = 0; j < matched; j++) {
            Match4Element *elementToCheck = [[gameGrid objectAtIndex:thisElement.isIndex.x] objectAtIndex:thisElement.isIndex.y + j];
            elementToCheck.isToExplode = YES;
            [self eliminateNeighboursOfElementAtIndex:elementToCheck.isIndex];
        }
        isShockwave = YES;
        shockwaveCentre = CGPointMake(x, y);
    }
}

- (void)eliminateNeighboursOfElementAtIndex:(CGPoint)thisIndex
{
    int m;
    int n;
    for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
            m = thisIndex.x + i;
            n = thisIndex.y + j;
            if ((m > -1) & (m < 8) & (n > -1) & (n < 8)) {
                Match4Element *elementToAdd = [[gameGrid objectAtIndex:m] objectAtIndex:n];
                if (elementToAdd.isOfType > 6) [elementsToSkip addObject:elementToAdd];
                if (!([elementsToRemove containsObject:elementToAdd]) & (![elementsToSkip containsObject:elementToAdd])) {
                    [elementsToRemove addObject:elementToAdd];
                    elementToAdd.isToExplode = YES;
                }
            }
        }
    }
    
}

- (void)eliminateAllElementsOfType:(int)thisType {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            Match4Element *elementToCheck = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (elementToCheck.isOfType == thisType) {
                //elementToCheck.isSuperEliminated = YES;
                [elementsToRemove addObject:elementToCheck];
                noOfSuperEliminated++;
            }
        }
    }
    [self eraseElements];
}

- (void)eliminateAllElementsInLineWithElementAtIndex:(CGPoint)thisIndex {
    for (int i = 0; i < 8; i++) {
        Match4Element *elementToAdd = [[gameGrid objectAtIndex:i] objectAtIndex:thisIndex.y];
        if (![elementsToRemove containsObject:elementToAdd]) [elementsToRemove addObject:elementToAdd];
    }
    for (int j = 0; j < 8; j++) {
        Match4Element *elementToAdd = [[gameGrid objectAtIndex:thisIndex.x] objectAtIndex:j];
        if (![elementsToRemove containsObject:elementToAdd]) [elementsToRemove addObject:elementToAdd];
    }
}


- (void) selectElement:(Match4Element *)thisElement
{
    if (firstTouchedElement == nil) {
        firstTouchedElement = [thisElement retain];
        [elementManager selectElement:thisElement];
    } else {
        [elementManager deselectElement:firstTouchedElement];
        if ([self element:thisElement.isIndex isNeighbourToElement:firstTouchedElement.isIndex]) {
            [self swapElement:thisElement withElement:firstTouchedElement];
        }
        [firstTouchedElement release];
        firstTouchedElement = nil;
    }
}

- (BOOL)element:(CGPoint)firstIndex isNeighbourToElement:(CGPoint)secondIndex
{
    
}

- (void)swapElement:(Match4Element *)firstElement withElement:(Match4Element *)secondElement
{
    canTouch = NO;
    
    NSMutableArray *firstElementRow = [gameGrid objectAtIndex:firstElement.isIndex.x];
    NSMutableArray *secondElementRow = [gameGrid objectAtIndex:secondElement.isIndex.x];
    [firstElementRow replaceObjectAtIndex:firstElement.isIndex.y withObject:secondElement];
    [secondElementRow replaceObjectAtIndex:secondElement.isIndex.y withObject:firstElement];
    
    CGPoint temp = firstElement.isIndex;
    firstElement.isIndex = secondElement.isIndex;
    secondElement.isIndex = temp;
    
    [firstTouchedElement release];
    firstTouchedElement = nil;
    
    CCMoveTo *move1 = [CCMoveTo actionWithDuration:0.3 position:[self positionFromIndex:firstElement.isIndex]];
    CCMoveTo *move2 = [CCMoveTo actionWithDuration:0.3 position:[self positionFromIndex:secondElement.isIndex]];
    id bothMove = [CCSpawn actionOne:[CCTargetedAction actionWithTarget:firstElement action:move1]
                                 two:[CCTargetedAction actionWithTarget:secondElement action:move2]];
    [self runAction:
     [CCSequence actions:
      bothMove,
      [CCCallBlock actionWithBlock:^{
         isMoveValid = NO;
         [self searchPatterns];
         if (!isMoveValid) [self swapBackElement:firstElement withElement:secondElement];
     }],
      nil]];
}

- (void)swapBackElement:(Match4Element *)firstElement withElement:(Match4Element *)secondElement
{
    canTouch = NO;
    
    NSMutableArray *firstElementRow = [gameGrid objectAtIndex:firstElement.isIndex.x];
    NSMutableArray *secondElementRow = [gameGrid objectAtIndex:secondElement.isIndex.x];
    [firstElementRow replaceObjectAtIndex:firstElement.isIndex.y withObject:secondElement];
    [secondElementRow replaceObjectAtIndex:secondElement.isIndex.y withObject:firstElement];
    
    CGPoint temp = firstElement.isIndex;
    firstElement.isIndex = secondElement.isIndex;
    secondElement.isIndex = temp;
    
    [firstTouchedElement release];
    firstTouchedElement = nil;
    
    CCMoveTo *move1 = [CCMoveTo actionWithDuration:0.3 position:[self positionFromIndex:firstElement.isIndex]];
    CCMoveTo *move2 = [CCMoveTo actionWithDuration:0.3 position:[self positionFromIndex:secondElement.isIndex]];
    id bothMove = [CCSpawn actionOne:[CCTargetedAction actionWithTarget:firstElement action:move1]
                                 two:[CCTargetedAction actionWithTarget:secondElement action:move2]];
    [self runAction:
     [CCSequence actions:
      bothMove,
      [CCCallBlock actionWithBlock:^{
         canTouch = YES;
     }],
      nil]];

}

#pragma TOUCH ACTIONS
-(BOOL) TouchBegan:(CGPoint)local
{
    if (canTouch) {
        CGPoint index = [self indexFromPosition:local];
        Match4Element *thisElement = [[gameGrid objectAtIndex:index.x] objectAtIndex:index.y];
        [self selectElement:thisElement];
    }
    return YES;
}

-(void) TouchMoved:(CGPoint)local
{
    if (canTouch) {
        CGPoint index = [self indexFromPosition:local];
        Match4Element *thisElement = [[gameGrid objectAtIndex:index.x] objectAtIndex:index.y];
        if (thisElement == firstTouchedElement) {
            float dx = thisElement.position.x - local.x;
            float dy = thisElement.position.y - local.y;
            if ( abs(dx)>20 || abs(dy)>20 ) {
                CGPoint direction;
                if (abs(dx) > abs(dy)) {
                    if (dx > 0) direction = CGPointMake(-1, 0);
                    else direction = CGPointMake(1, 0);
                }
                else {
                    if (dy > 0) direction = CGPointMake(0, 1);
                    else direction = CGPointMake(0, -1);
                }
                CGPoint possibleIndex = CGPointMake(thisElement.isIndex.x + direction.x, thisElement.isIndex.y + direction.y);
                if ( possibleIndex.x > -1 && possibleIndex.x < 8 && possibleIndex.y > -1 && possibleIndex.y < 8) {
                    Match4Element *otherElement = [[gameGrid objectAtIndex:index.x] objectAtIndex:index.y];
                    if ([self element:thisElement.isIndex isNeighbourToElement:otherElement.isIndex]) {
                        [self swapElement:thisElement withElement:otherElement];
                        [elementManager deselectElement:thisElement];
                    }
                }
            }
        }
    }
}


-(void) registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0  swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    CGPoint local = [self convertToNodeSpace:touchLocation];
    
    return [self TouchBegan:local];
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [self convertToNodeSpace:touchLocation];
    
    return [self TouchMoved:local];
}

#pragma ELIMINATION & ANIMATION

- (void)eraseElements {
    canTouch = NO;
    /*if (isShockwave) {
        [self shockWaveFromCenter:shockwaveCentre];
        shockwaveCentre = CGPointMake(-1, -1);
    }*/
    
    //didSuperEliminate = NO;
    
    for (Match4Element *thisElement in elementsToRemove) {
        if (![elementsToSkip containsObject:thisElement]) {
            [[gameGrid objectAtIndex:thisElement.isIndex.x] removeObject:thisElement];
            //if (thisElement.isShifter) noOfShifterMatches++;
            //if (thisElement.isOfType == 9) noOfCorruptedCleared++;
            if (thisElement.isToExplode) [elementManager animExplodeElement:thisElement withDelay:(float) ((arc4random() % 5) / 10.0)];
            //else if (thisElement.isLShapeCorner )[elementManager animLShapeOnElement:thisElement];
            /*else if (thisElement.isSuperEliminated) {
                [ElementManager animSuperEliminateElement:thisElement];
                didSuperEliminate = YES;
            }*/
            else [elementManager animHideElement:thisElement withDelay:0];
        }
    }
    [elementsToRemove removeAllObjects];
    [elementsToSkip removeAllObjects];
    
    //if (isCascading) noOfCascadingMatches++;
    
    /*if (noOfNormalMatches > 0) [viewController.soundController playSound:@"SymbolElimination"];
    if (noOfMatchesOf4 > 0) [viewController.soundController playSound:@"4Match"];
    if (noOfMatchesOf4Explosion > 0) [viewController.soundController playSound:@"4Match_Explosion"];
    if (noOfMatchesOf5 > 0) [viewController.soundController playSound:@"5Match"];
    if (noOfLShapedMatches > 0) [viewController.soundController playSound:@"LMatch"];
    if (noOfSuperEliminated > 0) [viewController.soundController playSound:@"SuperSymbolElimination"];*/
    
    pointsToAdd = 0;
    /*
    pointsToAdd = noOfNormalMatches * viewController.valuesManager.kPointsStandardMatch +
    noOfMatchesOf4 * viewController.valuesManager.kPoints4Match +
    noOfMatchesOf4Explosion * viewController.valuesManager.kPoints4MatchExplosion +
    noOfMatchesOf5 * viewController.valuesManager.kPoints5Match +
    noOfLShapedMatches * viewController.valuesManager.kPointsLMatch +
    noOfSuperEliminated * viewController.valuesManager.kPointsSuperEliminatedElement +
    noOfShifterMatches * viewController.valuesManager.kPointsShifterMatch +
    noOfCorruptedCleared * viewController.valuesManager.kPointsCorruptedEliminated +
    noOfCascadingMatches * viewController.valuesManager.kPointsCascadingMatch +
    noOfDoubleMatches * viewController.valuesManager.kPointsDoubleMatch;*/
    
    //[gameController.timeView addPoints:pointsToAdd];
    //[self clearPoints];
    
    //isCascading = YES;
    
    [self refillGameField];
}

- (void)refillGameField {
    for (int i = 0; i < 8; i++) {
        int m = [[gameGrid objectAtIndex:i] count];
        if (m < 8) {
            for (int j = 0; j < 8 - m; j++) {
                Match4Element *newElement = [elementManager randomElementWithMaxType:7];
                newElement.position = [self positionFromIndex:CGPointMake(i, 8+j)];
                newElement.isIndex = CGPointMake(i, 8+j);
                [self addChild:newElement];
                [[gameGrid objectAtIndex:i] addObject:newElement];
            }
        }
    }
    [self repositionAllElements];
    
    [self resetLocalStore];
}

- (void)repositionAllElements {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            Match4Element *thisElement = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (!(thisElement.isIndex.y == j)) {
                thisElement.dropSize = thisElement.isIndex.y - j;
                thisElement.isIndex = CGPointMake(i, j);
                [elementsToMove addObject:thisElement];
            }
        }
    }
    float a;
    //if (didSuperEliminate) a = 1.15;
    //else a = 0.15;
    a = 0.15;
    int k = 0;
    int l = 0;
    float delay;
    float time;
    BOOL didFindSpot;
    for (int i = 0; i < 8; i++) {
        k = 0;
        didFindSpot = NO;
        for (int j = 0; j < 8; j++) {
            Match4Element *thisElement = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if ([elementsToMove containsObject:thisElement]) {
                if (!didFindSpot) l++;
                didFindSpot = YES;
                time = sqrtf(0.05 * thisElement.dropSize);
                delay = k * 0.1 + l * 0.05 + a;
                [UIView animateWithDuration:time
                                      delay:delay
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     thisElement.position = [self positionFromIndex:thisElement.isIndex];
                                 }
                                 completion:^(BOOL finished) {
                                     [elementsToMove removeObject:thisElement];
                                     [self checkIfAllElementsRepositioned];
                                 }];
                k++;
            }
        }
    }
}

- (void)checkIfAllElementsRepositioned {
    if ([elementsToMove count] == 0) [self searchPatterns];
}


#pragma OTHERS

- (CGPoint)positionFromIndex:(CGPoint)thisIndex
{
    return CGPointMake(20 + (thisIndex.x*40), 320 - (20 + (thisIndex.y*40)));
}

- (CGPoint)indexFromPosition:(CGPoint)thisPosition
{
    return CGPointMake(((int)thisPosition.x-20+16)/40, ((int)320-thisPosition.y-20+16)/40);
}

@end
