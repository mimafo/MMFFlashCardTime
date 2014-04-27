//
//  MMFProblem.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/26/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFProblem.h"

@implementation MMFProblem


#define MAX_NUMBER 20;
#define MIN_NUMBER 0;

#pragma mark - Initializers

-(id)init
{
    self = [super init];
    if (self) {
        //Addition is the default operation
        self.operation = kAddition;
    }
    
    return self;
    
}

#pragma mark - Public methods

-(NSString *)operationString {
    NSString *opString = @"+";
    
    if (self.operation == kSubtraction) {
        opString = @"-";
    } else if (self.operation == kMultiplication) {
        opString = @"X";
    }
    
    return opString;
    
}

-(NSUInteger)answer
{
    NSUInteger theAnswer = 0;
    
    if (self.operation == kAddition) {
        theAnswer = self.firstNumber + self.secondNumber;
    } else if (self.operation == kSubtraction) {
        theAnswer = self.firstNumber - self.secondNumber;
    } else if (self.operation == kMultiplication) {
        theAnswer = self.firstNumber * self.secondNumber;
    }
    
    return theAnswer;
}

#pragma mark - Class methods

+(instancetype)createRandomProblemWithOperation:(OperationType)operation
{
    NSUInteger lowerBounds = MIN_NUMBER;
    NSUInteger uppperBounds = MAX_NUMBER;
    
    MMFProblem *problem = [self new];
    problem.operation = operation;
    problem.firstNumber = [MMFProblem generateRandomNumberWithMin:lowerBounds
                                                           andMax:uppperBounds];
    if (operation == kSubtraction) {
        problem.secondNumber = [MMFProblem generateRandomNumberWithMin:lowerBounds
                                                                andMax:problem.firstNumber];
    } else {
        problem.secondNumber = [MMFProblem generateRandomNumberWithMin:lowerBounds
                                                                andMax:uppperBounds];
    }
    
    return problem;
}

#pragma mark - Private Methods

+(NSUInteger)generateRandomNumberWithMin:(NSUInteger) minimum andMax:(NSUInteger) maximum
{
    int rndValue = 0;
    if (maximum > minimum) {
        rndValue = minimum + arc4random() % (maximum - minimum);
    }
    return rndValue;
}

@end
