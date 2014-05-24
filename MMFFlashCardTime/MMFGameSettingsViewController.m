//
//  MMFGameSettingsViewController.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 5/24/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFGameSettingsViewController.h"
#import "MMFGameSettings.h"

@interface MMFGameSettingsViewController ()

//IBActions
- (IBAction)donePressed:(UIBarButtonItem *)sender;

//IBOutlets
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *levelSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *durationSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;

//Properties
@property (nonatomic, readonly) MMFGameSettings *gameSettings;

@end

@implementation MMFGameSettingsViewController

#pragma mark - Property getters and setters

-(MMFGameSettings *)gameSettings
{
    return [MMFGameSettings sharedGameSettings];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usernameTextField.text = self.gameSettings.userName;
    self.highScoreLabel.text = [NSString stringWithFormat:@"%lu answers per minute",
                                (unsigned long)self.gameSettings.highScore];
    
    [self setLevelControl];
    [self setDurationControl];
    
    
}

#pragma mark - IBAction methods
- (IBAction)donePressed:(UIBarButtonItem *)sender {
    
    self.gameSettings.userName = self.usernameTextField.text;
    [self setLevelValue];
    [self setDurationValue];
    [self.gameSettings save];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Private Methods
-(void)setLevelControl
{
    switch (self.gameSettings.level) {
        case kEasy:
            self.levelSegmentedControl.selectedSegmentIndex = 0;
            break;
        case kMedium:
            self.levelSegmentedControl.selectedSegmentIndex = 1;
            break;
        case kDifficult:
            self.levelSegmentedControl.selectedSegmentIndex = 2;
            break;
        default:
            break;
    }
}

-(void)setLevelValue
{
    switch (self.levelSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.gameSettings.level = kEasy;
            break;
        case 1:
            self.gameSettings.level = kMedium;
            break;
        case 2:
            self.gameSettings.level = kDifficult;
            break;
        default:
            break;
    }
    
}

-(void)setDurationControl
{
    switch (self.gameSettings.gameDuration) {
        case 2:
            self.durationSegmentedControl.selectedSegmentIndex = 0;
            break;
        case 3:
            self.durationSegmentedControl.selectedSegmentIndex = 1;
            break;
        case 5:
            self.durationSegmentedControl.selectedSegmentIndex = 2;
            break;
        default:
            break;
    }
}

-(void)setDurationValue
{
    switch (self.durationSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.gameSettings.gameDuration = 2;
            break;
        case 1:
            self.gameSettings.gameDuration = 3;
            break;
        case 2:
            self.gameSettings.gameDuration = 5;
            break;
        default:
            break;
    }
    
}

@end
