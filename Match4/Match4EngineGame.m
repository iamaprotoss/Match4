//
//  Match4EngineGame.m
//  Match4
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

//
//  Match4EngineTime.m
//  Match4
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 zhenwei. All rights reserved.
//

#import "Match4EngineGame.h"
#import "Match4TimeView.h"

@implementation Match4EngineGame

@synthesize gameGrid;
@synthesize firstTouchedElement;
@synthesize canTouch;

- (id)initWithDictionary:(NSMutableDictionary *)thisDict
{
    if (self = [super init]) {
        isTutorial = NO;
        isVisible = NO;
        isNuclearBomb = NO;
        isExplosion = NO;
        isColorElimination = NO;
        levelOfCascading = 0;
        //levelOfChain = 0;
        gameGrid = [[NSMutableArray alloc] init];
        //hintGrid = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i ++) {
            [gameGrid addObject:[NSMutableArray array]];
        //    [hintGrid addObject:[NSMutableArray array]];
        }
        elementsToRemove = [[NSMutableSet alloc] init];
        elementsToMove = [[NSMutableSet alloc] init];
        elementsToSkip = [[NSMutableSet alloc] init];
        partitionOfGrid = [[NSMutableArray alloc] init];
        partitionOfHintGrid = [[NSMutableArray alloc] init];
        
        initialSuperiorIndex[0] = -1;
        initialSuperiorIndex[1] = -1;
        initialSuperiorIndex[2] = -1;
        special = [thisDict copy];
        if ([[special objectForKey:@"Initial Superior Element"] boolValue]) {
            int p1 = arc4random()%64;
            int p2 = (p1+1+arc4random()%63)%64;
            int p3 = (p2+1+arc4random()%62)%64;
            if (p3 == p1) {
                p3 = (p3 + 1)%64;
            }
            initialSuperiorIndex[0] = p1;
            initialSuperiorIndex[1] = p2;
            initialSuperiorIndex[2] = p3;
        }
        
        hintAnim = [[CCSprite alloc] init];
        [self addChild:hintAnim];
        hintAnimationFrames = [[CCAnimation alloc] init];
        for (int i = 0; i < 10; i ++) {
            [hintAnimationFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"t2_0%i.png", i]];
        }
        for (int i = 10; i < 20; i ++) {
            [hintAnimationFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"t2_%i.png", i]];
        }
        hintAnimationFrames.delayPerUnit = 0.1;
        
        elementManager = [GameController sharedController].elementManager;
        labelManager = [GameController sharedController].labelManager;
        firstTouchedElement = nil;
        [self populateGameField];
        [self setTouchEnabled:YES];
        //NSLog(@"%i, %i, %i, %i, %i, %i, %i, %i, %i, %i", [GameController sharedController].valuesManager.kPointsStandardEliminate, [GameController sharedController].valuesManager.kPointsSuperiorSingle, [GameController sharedController].valuesManager.kPointsSuperiorSingleOther, [GameController sharedController].valuesManager.kPointsSuperiorDouble, [GameController sharedController].valuesManager.kPointsSuperiorDoubleOther, [GameController sharedController].valuesManager.kPointsSuperiorTriple, [GameController sharedController].valuesManager.kPointsSuperiorTripleOther, [GameController sharedController].valuesManager.kPointsSuperiorAll, [GameController sharedController].valuesManager.kPointsSuperiorAllOther, [GameController sharedController].valuesManager.kPointsBonusForCascading);
    }
    return self;
}

#pragma mark GRID MANAGEMENT

- (void) reshuffle
{
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            [elementManager animHideElement:[[gameGrid objectAtIndex:i] objectAtIndex:j] withDelay:0];
        }
    }
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            Match4Element *elementToReplace = [elementManager randomElementWithMaxType:5];
            elementToReplace.isIndex = CGPointMake(i, j);
            elementToReplace.position = [self positionFromIndex:elementToReplace.isIndex];
            [[gameGrid objectAtIndex:i] replaceObjectAtIndex:j withObject:elementToReplace];
            [self checkIfElementNotMakingPattern:elementToReplace];
            elementToReplace.opacity = 0.001;
            [self addChild:elementToReplace];
        }
    }
}

- (void) resetLocalStore
{
    
}

- (void) resetGame
{
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            Match4Element *element = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            [elementManager animHideElement:element withDelay:0];
        }
        [[gameGrid objectAtIndex:i] removeAllObjects];
    }
    [elementsToRemove removeAllObjects];
    [elementsToSkip removeAllObjects];
    [elementsToMove removeAllObjects];
    [self populateGameField];
}

- (void) populateGameField
{
    //NSMutableArray *gameGridArray = [GameController sharedController].localStore.currentGame.gameGrid;
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            BOOL isElementLoaded = NO;
            Match4Element *element = nil;
            ///////////////////////
            // First check local store //
            ///////////////////////
            // Then
            if (!element) {
                element = [elementManager randomElementWithMaxType:5];
                if (i*8+j==initialSuperiorIndex[0] || i*8+j==initialSuperiorIndex[1] || i*8+j==initialSuperiorIndex[2]) {
                    [elementManager turnToExplosiveElement:element];
                }
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
    //int typeToSkip = thisElement.isOfType;
    BOOL hasToChange = NO;
    if ([self findConnectedComponent:thisElement] >= 4) {
        hasToChange = YES;
    }
    if (hasToChange) {
        int newType;
        if (x > 0 && y > 0) {
            int typeDown = [[[gameGrid objectAtIndex:x] objectAtIndex:y-1] isOfType];
            int typeLeft = [[[gameGrid objectAtIndex:x-1] objectAtIndex:y] isOfType];
            if (typeDown == typeLeft) {
                int k = (arc4random() % 4) + 1;
                newType = (thisElement.isOfType + k) % 5;
            } else {
                int k = (arc4random() % 3) + 1;
                newType = (typeDown + k) % 5;
                if (newType == typeLeft) {
                    newType = (newType + 1) % 5;
                }
            }
        } else {
            int k = (arc4random() % 4) + 1;
            newType = (thisElement.isOfType + k) % 5;
        }
        
        [elementManager shiftElement:thisElement toType:newType];
        if (x*8+y==initialSuperiorIndex[0] || x*8+y==initialSuperiorIndex[1] || x*8+y==initialSuperiorIndex[2]) {
            [elementManager turnToExplosiveElement:thisElement];
        }
    }
}


#pragma mark FIND PARTITION
- (void) clearPartition
{
    for (NSMutableArray *array in partitionOfGrid) {
        [array removeAllObjects];
        [array release];
    }
    [partitionOfGrid removeAllObjects];
}

- (void) findPartition
{
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            group[i][j] = -1;
        }
    }
    int count = 0;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (group[i][j] == -1) {
                int groupId = count;
                [self dfSearch:CGPointMake(i, j) type:[[[gameGrid objectAtIndex:i] objectAtIndex:j] isOfType] Id:groupId];
                count ++;
            }
        }
    }
    
    [self clearPartition];
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (group[i][j] >= [partitionOfGrid count]) {
                NSMutableArray *component = [[NSMutableArray alloc] init];
                [partitionOfGrid addObject:component];
                [component addObject:[[gameGrid objectAtIndex:i] objectAtIndex:j]];
            } else {
                [[partitionOfGrid objectAtIndex:group[i][j]] addObject:[[gameGrid objectAtIndex:i] objectAtIndex:j]];
            }
        }
    }
}


