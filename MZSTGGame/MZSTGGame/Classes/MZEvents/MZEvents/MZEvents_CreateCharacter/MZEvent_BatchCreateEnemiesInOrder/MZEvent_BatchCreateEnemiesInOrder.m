#import "MZEvent_BatchCreateEnemiesInOrder.h"
#import "MZEventsHeader.h"
#import "MZSTGCharactersHeader.h"
#import "MZCharacterTypeStrings.h"
#import "MZUtilitiesHeader.h"
#import "MZLevelComponentsHeader.h"

@interface MZEvent_BatchCreateEnemiesInOrder (Private)
-(void)_initTempDictionariesArrayForSpawnEnemies;
-(void)_doCreateEnemyEvent;
-(void)_createAllEnemies;
-(NSDictionary *)_getCreateEnemyDictionaryWithDictionary:(NSDictionary *)nsDictionary;
@end

#pragma mark

@implementation MZEvent_BatchCreateEnemiesInOrder

#pragma mark - override

-(void)dealloc
{
    [enemyName release];
    [tempDictionariesArrayForSpawnEnemies release];
    [createEnemyDictionary release];
    
    [super dealloc];
}

-(void)enable
{
    [super enable];

    if( intervalSpawnTime == 0 ) [self _createAllEnemies];
    nextSpawnTime = 0;
}

@end

#pragma mark

@implementation MZEvent_BatchCreateEnemiesInOrder (Protected)

#pragma mark - override

-(void)_initWithDictionary:(NSDictionary *)dictionary
{
    numberOfEnemies = [dictionary[@"numberOfEnemies"] intValue];
    intervalSpawnTime = [dictionary[@"intervalSpawnTime"] floatValue];
    position = CGPointFromString( dictionary[@"position"] );
    changePositionEverySpawn = CGPointFromString( dictionary[@"changePositionEverySpawn"] );
    enemyName = [dictionary[@"enemyName"] retain];
    
    createEnemyDictionary = [[self _getCreateEnemyDictionaryWithDictionary: dictionary] retain];
    
    [self _initTempDictionariesArrayForSpawnEnemies];
}

-(void)_checkActiveCondition
{
    [super _checkActiveCondition];
    
    if( currentSpawnCount >= numberOfEnemies )
        [self disable];
}

-(void)_update
{
    if( self.lifeTimeCount >= nextSpawnTime && currentSpawnCount < numberOfEnemies )
    {
        [self _doCreateEnemyEvent];
        
        nextSpawnTime += intervalSpawnTime;
    }
}

@end

#pragma mark

@implementation MZEvent_BatchCreateEnemiesInOrder (Private)

#pragma mark - methods

-(void)_initTempDictionariesArrayForSpawnEnemies
{
    tempDictionariesArrayForSpawnEnemies = [[NSMutableArray alloc]  initWithCapacity: 1];
    
    CGPoint currentPosition = CGPointZero;
    for( int i = 0; i < numberOfEnemies; i++ )
    {        
        NSMutableDictionary *tempDictionaryForSpawnEnemy = [NSMutableDictionary dictionaryWithDictionary: createEnemyDictionary];
        [tempDictionaryForSpawnEnemy setObject: NSStringFromCGPoint( currentPosition ) forKey: @"position"];
        
        currentPosition = CGPointMake( currentPosition.x + changePositionEverySpawn.x, 
                                      currentPosition.y + changePositionEverySpawn.y );
        
        [tempDictionariesArrayForSpawnEnemies addObject: tempDictionaryForSpawnEnemy];
    }
}

-(void)_doCreateEnemyEvent
{
    NSDictionary *tempDictionaryForSpawnEnemy = [tempDictionariesArrayForSpawnEnemies objectAtIndex: currentSpawnCount];
    
    MZEvent *createEnemy = [[MZEventsFactory sharedEventsFactory] eventByDcitionary: tempDictionaryForSpawnEnemy];
    createEnemy.position = mzpAdd( position, createEnemy.position );
    [levelComponentsRef.eventsExecutor executeEvent: createEnemy];
    
    currentSpawnCount++;
}

-(void)_createAllEnemies
{
    for( int i = 0; i < numberOfEnemies; i++ )
        [self _doCreateEnemyEvent];
    
    [self disable];
}

-(NSDictionary *)_getCreateEnemyDictionaryWithDictionary:(NSDictionary *)nsDictionary
{
    numberOfEnemies = [nsDictionary[@"numberOfEnemies"] intValue];
    intervalSpawnTime = [nsDictionary[@"intervalSpawnTime"] floatValue];
    position = CGPointFromString( nsDictionary[@"position"] );
    changePositionEverySpawn = CGPointFromString( nsDictionary[@"changePositionEverySpawn"] );
    enemyName = [nsDictionary[@"enemyName"] retain];
    
    NSMutableDictionary *_createEnemyDictionary = [NSMutableDictionary dictionaryWithDictionary: nsDictionary];
    [_createEnemyDictionary removeObjectForKey: @"numberOfEnemies"];
    [_createEnemyDictionary removeObjectForKey: @"intervalSpawnTime"];
    [_createEnemyDictionary removeObjectForKey: @"position"];
    [_createEnemyDictionary removeObjectForKey: @"changePositionEverySpawn"];
    [_createEnemyDictionary removeObjectForKey: @"type"];
    
    NSString *createType = [_createEnemyDictionary objectForKey: @"createType"];
    MZAssert( createType, @"createType can not be nil" );
    [_createEnemyDictionary setObject: createType forKey: @"type"];
    [_createEnemyDictionary removeObjectForKey: @"createType"];
    
    return _createEnemyDictionary;
}

@end