//
//  MMFAppDelegate.h
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