-(void) dfSearch:(CGPoint)index type:(int)thisType Id:(int)thisGroupId
{
    int x = index.x;
    int y = index.y;
    group[x][y] = thisGroupId;
    x = index.x - 1;
    if (x>=0 && group[x][y]==-1 && [[[gameGrid objectAtIndex:x] objectAtIndex:y] isOfType] == thisType) {
        [self dfSearch:CGPointMake(x, y) type:thisType Id:thisGroupId];
    }
    x = index.x + 1;
    if (x<8 && group[x][y]==-1 && [[[gameGrid objectAtIndex:x] objectAtIndex:y] isOfType] == thisType) {
        [self dfSearch:CGPointMake(x, y) type:thisType Id:thisGroupId];
    }
    x = index.x;
    y = index.y - 1;
    if (y>=0 && group[x][y]==-1 && [[[gameGrid objectAtIndex:x] objectAtIndex:y] isOfType] == thisType) {
        [self dfSearch:CGPointMake(x, y) type:thisType Id:thisGroupId];
    }
    y = index.y + 1;
    if (y<8 && group[x][y]==-1 && [[[gameGrid objectAtIndex:x] objectAtIndex:y] isOfType] == thisType) {
        [self dfSearch:CGPointMake(x, y) type:thisType Id:thisGroupId];
    }
}

- (int) findConnectedComponent:(Match4Element *)thisElement
{
    // breadth first search
    NSMutableSet *connectedComponent = [[NSMutableSet alloc] init];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    [list addObject:thisElement];
    [connectedComponent addObject:thisElement];
    while ([list count] > 0) {
        Match4Element *currentElement = [[list firstObject] retain];
        [list removeObject:currentElement];
        int x = currentElement.isIndex.x;
        int y = currentElement.isIndex.y;
        Match4Element *elementToCheck = [[Match4Element alloc] init];
        elementToCheck = nil;
        if ([gameGrid count] > x+1 && [[gameGrid objectAtIndex:x+1] count] > y) {
            elementToCheck = [[gameGrid objectAtIndex:x+1] objectAtIndex:y];
        }
        if (elementToCheck) {
            if (elementToCheck.isOfType == thisElement.isOfType && ![connectedComponent containsObject:elementToCheck]) {
                [list addObject:elementToCheck ];
                [connectedComponent addObject:elementToCheck];
            }
            elementToCheck = nil;
        }
        if ([gameGrid count] > x-1 && [[gameGrid objectAtIndex:x-1] count] > y) {
            elementToCheck = [[gameGrid objectAtIndex:x-1] objectAtIndex:y];
        }
        if (elementToCheck) {
            if (elementToCheck.isOfType == thisElement.isOfType && ![connectedComponent containsObject:elementToCheck]) {
                [list addObject:elementToCheck];
                [connectedComponent addObject:elementToCheck];
            }
            elementToCheck = nil;
        }
        if ([gameGrid count] > x && [[gameGrid objectAtIndex:x] count] > y+1) {
            elementToCheck = [[gameGrid objectAtIndex:x] objectAtIndex:y+1];
        }
        if (elementToCheck) {
            if (elementToCheck.isOfType == thisElement.isOfType && ![connectedComponent containsObject:elementToCheck]) {
                [list addObject:elementToCheck];
                [connectedComponent addObject:elementToCheck];
            }
            elementToCheck = nil;
        }
        if ([gameGrid count] > x && [[gameGrid objectAtIndex:x] count] > y-1) {
            elementToCheck = [[gameGrid objectAtIndex:x] objectAtIndex:y-1];
        }
        if (elementToCheck) {
            if (elementToCheck.isOfType == thisElement.isOfType && ![connectedComponent containsObject:elementToCheck]) {
                [list addObject:elementToCheck];
                [connectedComponent addObject:elementToCheck];
            }
            elementToCheck = nil;
        }
        [currentElement release];
        currentElement = nil;
        [elementToCheck release];
    }
    int count = [connectedComponent count];
    [connectedComponent removeAllObjects];
    [connectedComponent release];
    connectedComponent = nil;
    [list release];
    connectedComponent = nil;
    return count;
}


- (void) clearPartitionForHintGrid
{
    for (NSMutableArray *array in partitionOfHintGrid) {
        [array removeAllObjects];
        [array release];
    }
    [partitionOfHintGrid removeAllObjects];
}

- (void) findPartitionForHintGrid
{
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            hintGroup[i][j] = -1;
        }
    }
    int count = 0;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (hintGroup[i][j] == -1) {
                int groupId = count;
                [self dfSearchForHintGrid:CGPointMake(i, j) type:[[[hintGrid objectAtIndex:i] objectAtIndex:j] isOfType] Id:groupId];
                count ++;
            }
        }
    }
    
    [self clearPartitionForHintGrid];
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (hintGroup[i][j] >= [partitionOfHintGrid count]) {
                NSMutableArray *component = [[NSMutableArray alloc] init];
                [partitionOfHintGrid addObject:component];
                [component addObject:[[hintGrid objectAtIndex:i] objectAtIndex:j]];
            } else {
                [[partitionOfHintGrid objectAtIndex:hintGroup[i][j]] addObject:[[hintGrid objectAtIndex:i] objectAtIndex:j]];
            }
        }
    }
}

-(void) dfSearchForHintGrid:(CGPoint)index type:(int)thisType Id:(int)thisGroupId
{
    int x = index.x;
    int y = index.y;
    hintGroup[x][y] = thisGroupId;
    x = index.x - 1;
    if (x>=0 && hintGroup[x][y]==-1 && [[[hintGrid objectAtIndex:x] objectAtIndex:y] isOfType] == thisType) {
        [self dfSearchForHintGrid:CGPointMake(x, y) type:thisType Id:thisGroupId];
    }
    x = index.x + 1;
    if (x<8 && hintGroup[x][y]==-1 && [[[hintGrid objectAtIndex:x] objectAtIndex:y] isOfType] == thisType) {
        [self dfSearchForHintGrid:CGPointMake(x, y) type:thisType Id:thisGroupId];
    }
    x = index.x;
    y = index.y - 1;
    if (y>=0 && hintGroup[x][y]==-1 && [[[hintGrid objectAtIndex:x] objectAtIndex:y] isOfType] == thisType) {
        [self dfSearchForHintGrid:CGPointMake(x, y) type:thisType Id:thisGroupId];
    }
    y = index.y + 1;
    if (y<8 && hintGroup[x][y]==-1 && [[[hintGrid objectAtIndex:x] objectAtIndex:y] isOfType] == thisType) {
        [self dfSearchForHintGrid:CGPointMake(x, y) type:thisType Id:thisGroupId];
    }
}

