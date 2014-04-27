//
//  MMFProblemViewController.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFProblemViewController.h"
#import "MMFProblem.h"

@interface MMFProblemViewController ()

@property (strong, nonatomic) MMFProblem *problem;

@property (weak, nonatomic) IBOutlet UILabel *firstNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@end

@implementation MMFProblemViewController

#pragma mark - View Controller methods

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
    self.problem = [MMFProblem createRandomProblemWithOperation:kSubtraction];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = [NSString stringWithFormat:@"Problem screen: %lu",(unsigned long)self.problemNumber];
    [self displayNumbers];
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
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[self class]]) {
        MMFProblemViewController *pvc = (MMFProblemViewController *)vc;
        pvc.problemNumber = self.problemNumber + 1;
    }
}

#pragma mark - Private Methods

-(void)displayNumbers
{
    self.firstNumberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.problem.firstNumber];
    self.secondNumberLabel.text = [NSString stringWithFormat:@"%@ %lu",[self.problem operationString],(unsigned long)self.problem.secondNumber];
    
}

@end
