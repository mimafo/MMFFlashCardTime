//
//  MMFProblem.h
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/26/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kAddition,
    kSubtraction,
    kMultiplication
} OperationType;

@interface MMFProblem : NSObject

@property (nonatomic, assign) NSUInteger firstNumber;
@property (nonatomic, assign) NSUInteger secondNumber;
@property (nonatomic, assign) OperationType operation;

-(NSString *)operationString;
-(NSUInteger)answer;

+(instancetype)createRandomProblemWithOperation:(OperationType)operation;


@end