- (int) findConnectedComponentForHintGrid:(Match4Element *)thisElement
{
    // breadth first search
    NSMutableSet *connectedComponent = [[NSMutableSet alloc] init];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    [list addObject:thisElement];
    [connectedComponent addObject:thisElement];
    while ([list count] > 0) {
        Match4Element *currentElement = [[list firstObject] retain];
        [list removeObject:currentElement];
        int x = currentElement.isIndex.x;
        int y = currentElement.isIndex.y;
        Match4Element *elementToCheck = [[Match4Element alloc] init];
        elementToCheck = nil;
        if ([hintGrid count] > x+1 && [[hintGrid objectAtIndex:x+1] count] > y) {
            elementToCheck = [[hintGrid objectAtIndex:x+1] objectAtIndex:y];
        }
        if (elementToCheck) {
            if (elementToCheck.isOfType == thisElement.isOfType && ![connectedComponent containsObject:elementToCheck]) {
                [list addObject:elementToCheck ];
                [connectedComponent addObject:elementToCheck];
            }
            elementToCheck = nil;
        }
        if ([hintGrid count] > x-1 && [[hintGrid objectAtIndex:x-1] count] > y) {
            elementToCheck = [[hintGrid objectAtIndex:x-1] objectAtIndex:y];
        }
        if (elementToCheck) {
            if (elementToCheck.isOfType == thisElement.isOfType && ![connectedComponent containsObject:elementToCheck]) {
                [list addObject:elementToCheck];
                [connectedComponent addObject:elementToCheck];
            }
            elementToCheck = nil;
        }
        if ([hintGrid count] > x && [[hintGrid objectAtIndex:x] count] > y+1) {
            elementToCheck = [[hintGrid objectAtIndex:x] objectAtIndex:y+1];
        }
        if (elementToCheck) {
            if (elementToCheck.isOfType == thisElement.isOfType && ![connectedComponent containsObject:elementToCheck]) {
                [list addObject:elementToCheck];
                [connectedComponent addObject:elementToCheck];
            }
            elementToCheck = nil;
        }
        if ([hintGrid count] > x && [[hintGrid objectAtIndex:x] count] > y-1) {
            elementToCheck = [[hintGrid objectAtIndex:x] objectAtIndex:y-1];
        }
        if (elementToCheck) {
            if (elementToCheck.isOfType == thisElement.isOfType && ![connectedComponent containsObject:elementToCheck]) {
                [list addObject:elementToCheck];
                [connectedComponent addObject:elementToCheck];
            }
            elementToCheck = nil;
        }
        [currentElement release];
        currentElement = nil;
        [elementToCheck release];
    }
    int count = [connectedComponent count];
    [connectedComponent removeAllObjects];
    [connectedComponent release];
    connectedComponent = nil;
    [list release];
    connectedComponent = nil;
    return count;
}



#pragma mark SEARCH PATTERNS
- (CGPoint)getHint
{
    //BOOL possiblePatternFound = NO;
    CGPoint hint = CGPointMake(-1, -1);
    hintGrid = [[gameGrid copy] autorelease];
    
    [self findPartitionForHintGrid];
    
    for (NSMutableArray *array in partitionOfHintGrid) {
        if ([array count] == 3) {
            int type = ((Match4Element*)[array lastObject]).isOfType;
            for (Match4Element *element in array) {
                int x = element.isIndex.x;
                int y = element.isIndex.y;
                if (y+2<8) {
                    Match4Element *elementToCheck = [[hintGrid objectAtIndex:x] objectAtIndex:y+2];
                    if (elementToCheck.isOfType == type && ![array containsObject:elementToCheck]) {
                        return CGPointMake(x, y+2);
                    }
                }
                if (x+1<8 && y+1<8) {
                    Match4Element *elementToCheck = [[hintGrid objectAtIndex:x+1] objectAtIndex:y+1];
                    if (elementToCheck.isOfType == type && ![array containsObject:elementToCheck]) {
                        return CGPointMake(x+1, y+1);
                    }
                }
                if (x+2<8) {
                    Match4Element *elementToCheck = [[hintGrid objectAtIndex:x+2] objectAtIndex:y];
                    if (elementToCheck.isOfType == type && ![array containsObject:elementToCheck]) {
                        return CGPointMake(x+2, y);
                    }
                }
                if (x+1<8 && y-1>=0) {
                    Match4Element *elementToCheck = [[hintGrid objectAtIndex:x+1] objectAtIndex:y-1];
                    if (elementToCheck.isOfType == type && ![array containsObject:elementToCheck]) {
                        return CGPointMake(x+1, y-1);
                    }
                }
                if (y-2>=0) {
                    Match4Element *elementToCheck = [[hintGrid objectAtIndex:x] objectAtIndex:y-2];
                    if (elementToCheck.isOfType == type && ![array containsObject:elementToCheck]) {
                        return CGPointMake(x, y-2);
                    }
                }
                if (x-1>=0 && y-1>=0) {
                    Match4Element *elementToCheck = [[hintGrid objectAtIndex:x-1] objectAtIndex:y-1];
                    if (elementToCheck.isOfType == type && ![array containsObject:elementToCheck]) {
                        return CGPointMake(x-1, y-1);
                    }
                }
                if (x-2>=0) {
                    Match4Element *elementToCheck = [[hintGrid objectAtIndex:x-2] objectAtIndex:y];
                    if (elementToCheck.isOfType == type && ![array containsObject:elementToCheck]) {
                        return CGPointMake(x-2, y);
                    }
                }
                if (x-1>=0 && y+1<8) {
                    Match4Element *elementToCheck = [[hintGrid objectAtIndex:x-1] objectAtIndex:y+1];
                    if (elementToCheck.isOfType == type && ![array containsObject:elementToCheck]) {
                        return CGPointMake(x-1, y+1);
                    }
                }
            }
        } else if ([array count] == 2) {
            int type = ((Match4Element*)[array lastObject]).isOfType;
            for (Match4Element *element in array) {
                int x = element.isIndex.x;
                int y = element.isIndex.y;
                if (x-1>=0 && y+2<8) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x] objectAtIndex:y+2];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x-1, y+1);
                    }
                }
                if (x-2>=0 && y+1<8) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x-2] objectAtIndex:y];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x-1, y+1);
                    }
                }
                if (x+1<8 && y+2<8) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x] objectAtIndex:y+2];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x+1, y+1);
                    }
                }
                if (x+2<0 && y+1<8) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x+2] objectAtIndex:y];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x+1, y+1);
                    }
                }
                if (x+1<8 && y-2>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y-1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x] objectAtIndex:y-2];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x+1, y-1);
                    }
                }
                if (x+2<8 && y-1>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y-1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x+2] objectAtIndex:y];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x+1, y-1);
                    }
                }
                if (x-1>=0 && y-2>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y-1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x] objectAtIndex:y-2];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x-1, y-1);
                    }
                }
                if (x-2>=0 && y-1>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y-1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x-2] objectAtIndex:y];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x-1, y-1);
                    }
                }
                if (x-1>=0 && x+1<8 && y+1<8) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y+1];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x-1, y+1);
                    }
                }
                if (x+1<8 && y+1<8 && y-1>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y-1];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x+1, y+1);
                    }
                }
                if (x-1>=0 && x+1<8 && y-1>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y-1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y-1];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x-1, y-1);
                    }
                }
                if (x-1>=0 && y+1<8 && y-1>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y-1];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type) {
                        return CGPointMake(x-1, y+1);
                    }
                }
            }
        } else if ([array count] == 1) {
            int type = ((Match4Element*)[array lastObject]).isOfType;
            for (Match4Element *element in array) {
                int x = element.isIndex.x;
                int y = element.isIndex.y;
                if (x-1>=0 && y+2<8 && x+1<8) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x] objectAtIndex:y+2];
                    Match4Element *elementToCheck3 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y+1];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type && elementToCheck3.isOfType == type) {
                        return CGPointMake(x, y);
                    }
                }
                if (y+1<8 && x+2<8 && y-1>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y+1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x+2] objectAtIndex:y];
                    Match4Element *elementToCheck3 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y-1];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type && elementToCheck3.isOfType == type) {
                        return CGPointMake(x, y);
                    }
                }
                if (x+1<8 && y-2>=0 && x-1>=0) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x+1] objectAtIndex:y-1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x] objectAtIndex:y-2];
                    Match4Element *elementToCheck3 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y-1];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type && elementToCheck3.isOfType == type) {
                        return CGPointMake(x, y);
                    }
                }
                if (y-1>=0 && x-2>=0 && y+1<8) {
                    Match4Element *elementToCheck1 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y-1];
                    Match4Element *elementToCheck2 = [[hintGrid objectAtIndex:x-2] objectAtIndex:y];
                    Match4Element *elementToCheck3 = [[hintGrid objectAtIndex:x-1] objectAtIndex:y+1];
                    if (elementToCheck1.isOfType == type && elementToCheck2.isOfType == type && elementToCheck3.isOfType == type) {
                        return CGPointMake(x, y);
                    }
                }
            }
        }
    }

    return hint;
}

