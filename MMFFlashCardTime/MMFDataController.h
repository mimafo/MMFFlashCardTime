//
//  MMFDataController.h
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMFDataController : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *primaryMOC;

//Method to create a child worker context
-(NSManagedObjectContext *)createChildContext;

//Methods for fetching data (managed objects)


//Class method for MMFDataManager singleton
+(instancetype)sharedDataManager;

@end
