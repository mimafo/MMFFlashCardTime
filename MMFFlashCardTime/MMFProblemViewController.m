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

static NSString * const doneSegue = @"doneSegue";

@interface MMFProblemViewController () <UITextFieldDelegate>

@property (strong, nonatomic) MMFProblem *problem;

@property (weak, nonatomic) IBOutlet UILabel *firstNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic, readonly) MMFTest *sharedTest;

@property (nonatomic, strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)nextPressed:(UIButton *)sender;

@end

@implementation MMFProblemViewController

#pragma mark - property getters and setters

-(MMFTest *)sharedTest
{
    return [MMFTest sharedTest];
}
-(NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1
                                         target:self
                                       selector:@selector(handleTimer:)
                                       userInfo:nil
                                        repeats:YES];
    }
    return _timer;
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
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.sharedTest isTimeExpired]) {
        self.answerTextField.enabled = NO;
        self.nextButton.enabled = NO;
    } else {
        [self initializeViewController];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self cleanup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    BOOL proceed = YES;
    //Do nothing
    
    return proceed;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self cleanup];
}

#pragma mark - UITextFieldDelegate method(s)

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.answerTextField) {
        return NO;
    }
    return YES;
}

#pragma mark - Gesture recognizers

-(void)handleTap:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

#pragma mark - Timer handler

-(void)handleTimer:(NSTimer *)timer
{
    self.timerLabel.text = [self.sharedTest timeRemaining];
}

#pragma mark - IBAction methods

- (IBAction)nextPressed:(UIButton *)sender {
    self.sharedTest.correctCount++;
    
    [self.answerTextField resignFirstResponder];
    
    //Put your validation code here and return YES or NO as needed
    if ([self.answerTextField.text length] < 1) {
        
        [self displayAnswerErrorMessage:@"Answer is missing, try again"];
        return;
        
    } else {
        
        NSUInteger theAnswer = [self.answerTextField.text integerValue];
        if (theAnswer != [self.problem answer]) {
            [self displayAnswerErrorMessage:@"Incorrect answer, try again"];
            return;
        }
    }
    
    //Everything is OK, let's go to the next problem
    
    [self cleanup];
    [self animateProblemTransition];
    [self initializeViewController];
    
}


#pragma mark - Private Methods

-(void)displayNumbers
{
    self.firstNumberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.problem.firstNumber];
    self.secondNumberLabel.text = [NSString stringWithFormat:@"%@ %lu",[self.problem operationString],(unsigned long)self.problem.secondNumber];
    self.answerTextField.text = @"";
    
}

-(void)displayAnswerErrorMessage:(NSString *)errorMessage
{
    
    [[UIAlertView alertPopupWithTitle:@"Wrong Answer" withMessage:errorMessage] show];
    self.answerTextField.text = @"";
    [self.answerTextField becomeFirstResponder];
    
}

-(void)cleanup
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)initializeViewController
{
    
    if ([self.sharedTest isTimeExpired]) {
        [self performSegueWithIdentifier:doneSegue sender:self];
        return;
    }
    
    self.problemNumber++;
    self.problem = [MMFProblem createRandomProblemWithOperation:self.sharedTest.operation];
    
    self.title = [NSString stringWithFormat:@"Problem screen: %lu",(unsigned long)self.problemNumber];
    [self displayNumbers];
    
    [self.answerTextField becomeFirstResponder];
    
    self.timerLabel.text = [self.sharedTest timeRemaining];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)animateProblemTransition
{
    //Snapshot the current problem view
    UIView *snapshotView = [self.view snapshotViewAfterScreenUpdates:NO];
    //A border will make it easier to see
    snapshotView.layer.borderWidth = 1.0;
    snapshotView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self.view addSubview:snapshotView];
    
    
    CGRect moveRect = CGRectOffset(snapshotView.frame, self.view.frame.origin.x - self.view.frame.size.width*4, self.view.frame.origin.y);
    
    //Do Slide Animation
    [UIView animateKeyframesWithDuration:0.25
                                   delay:0
                                 options:0
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:4
                                                                animations:^{
                                                                    snapshotView.frame = moveRect;
                                                                }];
                                  
                              }
                              completion:^(BOOL finished) {
                                  //Cleanup the view hierarchy
                                  [snapshotView removeFromSuperview];
                              }];
    
}


@end