-(void)showHint:(CGPoint)hintIndex
{
    [hintAnim stopAllActions];
    [hintAnim removeFromParent];
    [hintAnim runAction:
     [CCRepeatForever actionWithAction:
      [CCAnimate actionWithAnimation:hintAnimationFrames]]];
    hintAnim.position = [self positionFromIndex:hintIndex];
    [self addChild:hintAnim];
}


- (void)eliminateNormal:(NSMutableArray *)thisComponent
{
    int count = 0;
    //noOfStandardEliminate += [thisComponent count];
    int indexToTurnSuperior;
    if (isTutorial) {
        indexToTurnSuperior = 0;
    } else {
        indexToTurnSuperior = arc4random()%[thisComponent count];
    }
    for (int i = 0; i < [thisComponent count]; i++) {
        Match4Element *element = [thisComponent objectAtIndex:i];
        if (i == indexToTurnSuperior) {
            [elementsToSkip addObject:element];
            [elementManager turnToExplosiveElement:element];
            count ++;
        } else {
            if (![elementsToRemove containsObject:element]) {
                [elementsToRemove addObject:element];
                count ++;
            }
        }
    }
    ((Match4Element*)[thisComponent objectAtIndex:(indexToTurnSuperior+1)%[thisComponent count]]).pointsToAdd = count * [GameController sharedController].valuesManager.kPointsStandardEliminate;
}

- (void)chainEliminateSuperior:(Match4Element *)thisElement levelOfChain:(int)levelOfChain;
{
    thisElement.isToExplode = YES;
    if (![elementsToRemove containsObject:thisElement]) {
        [elementsToRemove addObject:thisElement];
    }
    int neighborCount = [self eliminateNeighboursOfElementAtIndex:thisElement.isIndex levelOfChain:levelOfChain];
    thisElement.pointsToAdd = [GameController sharedController].valuesManager.kPointsSuperiorSingle * (levelOfChain+1) + neighborCount * [GameController sharedController].valuesManager.kPointsSuperiorSingleOther;
    thisElement.animDelay = 0.2f * levelOfChain;
    NSLog(@"level of chain: %i", levelOfChain);
}

- (void)eliminateSuperSingle:(NSMutableArray *)thisComponent
{
    int count = 0;
    //noOfSuperiorSingle ++;
    for (Match4Element *element in thisComponent) {
        if (![elementsToRemove containsObject:element]) {
            [elementsToRemove addObject:element];
            count ++;
        }
        if (element.isExplosive == YES) {
            element.isOfSuperSingle = YES;
            element.isToExplode = YES;
            int neighborCount = [self eliminateNeighboursOfElementAtIndex:element.isIndex levelOfChain:0];
            element.pointsToAdd = [GameController sharedController].valuesManager.kPointsSuperiorSingle + (count+neighborCount) * [GameController sharedController].valuesManager.kPointsSuperiorSingleOther;
        }
    }
}

- (void)eliminateSuperDouble:(NSMutableArray *)thisComponent
{
    int count = 0;
    for (Match4Element *element in thisComponent) {
        if (![elementsToRemove containsObject:element]) {
            [elementsToRemove addObject:element];
            count ++;
        }
        if (element.isExplosive == YES) {
            element.isOfSuperDouble = YES;
        }
    }
    int sameColorCount = [self eliminateAllElementsOfType:[[thisComponent lastObject] isOfType]];
    for (Match4Element *element in thisComponent) {
        if (element.isOfSuperDouble) {
            element.pointsToAdd = [GameController sharedController].valuesManager.kPointsSuperiorDouble + (count+sameColorCount) * [GameController sharedController].valuesManager.kPointsSuperiorDoubleOther / 2;
        }
    }
}

- (void)eliminateSuperTriple:(NSMutableArray *)thisComponent
{
    //noOfSuperiorTriple ++;
    int count = 0;
    int countTriple = 0;
    for (Match4Element *element in thisComponent) {
        if (![elementsToRemove containsObject:element]) {
            [elementsToRemove addObject:element];
            count ++;
        }
        if (element.isExplosive == YES) {
            element.isOfSuperTriple = YES;
            element.isLShapeCorner = YES;
            countTriple ++;
        }
    }
    for (Match4Element *element in thisComponent) {
        if (element.isOfSuperTriple) {
            int otherCount = [self eliminateAllElementsInLineWithElementAtIndex:element.isIndex];
            element.pointsToAdd = [GameController sharedController].valuesManager.kPointsSuperiorTriple + otherCount * [GameController sharedController].valuesManager.kPointsSuperiorTripleOther + count * [GameController sharedController].valuesManager.kPointsSuperiorTripleOther / countTriple;
        }
    }
}

- (void)eliminateAll:(NSMutableArray *)thisComponent;
{
    isNuclearBomb = YES;
}

