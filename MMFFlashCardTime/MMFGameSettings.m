//
//  MMFGameSettings.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 5/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFGameSettings.h"

//String constants
static NSString * const GameSettingsKey = @"GameSettingsKey";
static NSString * const UserNameKey = @"UserNameKey";
static NSString * const LevelKey = @"LevelKey";
static NSString * const GameDurationKey = @"GameDurationKey";
static NSString * const HighScoreKey = @"HighScoreKey";

@interface MMFGameSettings()

@property (nonatomic, strong) NSMutableDictionary *dataSource;

@end

@implementation MMFGameSettings

#pragma mark - Class methods
+(instancetype)sharedGameSettings;
{
    static MMFGameSettings *_settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _settings = [MMFGameSettings new];
        
    });
    return _settings;
}

#pragma mark - Method getters and setters
-(NSMutableDictionary *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:GameSettingsKey];
        if (_dataSource == nil) {
            _dataSource = [NSMutableDictionary dictionary];
            _dataSource[UserNameKey] = @"";
            _dataSource[LevelKey] = @(kEasy);
            _dataSource[GameDurationKey] = @(2);
            _dataSource[HighScoreKey] = @(0);
        }
    }
    return _dataSource;
}

#pragma mark - Initializers
-(id)init
{
    return [self initWithDataSource];
}

-(id)initWithDataSource
{
    self = [super init];
    
    if (self) {
        self.userName = self.dataSource[UserNameKey];
        self.level = [self.dataSource[LevelKey] unsignedIntegerValue];
        self.gameDuration = [self.dataSource[GameDurationKey] unsignedIntegerValue];
        self.highScore = [self.dataSource[HighScoreKey] unsignedIntegerValue];
    }
    return self;
}

#pragma mark - Public Methods
-(void)save
{
    self.dataSource[UserNameKey] = self.userName;
    self.dataSource[LevelKey] = @(self.level);
    self.dataSource[GameDurationKey] = @(self.gameDuration);
    self.dataSource[HighScoreKey] = @(self.highScore);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self.dataSource copy] forKey:GameSettingsKey];
    [defaults synchronize];
}

@end
