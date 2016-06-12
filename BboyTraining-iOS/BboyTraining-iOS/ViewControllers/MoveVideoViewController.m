//
//  MoveVideoViewController
//  SOLPM
//
//  Created by Ryan Badilla on 11/12/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "MoveVideoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HelperFunctions.h"
#import "kColorConstants.h"

@interface MoveVideoViewController ()
{
  //  FLAnimatedImageView *imageView;
    NSInteger counter;
}

@end

@implementation MoveVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    counter = 0;

    
    [self setupNavigationBar];
    [self setupView];
    [self setupVideoPlayer];
    
    if (_moveType != footwork)
        [self setupIncrementerButton];
    
    [self setupLabels];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setup navigation button
- (void)setupNavigationBar
{
    if (_moveType == footwork)
        self.navigationItem.title = @"Footwork";
    else
        self.navigationItem.title = @"Training";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    
    NSDictionary *leftBarButtonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIFont fontWithName:@"OpenSans-Light" size:16.0],
                                             NSFontAttributeName,
                                             [UIColor whiteColor],
                                             NSForegroundColorAttributeName,
                                             nil];
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:leftBarButtonDictionary forState:UIControlStateNormal];
    
    if (_moveType != footwork)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    
        NSDictionary *rightBarButtonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont fontWithName:@"OpenSans-Light" size:16.0],
                                              NSFontAttributeName,
                                              [UIColor whiteColor],
                                              NSForegroundColorAttributeName,
                                              nil];
    
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:rightBarButtonDictionary forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark - setup view controller
- (void)setupView
{
    self.view.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    
    UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    if (_moveType == footwork)
        moveLabel.text = _moveName;
    else
        moveLabel.text = [NSString stringWithFormat:@"%@ - Step %ld", _moveName, (long)[_stepNumber integerValue]];
    
    moveLabel.textColor = [UIColor whiteColor];
    moveLabel.textAlignment = NSTextAlignmentCenter;
    moveLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
    [self.view addSubview:moveLabel];
}

#pragma mark -
#pragma mark - setup video player
-(void)setupVideoPlayer
{
    
    if (_videoString.length > 0)
    {
        //movieplayer initialization
        NSString *path = [[NSBundle mainBundle] pathForResource:_videoString ofType:@"mp4"];
        NSURL *videoURL = [NSURL fileURLWithPath:path];
    }
}

#pragma mark -
#pragma mark - setup Button and Labels
- (void)setupIncrementerButton
{
    CGRect incrementerButtonFrame;
    CGFloat fontSize;
    
    _incrementerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _incrementerButton.frame = incrementerButtonFrame;
    _incrementerButton.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * .75);
    _incrementerButton.clipsToBounds = YES;
    _incrementerButton.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    _incrementerButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _incrementerButton.layer.borderWidth = 2.0f;
    _incrementerButton.layer.cornerRadius = _incrementerButton.frame.size.width * 0.5;
    _incrementerButton.clipsToBounds = YES;
    
    _incrementerButton.titleLabel.textColor = [UIColor whiteColor];

    
    NSString *buttonTitle;
    if (_incrementCount == nil && _goal == nil)
    {
        _incrementerButton.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:fontSize];
        buttonTitle = @"Done";
    }
    
    else
    {
        _incrementerButton.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:fontSize];
        buttonTitle = [NSString stringWithFormat:@"+%ld", (long)[_incrementCount integerValue]];
    }
    
    [_incrementerButton setTitle:buttonTitle forState:UIControlStateNormal];
    [_incrementerButton setTitle:buttonTitle forState:UIControlStateSelected];
    [_incrementerButton setTitle:buttonTitle forState:UIControlStateHighlighted];
    
    [_incrementerButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueWetAsphalt:1.0f]] forState:UIControlStateNormal];
    [_incrementerButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateSelected];
    [_incrementerButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateHighlighted];
    
    [_incrementerButton addTarget:self action:@selector(incrementerButtonPress:) forControlEvents:UIControlEventTouchDown];
    [_incrementerButton addTarget:self action:@selector(incrementerButtonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [_incrementerButton addTarget:self action:@selector(incrementerButtonCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [_incrementerButton addTarget:self action:@selector(incrementerButtonDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [_incrementerButton addTarget:self action:@selector(incrementerButtonCancel:) forControlEvents:UIControlEventTouchCancel];
    
    _incrementerButton.userInteractionEnabled = YES;
    
    [self.view addSubview:_incrementerButton];

}

- (void)setupLabels
{
    
    if (_incrementCount != nil && _goal != nil)
    {
        _goalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 30)];
        _goalLabel.center = CGPointMake(self.view.frame.size.width * 0.80, (self.view.frame.size.height * 0.75) - 15);
        _goalLabel.text = @"Goal For Today:";
        _goalLabel.textAlignment = NSTextAlignmentCenter;
        _goalLabel.textColor = [UIColor whiteColor];
        _goalLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
        [self.view addSubview:_goalLabel];
        
        _goalTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 30)];
        _goalTotalLabel.center = CGPointMake(self.view.frame.size.width * 0.80, (self.view.frame.size.height * 0.75) + 15);
        _goalTotalLabel.text = [NSString stringWithFormat:@"+%ld", (long)[_goal integerValue]];
        _goalTotalLabel.textAlignment = NSTextAlignmentCenter;
        _goalTotalLabel.textColor = [UIColor whiteColor];
        _goalTotalLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:20.0f];
        [self.view addSubview:_goalTotalLabel];
        
        _repetitionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 30)];
        _repetitionsLabel.center = CGPointMake(self.view.frame.size.width * 0.20, (self.view.frame.size.height * 0.75) - 15);
        _repetitionsLabel.text = @"Total For Today:";
        _repetitionsLabel.textAlignment = NSTextAlignmentCenter;
        _repetitionsLabel.textColor = [UIColor whiteColor];
        _repetitionsLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
        [self.view addSubview:_repetitionsLabel];
        
        _repetitionsTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 30)];
        _repetitionsTotalLabel.center = CGPointMake(self.view.frame.size.width * 0.20, (self.view.frame.size.height * 0.75) + 15);
        _repetitionsTotalLabel.text = [NSString stringWithFormat:@"%ld", (long)counter];
        _repetitionsTotalLabel.textAlignment = NSTextAlignmentCenter;
        _repetitionsTotalLabel.textColor = [UIColor whiteColor];
        _repetitionsTotalLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:20.0f];
        [self.view addSubview:_repetitionsTotalLabel];
    }
}

#pragma mark -
#pragma mark - navigation buttons
- (void)doneButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
}

                                              
- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - incrementerButton pressed
- (void) incrementerButtonPress:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    // Do something else
}

- (void) incrementerButtonRelease:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    counter = counter + [_incrementCount integerValue];
    _repetitionsTotalLabel.text = [NSString stringWithFormat:@"%ld", (long)counter];
}

- (void)incrementerButtonDragExit:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

- (void)incrementerButtonCancel:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

@end