- (void)searchPatterns {
    [self findPartition];
    
    for (NSMutableArray *component in partitionOfGrid) {
        if ([component count] >= 4) {
            int numOfSuperior = 0;
            for (Match4Element *elementToCheck in component) {
                if (elementToCheck.isExplosive) {
                    numOfSuperior ++;
                }
            }
            /*if (numOfSuperior >= 4) {
                noOfSuperiorAll += [component count];
                [self eliminateAll:component];
            } else*/
            if (numOfSuperior >= 3) {
                noOfSuperiorTriple += [component count];
                isLShapeElimination = YES;
                [self eliminateSuperTriple:component];
            } else if (numOfSuperior == 2) {
                noOfSuperiorDouble += [component count];
                isColorElimination = YES;
                [self eliminateSuperDouble:component];
            } else if (numOfSuperior == 1) {
                noOfSuperiorSingle += [component count];
                isExplosion = YES;
                [self eliminateSuperSingle:component];
            } else {
                noOfStandardEliminate += [component count];
                [self eliminateNormal:component];
            }
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
        isCascading = NO;
        levelOfCascading = 0;
        canTouch = YES;
        if (isTutorial) {
            [self addMask];
        }
    }
    //isDoubleMatch = NO;
}


- (int)eliminateNeighboursOfElementAtIndex:(CGPoint)thisIndex levelOfChain:(int)levelOfChain
{
    int count = 0;
    int m;
    int n;
    for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
            m = thisIndex.x + i;
            n = thisIndex.y + j;
            if ((m > -1) & (m < 8) & (n > -1) & (n < 8)) {
                Match4Element *elementToAdd = [[gameGrid objectAtIndex:m] objectAtIndex:n];
                if (![elementsToRemove containsObject:elementToAdd]) {
                    if (elementToAdd.isExplosive) {
                        [self chainEliminateSuperior:elementToAdd levelOfChain:levelOfChain+1];
                    } else {
                        [elementsToRemove addObject:elementToAdd];
                        elementToAdd.animDelay = 0.2*levelOfChain;
                        count ++;
                    }
                }
            }
        }
    }
    return count;
    
}

- (int)eliminateAllElementsOfType:(int)thisType {
    int count = 0;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            Match4Element *elementToCheck = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (elementToCheck.isOfType == thisType && ![elementsToRemove containsObject:elementToCheck]) {
                if (elementToCheck.isExplosive) {
                    [self chainEliminateSuperior:elementToCheck levelOfChain:1];
                } else {
                    //elementToCheck.isSuperEliminated = YES;
                    elementToCheck.isToColorEliminate = YES;
                    elementToCheck.animDelay = 0.3;
                    [elementsToRemove addObject:elementToCheck];
                    //noOfSuperiorDoubleOther ++;
                    count ++;
                }
            }
        }
    }
    //[self eraseElements];
    return count;
}

- (int)eliminateAllElementsInLineWithElementAtIndex:(CGPoint)thisIndex {
    int count = 0;
    for (int i = 0; i < 8; i++) {
        Match4Element *elementToAdd = [[gameGrid objectAtIndex:i] objectAtIndex:thisIndex.y];
        if (![elementsToRemove containsObject:elementToAdd]) {
            if (elementToAdd.isExplosive) {
                [self chainEliminateSuperior:elementToAdd levelOfChain:1];
            } else {
                [elementsToRemove addObject:elementToAdd];
                count ++;
            }
        }
    }
    for (int j = 0; j < 8; j++) {
        Match4Element *elementToAdd = [[gameGrid objectAtIndex:thisIndex.x] objectAtIndex:j];
        if (![elementsToRemove containsObject:elementToAdd]) {
            if (elementToAdd.isExplosive) {
                [self chainEliminateSuperior:elementToAdd levelOfChain:1];
            } else {
                [elementsToRemove addObject:elementToAdd];
                count ++;
            }
        }
    }
    return count;
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
    BOOL isNeighbour = NO;
    if ((abs((firstIndex.x - secondIndex.x)) == 1) & (firstIndex.y == secondIndex.y)) isNeighbour = YES;
    else if ((abs((firstIndex.y - secondIndex.y)) == 1) & (firstIndex.x == secondIndex.x)) isNeighbour = YES;
    return isNeighbour;
}

