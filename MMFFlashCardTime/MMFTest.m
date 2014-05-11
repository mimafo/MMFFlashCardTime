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
+(void)initializeTestWithOperation:(OperationType)operation
{
    MMFTest *test = [MMFTest sharedTest];
    test.operation = operation;
    test.startDate = [NSDate new];
}

-(id)init
{
    self = [super init];
    if (self) {
        self.correctCount = 0;
        self.startDate = [NSDate new];
        self.durationMinutes = 2;
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

-(NSString *)timeRemaining
{
    NSString *remaining = @"";
    
    double secondsInAMinute = 60;
    
    NSDate *now = [NSDate new];
    NSTimeInterval interval = [now timeIntervalSinceDate:self.startDate];
    NSInteger seconds = (self.durationMinutes * secondsInAMinute) - (long)interval;
    
    
    NSInteger minutes = seconds / secondsInAMinute;
    NSInteger remainderSeconds =  seconds - (secondsInAMinute * minutes);
    
    remaining = [NSString stringWithFormat:@"%ld:%02ld",(long)minutes, (long)remainderSeconds];
    return remaining;
}

-(NSString *)rank
{
    NSString *rank;
    
    float correctPerMin = self.correctCount / self.durationMinutes;
    
    if (correctPerMin < 5) {
        rank = @"Need more practice";
    } else if (correctPerMin < 10) {
        rank = @"Pretty good";
    } else if (correctPerMin < 20) {
        rank = @"Good job!";
    } else if (correctPerMin < 30) {
        rank = @"Very Good job!";
    } else {
        rank = @"Excellent!";
    }
    
    return rank;
}

@end
