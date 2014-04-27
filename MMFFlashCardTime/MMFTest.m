//
//  MMFTest.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/27/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFTest.h"

@implementation MMFTest

#pragma mark - Class methods
+(instancetype)sharedTest;
{
    static MMFTest *_test = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _test = [MMFTest new];
        
    });
    return _test;
}
+(void)setTestOperation:(OperationType)operation
{
    MMFTest *test = [MMFTest sharedTest];
    test.operation = operation;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.correctCount = 0;
        self.startDate = [NSDate new];
        self.durationMinutes = 5;
    }
    return self;
}

-(id)initWithOperation:(OperationType)operation
{
    MMFTest *test = [self init];
    test.operation = operation;
    return test;
}

-(BOOL)isTimeExpired
{
    BOOL expired = NO;
    NSDate *now = [NSDate new];
    NSDate *expireDate = [self.startDate dateByAddingTimeInterval:(self.durationMinutes * 60)];
    
    NSComparisonResult result = [now compare:expireDate];
    
    if (result != NSOrderedAscending) {
        expired = YES;
    }
    
    
    return expired;
}

@end