- (void)swapElement:(Match4Element *)firstElement withElement:(Match4Element *)secondElement
{
    if (isTutorial) {
        [self removeMask];
    }
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

#pragma mark TOUCH ACTIONS
-(BOOL) TouchBegan:(CGPoint)local
{
    if ((isTutorial && [self isValidMoveForTutorial:local]) || !isTutorial) {
        [hintAnim stopAllActions];
        [hintAnim removeFromParent];
        //[hintAnim release];
        
        if (canTouch) {
            CGPoint index = [self indexFromPosition:local];
            if (index.x >= 0 && index.x < 8 && index.y >= 0 && index.y < 8) {
                Match4Element *thisElement = [[gameGrid objectAtIndex:index.x] objectAtIndex:index.y];
                [self selectElement:thisElement];
            }
        }
    }
    return YES;
}

-(void) TouchMoved:(CGPoint)local
{
    if (canTouch) {
        CGPoint index = [self indexFromPosition:local];
        Match4Element *thisElement = [[gameGrid objectAtIndex:index.x] objectAtIndex:index.y];
        if (thisElement == firstTouchedElement) {
            float dx = local.x - thisElement.position.x;
            float dy = local.y - thisElement.position.y;
            if ( abs(dx)>10 || abs(dy)>10 ) {
                CGPoint direction;
                if (abs(dx) > abs(dy)) {
                    if (dx > 0) direction = CGPointMake(1, 0);
                    else direction = CGPointMake(-1, 0);
                }
                else {
                    if (dy > 0) direction = CGPointMake(0, 1);
                    else direction = CGPointMake(0, -1);
                }
                CGPoint possibleIndex = CGPointMake(thisElement.isIndex.x + direction.x, thisElement.isIndex.y + direction.y);
                if ( possibleIndex.x > -1 && possibleIndex.x < 8 && possibleIndex.y > -1 && possibleIndex.y < 8) {
                    Match4Element *otherElement = [[gameGrid objectAtIndex:possibleIndex.x] objectAtIndex:possibleIndex.y];
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

#pragma mark ELIMINATION & ANIMATION

- (void)eraseElements {
    canTouch = NO;
    if (isCascading) levelOfCascading++;
    
    /*if (isShockwave) {
        [self shockWaveFromCenter:shockwaveCentre];
        shockwaveCentre = CGPointMake(-1, -1);
    }*/
    
    //didSuperEliminate = NO;
    totalPointsToAdd = 0;
    for (Match4Element *thisElement in elementsToRemove) {
        if (![elementsToSkip containsObject:thisElement]) {
            [[gameGrid objectAtIndex:thisElement.isIndex.x] removeObject:thisElement];
            noOfNormal ++;
            //if (thisElement.isShifter) noOfShifterMatches++;
            //if (thisElement.isOfType == 9) noOfCorruptedCleared++;
            if (thisElement.isLShapeCorner) {
                [elementManager animLShapeOnElement:thisElement];
            } else if (thisElement.isToColorEliminate) {
                [elementManager animColorEliminateElement:thisElement withDelay:thisElement.animDelay];
             //didSuperEliminate = YES;
            } else if (thisElement.isToExplode) {
                [elementManager animExplodeElement:thisElement withDelay:thisElement.animDelay];
            } else {
                [elementManager animHideElement:thisElement withDelay:thisElement.animDelay];
            }
            if (thisElement.pointsToAdd != 0) {
                thisElement.pointsToAdd += pow(levelOfCascading, 2) * [GameController sharedController].valuesManager.kPointsBonusForCascading;
                NSLog(@"level of cascading %i", levelOfCascading);
                Match4Label *label = [Match4Label labelWithString:[NSString stringWithFormat:@"%i",thisElement.pointsToAdd] fontSize:24];
                label.position = [self positionFromIndex:thisElement.isIndex];
                //label.color = ccc3(255, 0, 0);
                [self addChild:label];
                [labelManager animGlitch:label WithDelay:thisElement.animDelay andDoRepeat:NO];
                totalPointsToAdd += thisElement.pointsToAdd;
            }

        }
    }
    [elementsToRemove removeAllObjects];
    [elementsToSkip removeAllObjects];
    
    /*if (noOfNormalMatches > 0) [viewController.soundController playSound:@"SymbolElimination"];
     if (noOfMatchesOf4 > 0) [viewController.soundController playSound:@"4Match"];
     if (noOfMatchesOf4Explosion > 0) [viewController.soundController playSound:@"4Match_Explosion"];
     if (noOfMatchesOf5 > 0) [viewController.soundController playSound:@"5Match"];
     if (noOfLShapedMatches > 0) [viewController.soundController playSound:@"LMatch"];
     if (noOfSuperEliminated > 0) [viewController.soundController playSound:@"SuperSymbolElimination"];*/
    
    /*totalPointsToAdd =
    noOfStandardEliminate * [GameController sharedController].valuesManager.kPointsStandardEliminate +noOfSuperiorSingle * [GameController sharedController].valuesManager.kPointsSuperiorSingle + noOfSuperiorDouble * [GameController sharedController].valuesManager.kPointsSuperiorDouble + noOfSuperiorTriple * [GameController sharedController].valuesManager.kPointsSuperiorTriple + noOfSuperiorAll * [GameController sharedController].valuesManager.kPointsSuperiorAll + noOfNormal * [GameController sharedController].valuesManager.kPointsNormal + pow(levelOfCascading, 2) * 100;*/
    
    if (isTutorial) {
        [[GameController sharedController].tutorialView addPoints:totalPointsToAdd];
    } else {
        [[GameController sharedController].timeView addPoints:totalPointsToAdd];
    }
    
    [self clearPoints];
    
    isCascading = YES;
    
    float delayTime;
    if (isLShapeElimination) {
        delayTime = 0.6;
    } else if (isColorElimination) {
        delayTime = 0.5;
    } else if (isExplosion) {
        delayTime = 0.3;
    } else {
        delayTime = 0;
    }
    [self runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:delayTime],
      [CCCallBlock actionWithBlock:^{
         isLShapeElimination = NO;
         isColorElimination = NO;
         isExplosion = NO;
         [self refillGameField];
     }],
      nil]];
}

- (void)refillGameField {
    if (isTutorial) {
        [self refillGameFieldForTutorial];
        return;
    }
    for (int i = 0; i < 8; i++) {
        int m = [[gameGrid objectAtIndex:i] count];
        if (m < 8) {
            for (int j = 0; j < 8 - m; j++) {
                Match4Element *newElement = [elementManager randomElementWithMaxType:5];
                if ([[special objectForKey:@"Random Superior Element"] boolValue] && arc4random()%100<5) {
                    [elementManager turnToExplosiveElement:newElement];
                }
                newElement.position = [self positionFromIndex:CGPointMake(i, j+8)];
                newElement.isIndex = CGPointMake(i, j+8);
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
                [thisElement runAction:
                 [CCSequence actions:
                  [CCDelayTime actionWithDuration:delay],
                  [CCMoveTo actionWithDuration:time position:[self positionFromIndex:thisElement.isIndex]],
                  [CCCallBlock actionWithBlock:^{
                     [elementsToMove removeObject:thisElement];
                     [self checkIfAllElementsRepositioned];
                 }],
                  nil
                  ]];
                
                k++;
            }
        }
    }
}

- (void)checkIfAllElementsRepositioned {
    if ([elementsToMove count] == 0) [self searchPatterns];
}

- (void)shockWaveFromCenter:(CGPoint)thisCenter {
    isShockWave = NO;
    
    Match4Element *elementToGlitch;
    float delay;
    float m = thisCenter.x;
    float n = thisCenter.y;
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            elementToGlitch = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (![elementsToRemove containsObject:elementToGlitch]) {
                delay = sqrtf((i - m)*(i - m) + (j - n)*(j - n)) / 15;
                //[elementManager animGlitchSymbol:elementToGlitch withDelay:delay];
            }
        }
    }
    
}

#pragma mark OTHERS

- (CGPoint)positionFromIndex:(CGPoint)thisIndex
{
    return CGPointMake(20 + (thisIndex.x*40), 20 + (thisIndex.y*40));
}

- (CGPoint)indexFromPosition:(CGPoint)thisPosition
{
    return CGPointMake(((int)thisPosition.x-20+16)/40, ((int)thisPosition.y-20+16)/40);
}

- (void)clearPoints;
{
    noOfStandardEliminate = 0;
    noOfSuperiorSingle = 0;
    noOfSuperiorSingleOther = 0;
    noOfSuperiorDouble = 0;
    noOfSuperiorDoubleOther = 0;
    noOfSuperiorTriple = 0;
    noOfSuperiorTripleOther = 0;
    noOfSuperiorAll = 0;
    noOfSuperiorAllOther = 0;
    noOfNormal = 0;
}

#pragma mark TUTORIAL
- (id)initWithTutorial
{
    if (self = [super init]) {
        isTutorial = YES;
        isVisible = NO;
        isNuclearBomb = NO;
        isExplosion = NO;
        levelOfCascading = 0;
        //levelOfChain = 0;
        gameGrid = [[NSMutableArray alloc] init];
        //hintGrid = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i ++) {
            [gameGrid addObject:[NSMutableArray array]];
            //    [hintGrid addObject:[NSMutableArray array]];
        }
        elementsToRemove = [[NSMutableSet alloc] init];
        elementsToMove = [[NSMutableSet alloc] init];
        elementsToSkip = [[NSMutableSet alloc] init];
        partitionOfGrid = [[NSMutableArray alloc] init];
        partitionOfHintGrid = [[NSMutableArray alloc] init];
        
        elementManager = [GameController sharedController].elementManager;
        labelManager = [GameController sharedController].labelManager;
        firstTouchedElement = nil;
        
        hintAnim = [[CCSprite alloc] init];
        [self addChild:hintAnim];
        hintAnimationFrames = [[CCAnimation alloc] init];
        for (int i = 0; i < 10; i ++) {
            [hintAnimationFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"T_0%i.png", i]];
        }
        for (int i = 10; i < 48; i ++) {
            [hintAnimationFrames addSpriteFrameWithFilename:[NSString stringWithFormat:@"T_%i.png", i]];
        }
        hintAnimationFrames.delayPerUnit = 0.05;
        
        int config[8][8] =
           {{2,0,0,2,0,3,3,1},
            {2,1,2,3,3,2,1,4},
            {3,2,2,4,1,2,4,1},
            {3,0,1,0,0,0,2,1},
            {1,0,2,4,4,1,4,0},
            {1,0,3,2,0,1,2,0},
            {4,3,4,1,2,0,3,1},
            {3,2,0,1,1,0,1,1}};
        
        int table[8][8];
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
                table[i][j] = config[7-j][i];
            }
        }
        
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
                Match4Element *element = [elementManager ElementWithType:table[i][j]];
                element.isIndex = CGPointMake(i, j);
                element.position = [self positionFromIndex:element.isIndex];
                [[gameGrid objectAtIndex:i] addObject:element];
                element.opacity = 0.001;
                [self addChild:element];
            }
        }
        [elementManager turnToExplosiveElement:[[gameGrid objectAtIndex:0] objectAtIndex:0]];
        [elementManager turnToExplosiveElement:[[gameGrid objectAtIndex:0] objectAtIndex:4]];
        [elementManager turnToExplosiveElement:[[gameGrid objectAtIndex:0] objectAtIndex:5]];
        [elementManager turnToExplosiveElement:[[gameGrid objectAtIndex:6] objectAtIndex:6]];
        [elementManager turnToExplosiveElement:[[gameGrid objectAtIndex:7] objectAtIndex:7]];
        
        tutorialStep = 0;
        
        canTouch = YES;
        
        [self setTouchEnabled:YES];
        
        [self addMask];
    }
    return self;
}

