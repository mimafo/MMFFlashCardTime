//
//  MMFTest.h
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/27/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMFProblem.h"

@interface MMFTest : NSObject

@property (nonatomic, assign) OperationType operation;
@property (nonatomic, assign) NSUInteger correctCount;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) NSUInteger durationMinutes;

-(id)initWithOperation:(OperationType)operation;
-(BOOL)isTimeExpired;

+(instancetype)sharedTest;
+(void)setTestOperation:(OperationType)operation;

@end
