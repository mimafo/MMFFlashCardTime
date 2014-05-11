//
//  MMFProblemViewController.m
//  MMFFlashCardTime
//
//  Created by Michael Folcher on 4/23/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "MMFProblemViewController.h"
#import "MMFProblem.h"
#import "UIAlertView+SimplePopupMessage.h"
#import "MMFTest.h"

static NSString * const nextSegue = @"nextSegue";
static NSString * const doneSegue = @"doneSegue";

@interface MMFProblemViewController () <UITextFieldDelegate>

@property (strong, nonatomic) MMFProblem *problem;

@property (weak, nonatomic) IBOutlet UILabel *firstNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic, readonly) MMFTest *sharedTest;
@property (nonatomic, assign) BOOL completed;

@end

@implementation MMFProblemViewController

#pragma mark - property getters and setters

-(MMFTest *)sharedTest
{
    return [MMFTest sharedTest];
}

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
    self.problem = [MMFProblem createRandomProblemWithOperation:self.sharedTest.operation];
    self.completed = NO;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    self.title = [NSString stringWithFormat:@"Problem screen: %lu",(unsigned long)self.problemNumber];
    [self displayNumbers];
    
    if (self.completed) {
        [self.answerTextField resignFirstResponder];
        self.answerTextField.enabled = NO;
    } else {
        [self.answerTextField becomeFirstResponder];
    }
    
    self.timerLabel.text = [self.sharedTest timeRemaining];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.sharedTest.isTimeExpired) {
        [self performSegueWithIdentifier:doneSegue sender:self];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    BOOL proceed = YES;
    if ([identifier isEqualToString:nextSegue]) {
        
        [self.answerTextField resignFirstResponder];
        
        //Put your validation code here and return YES or NO as needed
        if ([self.answerTextField.text length] < 1) {
            
            [self displayAnswerErrorMessage:@"Answer is missing, try again"];
            proceed = NO;
            
        } else {
            
            NSUInteger theAnswer = [self.answerTextField.text integerValue];
            if (theAnswer != [self.problem answer]) {
                [self displayAnswerErrorMessage:@"Incorrect answer, try again"];
                proceed = NO;
            }
        }

    }
    
    return proceed;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString:nextSegue]) {
        
        self.sharedTest.correctCount++;
    
        // Pass the selected object to the new view controller.
        UIViewController *vc = [segue destinationViewController];
        if ([vc isKindOfClass:[self class]]) {
            MMFProblemViewController *pvc = (MMFProblemViewController *)vc;
            pvc.problemNumber = self.problemNumber + 1;
        }
        
    }
}

#pragma mark - UITextFieldDelegate method(s)

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.answerTextField) {
        [self.navigationController performSegueWithIdentifier:nextSegue sender:self];
        return NO;
    }
    return YES;
}

#pragma mark - Private Methods

-(void)displayNumbers
{
    self.firstNumberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.problem.firstNumber];
    self.secondNumberLabel.text = [NSString stringWithFormat:@"%@ %lu",[self.problem operationString],(unsigned long)self.problem.secondNumber];
    
}

-(void)displayAnswerErrorMessage:(NSString *)errorMessage
{
    
    [[UIAlertView alertPopupWithTitle:@"Wrong Answer" withMessage:errorMessage] show];
    self.answerTextField.text = @"";
    [self.answerTextField becomeFirstResponder];
    
}

@end
