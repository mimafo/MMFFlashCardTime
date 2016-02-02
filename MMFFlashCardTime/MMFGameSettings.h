//
//  MMFGameSettings.h
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 5/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GameLevel) {
    kEasy,
    kMedium,
    kDifficult
};

@interface MMFGameSettings : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) GameLevel level;
@property (nonatomic, assign) NSUInteger gameDuration; //In minutes
@property (nonatomic, assign) NSUInteger highScore; //Answers per minute

-(void)save;
-(id)initWithDataSource;

+(instancetype)sharedGameSettings;


@end
