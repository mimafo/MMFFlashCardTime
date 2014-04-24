//
//  MMFDataController.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFDataController.h"
#import <CoreData/CoreData.h>

@interface MMFDataController()

@property (nonatomic, readwrite, strong) NSManagedObjectContext *primaryMOC;

@end

@implementation MMFDataController

#pragma mark - Class methods
+(instancetype)sharedDataManager
{
    static MMFDataController *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [[MMFDataController alloc] init];
        
    });
    
    return _manager;
}

#pragma mark - Initializers
-(id)init
{
    self = [super init];
    if (self) {
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MMFFlashCardTime" withExtension:@"momd"];
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSError *error = nil;
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                                                     configuration:nil
                                                               URL:[self _sqliteStoreURL]
                                                           options:nil
                                                             error:&error];
        if (store == nil) {
            NSLog(@"Error creating the persistent store: %@", [error localizedDescription]);
            return nil;
        }
        
        self.primaryMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.primaryMOC.persistentStoreCoordinator = psc;
        
    }
    return self;
}

#pragma mark - Public methods
-(NSManagedObjectContext *)createChildContext
{
    NSManagedObjectContext *childMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    childMOC.parentContext = self.primaryMOC;
    return childMOC;
}

#pragma mark - Private methods
-(NSManagedObject *)_fetchSingleObjectWithMOC:(NSManagedObjectContext *)moc withRequest:(NSFetchRequest *)request create:(BOOL)createFlag
{
    NSParameterAssert(moc);
    NSParameterAssert(request);
    NSManagedObject *object;
    
    //Execute the fetch request
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (error)  {
        NSLog(@"The following error occurred: %@",[error localizedDescription]);
    } else if ([results count] == 1) {
        
        //The expected number of results (1) were found
        object = results[0];
        
    } else {
        if (createFlag) {
            object = [NSEntityDescription insertNewObjectForEntityForName:request.entityName inManagedObjectContext:moc];
        } else {
            NSLog(@"Unexpected results, the fetch returned %lu items",(unsigned long)[results count]);
        }
    }
    
    return object;
    
}

-(NSArray *)_fetchCollectionWithMOC:(NSManagedObjectContext *)moc withRequest:(NSFetchRequest *)request
{
    NSParameterAssert(moc);
    NSParameterAssert(request);
    
    //Execute the fetch request
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (error)  {
        NSLog(@"The following error occurred: %@",[error localizedDescription]);
    }
    
    return results;
    
}

- (NSURL *)_documentDirectoryURL;
{
    NSArray *candidates = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSAssert([candidates count] > 0, @"Expected at least one document directory");
    return candidates[0];
}

- (NSURL *)_sqliteStoreURL;
{
    return [[self _documentDirectoryURL] URLByAppendingPathComponent:@"MMFFlashCardTime.sqlite"];
}

@end
