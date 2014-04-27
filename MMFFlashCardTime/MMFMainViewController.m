//
//  MMFMainViewController.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFMainViewController.h"
#import "MMFProblemViewController.h"
#import "MMFTest.h"

static NSString * const startSegue = @"startSegue";

@interface MMFMainViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *operationControl;

@end

@implementation MMFMainViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    //Call super class's method
    [super viewWillAppear:animated];
    
    self.title = @"Test Setup";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:startSegue]) {
        OperationType operation = kAddition;
        
        if (self.operationControl.selectedSegmentIndex == 1) {
            operation = kSubtraction;
        } else if (self.operationControl.selectedSegmentIndex == 2) {
            operation = kMultiplication;
        }
            
        [MMFTest setTestOperation:operation];
        
        MMFProblemViewController *vc = (MMFProblemViewController *)segue.destinationViewController;
        vc.problemNumber = 1;
        
    }
}

@end