- (void)refillGameFieldForTutorial
{
    if (tutorialStep == 0) {
        Match4Element *newElement1 = [elementManager ElementWithType:2];
        newElement1.position = [self positionFromIndex:CGPointMake(4, 8)];
        newElement1.isIndex = CGPointMake(4, 8);
        [self addChild:newElement1];
        [[gameGrid objectAtIndex:4] addObject:newElement1];
        
        Match4Element *newElement2 = [elementManager ElementWithType:1];
        newElement2.position = [self positionFromIndex:CGPointMake(4, 9)];
        newElement2.isIndex = CGPointMake(4, 9);
        [self addChild:newElement2];
        [[gameGrid objectAtIndex:4] addObject:newElement2];
        
        Match4Element *newElement3 = [elementManager ElementWithType:1];
        newElement3.position = [self positionFromIndex:CGPointMake(5, 8)];
        newElement3.isIndex = CGPointMake(5, 8);
        [self addChild:newElement3];
        [[gameGrid objectAtIndex:5] addObject:newElement3];
        
        tutorialStep = 1;
        
    } else if (tutorialStep == 1) {
        Match4Element *newElement1 = [elementManager ElementWithType:0];
        newElement1.position = [self positionFromIndex:CGPointMake(1, 8)];
        newElement1.isIndex = CGPointMake(1, 8);
        [self addChild:newElement1];
        [[gameGrid objectAtIndex:1] addObject:newElement1];
        
        Match4Element *newElement2 = [elementManager ElementWithType:1];
        newElement2.position = [self positionFromIndex:CGPointMake(1, 9)];
        newElement2.isIndex = CGPointMake(1, 9);
        [self addChild:newElement2];
        [[gameGrid objectAtIndex:1] addObject:newElement2];

        Match4Element *newElement3 = [elementManager ElementWithType:2];
        newElement3.position = [self positionFromIndex:CGPointMake(1, 10)];
        newElement3.isIndex = CGPointMake(1, 10);
        [self addChild:newElement3];
        [[gameGrid objectAtIndex:1] addObject:newElement3];
        
        Match4Element *newElement4 = [elementManager ElementWithType:3];
        newElement4.position = [self positionFromIndex:CGPointMake(1, 11)];
        newElement4.isIndex = CGPointMake(1, 11);
        [self addChild:newElement4];
        [[gameGrid objectAtIndex:1] addObject:newElement4];
        
        Match4Element *newElement5 = [elementManager ElementWithType:4];
        newElement5.position = [self positionFromIndex:CGPointMake(2, 8)];
        newElement5.isIndex = CGPointMake(2, 8);
        [self addChild:newElement5];
        [[gameGrid objectAtIndex:2] addObject:newElement5];
        
        Match4Element *newElement6 = [elementManager ElementWithType:0];
        newElement6.position = [self positionFromIndex:CGPointMake(2, 9)];
        newElement6.isIndex = CGPointMake(2, 9);
        [self addChild:newElement6];
        [[gameGrid objectAtIndex:2] addObject:newElement6];
        
        Match4Element *newElement7 = [elementManager ElementWithType:4];
        newElement7.position = [self positionFromIndex:CGPointMake(2, 10)];
        newElement7.isIndex = CGPointMake(2, 10);
        [self addChild:newElement7];
        [[gameGrid objectAtIndex:2] addObject:newElement7];
        
        Match4Element *newElement8 = [elementManager ElementWithType:2];
        newElement8.position = [self positionFromIndex:CGPointMake(3, 8)];
        newElement8.isIndex = CGPointMake(3, 8);
        [self addChild:newElement8];
        [[gameGrid objectAtIndex:3] addObject:newElement8];
        
        Match4Element *newElement9 = [elementManager ElementWithType:3];
        newElement9.position = [self positionFromIndex:CGPointMake(3, 9)];
        newElement9.isIndex = CGPointMake(3, 9);
        [self addChild:newElement9];
        [[gameGrid objectAtIndex:3] addObject:newElement9];
        
        Match4Element *newElement10 = [elementManager ElementWithType:1];
        newElement10.position = [self positionFromIndex:CGPointMake(3, 10)];
        newElement10.isIndex = CGPointMake(3, 10);
        [self addChild:newElement10];
        [[gameGrid objectAtIndex:3] addObject:newElement10];
        
        tutorialStep = 2;
    
    } else if(tutorialStep == 2) {
        Match4Element *newElement1 = [elementManager ElementWithType:0];
        newElement1.position = [self positionFromIndex:CGPointMake(0, 8)];
        newElement1.isIndex = CGPointMake(0, 8);
        [self addChild:newElement1];
        [[gameGrid objectAtIndex:0] addObject:newElement1];
        
        Match4Element *newElement2 = [elementManager ElementWithType:1];
        newElement2.position = [self positionFromIndex:CGPointMake(0, 9)];
        newElement2.isIndex = CGPointMake(0, 9);
        [self addChild:newElement2];
        [[gameGrid objectAtIndex:0] addObject:newElement2];
        
        Match4Element *newElement3 = [elementManager ElementWithType:2];
        newElement3.position = [self positionFromIndex:CGPointMake(1, 8)];
        newElement3.isIndex = CGPointMake(1, 8);
        [self addChild:newElement3];
        [[gameGrid objectAtIndex:1] addObject:newElement3];
        
        Match4Element *newElement4 = [elementManager ElementWithType:3];
        newElement4.position = [self positionFromIndex:CGPointMake(1, 9)];
        newElement4.isIndex = CGPointMake(1, 9);
        [self addChild:newElement4];
        [[gameGrid objectAtIndex:1] addObject:newElement4];
        
        Match4Element *newElement5 = [elementManager ElementWithType:4];
        newElement5.position = [self positionFromIndex:CGPointMake(3, 8)];
        newElement5.isIndex = CGPointMake(3, 8);
        [self addChild:newElement5];
        [[gameGrid objectAtIndex:3] addObject:newElement5];
        
        Match4Element *newElement6 = [elementManager ElementWithType:0];
        newElement6.position = [self positionFromIndex:CGPointMake(3, 9)];
        newElement6.isIndex = CGPointMake(3, 9);
        [self addChild:newElement6];
        [[gameGrid objectAtIndex:3] addObject:newElement6];
        
        Match4Element *newElement7 = [elementManager ElementWithType:4];
        newElement7.position = [self positionFromIndex:CGPointMake(3, 10)];
        newElement7.isIndex = CGPointMake(3, 10);
        [self addChild:newElement7];
        [[gameGrid objectAtIndex:3] addObject:newElement7];
        
        Match4Element *newElement8 = [elementManager ElementWithType:2];
        newElement8.position = [self positionFromIndex:CGPointMake(4, 8)];
        newElement8.isIndex = CGPointMake(4, 8);
        [self addChild:newElement8];
        [[gameGrid objectAtIndex:4] addObject:newElement8];
        
        Match4Element *newElement9 = [elementManager ElementWithType:3];
        newElement9.position = [self positionFromIndex:CGPointMake(4, 9)];
        newElement9.isIndex = CGPointMake(4, 9);
        [self addChild:newElement9];
        [[gameGrid objectAtIndex:4] addObject:newElement9];
        
        Match4Element *newElement10 = [elementManager ElementWithType:1];
        newElement10.position = [self positionFromIndex:CGPointMake(4, 10)];
        newElement10.isIndex = CGPointMake(4, 10);
        [self addChild:newElement10];
        [[gameGrid objectAtIndex:4] addObject:newElement10];
        
        Match4Element *newElement11 = [elementManager ElementWithType:0];
        newElement11.position = [self positionFromIndex:CGPointMake(5, 8)];
        newElement11.isIndex = CGPointMake(5, 8);
        [self addChild:newElement11];
        [[gameGrid objectAtIndex:5] addObject:newElement11];
        
        Match4Element *newElement12 = [elementManager ElementWithType:1];
        newElement12.position = [self positionFromIndex:CGPointMake(5, 9)];
        newElement12.isIndex = CGPointMake(5, 9);
        [self addChild:newElement12];
        [[gameGrid objectAtIndex:5] addObject:newElement12];
        
        Match4Element *newElement13 = [elementManager ElementWithType:2];
        newElement13.position = [self positionFromIndex:CGPointMake(5, 10)];
        newElement13.isIndex = CGPointMake(5, 10);
        [self addChild:newElement13];
        [[gameGrid objectAtIndex:5] addObject:newElement13];
        
        Match4Element *newElement14 = [elementManager ElementWithType:3];
        newElement14.position = [self positionFromIndex:CGPointMake(6, 8)];
        newElement14.isIndex = CGPointMake(6, 8);
        [self addChild:newElement14];
        [[gameGrid objectAtIndex:6] addObject:newElement14];
        
        Match4Element *newElement15 = [elementManager ElementWithType:4];
        newElement15.position = [self positionFromIndex:CGPointMake(7, 8)];
        newElement15.isIndex = CGPointMake(7, 8);
        [self addChild:newElement15];
        [[gameGrid objectAtIndex:7] addObject:newElement15];
        
        Match4Element *newElement16 = [elementManager ElementWithType:0];
        newElement16.position = [self positionFromIndex:CGPointMake(7, 9)];
        newElement16.isIndex = CGPointMake(7, 9);
        [self addChild:newElement16];
        [[gameGrid objectAtIndex:7] addObject:newElement16];
        
        Match4Element *newElement17 = [elementManager ElementWithType:4];
        newElement17.position = [self positionFromIndex:CGPointMake(7, 10)];
        newElement17.isIndex = CGPointMake(7, 10);
        [self addChild:newElement17];
        [[gameGrid objectAtIndex:7] addObject:newElement17];
        
        Match4Element *newElement18 = [elementManager ElementWithType:2];
        newElement18.position = [self positionFromIndex:CGPointMake(7, 11)];
        newElement18.isIndex = CGPointMake(7, 11);
        [self addChild:newElement18];
        [[gameGrid objectAtIndex:7] addObject:newElement18];
        
        Match4Element *newElement19 = [elementManager ElementWithType:3];
        newElement19.position = [self positionFromIndex:CGPointMake(7, 12)];
        newElement19.isIndex = CGPointMake(7, 12);
        [self addChild:newElement19];
        [[gameGrid objectAtIndex:7] addObject:newElement19];
        
        Match4Element *newElement20 = [elementManager ElementWithType:1];
        newElement20.position = [self positionFromIndex:CGPointMake(7, 13)];
        newElement20.isIndex = CGPointMake(7, 13);
        [self addChild:newElement20];
        [[gameGrid objectAtIndex:7] addObject:newElement20];
        
        tutorialStep = 3;
        
    } else if (tutorialStep == 3) {
        //isTutorial = NO;
    }
    
    //if (isTutorial) {
        [self repositionAllElements];
        
        [self resetLocalStore];

    //}
}

