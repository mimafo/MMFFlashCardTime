//
//  MMFProblemViewController.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFProblemViewController.h"

@interface MMFProblemViewController ()

@property (weak, nonatomic) IBOutlet UILabel *firstNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
- (IBAction)nextPressed:(UIButton *)sender;
- (IBAction)donePressed:(UIButton *)sender;

@end

@implementation MMFProblemViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextPressed:(UIButton *)sender {
}

- (IBAction)donePressed:(UIButton *)sender {
}

@end
