//
//  MMFCompletedViewController.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFCompletedViewController.h"
#import "MMFTest.h"

@interface MMFCompletedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (nonatomic, readonly) MMFTest *sharedTest;

@end

@implementation MMFCompletedViewController

-(MMFTest *)sharedTest
{
    //Hello World
    return [MMFTest sharedTest];
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
    self.scoreLabel.text = [@(self.sharedTest.correctCount) stringValue];
    self.durationLabel.text = [NSString stringWithFormat:@"%lu minute(s)", (unsigned long)self.sharedTest.durationMinutes];
    self.rankLabel.text = [self.sharedTest rank];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