- (void) addMask {
    if (tutorialStep == 0) {
        mask1 = [CCSprite spriteWithFile:@"hint_board_1.png"];
        mask1.position = ccp(160, 160);
        [self addChild:mask1 z:100];
    } else if (tutorialStep == 1) {
        mask2 = [CCSprite spriteWithFile:@"hint_board_2.png"];
        mask2.position = ccp(160, 160);
        [self addChild:mask2 z:100];
    } else if (tutorialStep == 2) {
        mask3 = [CCSprite spriteWithFile:@"hint_board_3.png"];
        mask3.position = ccp(160, 160);
        [self addChild:mask3 z:100];
    } else if (tutorialStep == 3) {
        mask4 = [CCSprite spriteWithFile:@"hint_board_4.png"];
        mask4.position = ccp(160, 160);
        [self addChild:mask4 z:100];
    }
}

-(void) removeMask
{
    if (tutorialStep == 0) {
        [mask1 removeFromParent];
        mask1 = nil;
    } else if (tutorialStep == 1) {
        [mask2 removeFromParent];
        mask2 = nil;
    } else if (tutorialStep == 2) {
        [mask3 removeFromParent];
        mask3 = nil;
    } else if (tutorialStep == 3) {
        [mask4 removeFromParent];
        mask4 = nil;
        isTutorial = NO;
    }
}

-(BOOL) isValidMoveForTutorial:(CGPoint)local
{
    CGPoint index = [self indexFromPosition:local];
    if (tutorialStep == 0) {
        if (index.x==4 && index.y<=3 && index.y>=2) {
            return YES;
        } else {
            return NO;
        }
    } else if (tutorialStep == 1) {
        if (index.x<=3 && index.x>=2 && index.y==4) {
            return YES;
        } else {
            return NO;
        }
    } else if (tutorialStep == 2) {
        if (index.x<=7 && index.x>=6 && index.y==6) {
            return YES;
        } else {
            return NO;
        }
    } else if (tutorialStep == 3) {
        if (index.x<=1 && index.x>=0 && index.y==1) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}


@end
