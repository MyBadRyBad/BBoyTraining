//
//  CustomIncrementerViewController.m
//  SOLPM
//
//  Created by Ryan Badilla on 12/24/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "CustomIncrementerViewController.h"
#import "HelperFunctions.h"
#import "kConstants.h"
#import "kColorConstants.h"

@interface CustomIncrementerViewController ()
{
    NSInteger _counter;
    NSInteger _incrementCount;
}

@end

@implementation CustomIncrementerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _counter = 0;
    _incrementCount = 1;
    
    [self setupNavigationBar];
    [self setupView];
    [self setupLabels];
    [self setupIncrementerButton];
    [self setupOtherButtons];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setup navigation button
- (void)setupNavigationBar
{
    self.navigationItem.title = @"Increment Counter";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    
    NSDictionary *leftBarButtonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIFont fontWithName:@"OpenSans-Light" size:16.0],
                                             NSFontAttributeName,
                                             [UIColor whiteColor],
                                             NSForegroundColorAttributeName,
                                             nil];
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:leftBarButtonDictionary forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStyleDone target:self action:@selector(resetButtonPressed:)];
    
    NSDictionary *rightBarButtonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont fontWithName:@"OpenSans-Light" size:16.0],
                                              NSFontAttributeName,
                                              [UIColor whiteColor],
                                              NSForegroundColorAttributeName,
                                              nil];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:rightBarButtonDictionary forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - setup view controller
- (void)setupView
{
    self.view.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
}

#pragma mark -
#pragma mark - setup Button and Labels
- (void)setupIncrementerButton
{
    CGRect incrementerButtonFrame;
    CGFloat fontSize;
    
    if (IS_IPHONE_4_AND_OLDER || IS_IPHONE_5)
    {
        incrementerButtonFrame = CGRectMake(0, 0, 70, 70);
        fontSize = 26.0f;
    }
    else
    {
        incrementerButtonFrame = CGRectMake(0, 0, 80, 80);
        fontSize = 30.0f;
    }
    _incrementerMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _incrementerMainButton.frame = incrementerButtonFrame;
    _incrementerMainButton.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * .75);
    _incrementerMainButton.clipsToBounds = YES;
    _incrementerMainButton.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    _incrementerMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _incrementerMainButton.layer.borderWidth = 2.0f;
    _incrementerMainButton.layer.cornerRadius = _incrementerMainButton.frame.size.width * 0.5;
    _incrementerMainButton.clipsToBounds = YES;
    
    _incrementerMainButton.titleLabel.textColor = [UIColor whiteColor];
    
    _incrementerMainButton.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:fontSize];
    NSString *buttonTitle = [NSString stringWithFormat:@"+%ld", _incrementCount];
    
    [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateNormal];
    [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateSelected];
    [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateHighlighted];
    
    [_incrementerMainButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueWetAsphalt:1.0f]] forState:UIControlStateNormal];
    [_incrementerMainButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateSelected];
    [_incrementerMainButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateHighlighted];
    
    [_incrementerMainButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    [_incrementerMainButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [_incrementerMainButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [_incrementerMainButton addTarget:self action:@selector(buttonDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [_incrementerMainButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel];
    
    _incrementerMainButton.userInteractionEnabled = YES;
    
    [self.view addSubview:_incrementerMainButton];
}

- (void)setupOtherButtons
{
    CGRect incrementButtonFrame;
    CGRect decrementButtonFrame;
    CGFloat fontSize;
    
    if (IS_IPHONE_4_AND_OLDER || IS_IPHONE_5)
    {
        incrementButtonFrame = CGRectMake(0, 0, 30, 30);
        decrementButtonFrame = CGRectMake(0, 0, 30 ,30);
        fontSize = 26.0f;
    }
    else
    {
        incrementButtonFrame = CGRectMake(0, 0, 40, 40);
        decrementButtonFrame = CGRectMake(0, 0, 40, 40);
        fontSize = 30.0f;
    }
    
    // increment button set up
    _incrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _incrementButton.frame = incrementButtonFrame;
    _incrementButton.center = CGPointMake(self.view.frame.size.width * 0.75, self.view.frame.size.height * .75);
    _incrementButton.clipsToBounds = YES;
    _incrementButton.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    _incrementButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _incrementButton.layer.borderWidth = 2.0f;
    _incrementButton.layer.cornerRadius = _incrementButton.frame.size.width * 0.5;
    _incrementButton.clipsToBounds = YES;
    
    _incrementButton.titleLabel.textColor = [UIColor whiteColor];
    
    _incrementButton.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:fontSize];
    NSString *incrementButtonTitle = @"+";
    
    [_incrementButton setTitle:incrementButtonTitle forState:UIControlStateNormal];
    [_incrementButton setTitle:incrementButtonTitle forState:UIControlStateSelected];
    [_incrementButton setTitle:incrementButtonTitle forState:UIControlStateHighlighted];
    
    [_incrementButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueWetAsphalt:1.0f]] forState:UIControlStateNormal];
    [_incrementButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateSelected];
    [_incrementButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateHighlighted];
    
    [_incrementButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    [_incrementButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [_incrementButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [_incrementButton addTarget:self action:@selector(buttonDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [_incrementButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel];
    
    _incrementButton.userInteractionEnabled = YES;
    
    //decrement button set up
    _decrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _decrementButton.frame = incrementButtonFrame;
    _decrementButton.center = CGPointMake(self.view.frame.size.width * 0.25, self.view.frame.size.height * .75);
    _decrementButton.clipsToBounds = YES;
    _decrementButton.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    _decrementButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _decrementButton.layer.borderWidth = 2.0f;
    _decrementButton.layer.cornerRadius = _decrementButton.frame.size.width * 0.5;
    _decrementButton.clipsToBounds = YES;
    
    _decrementButton.titleLabel.textColor = [UIColor whiteColor];
    
    _decrementButton.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:fontSize];
    NSString *decrementButtonTitle = @"-";
    
    [_decrementButton setTitle:decrementButtonTitle forState:UIControlStateNormal];
    [_decrementButton setTitle:decrementButtonTitle forState:UIControlStateSelected];
    [_decrementButton setTitle:decrementButtonTitle forState:UIControlStateHighlighted];
    
    [_decrementButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueWetAsphalt:1.0f]] forState:UIControlStateNormal];
    [_decrementButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateSelected];
    [_decrementButton setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateHighlighted];
    
    [_decrementButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    [_decrementButton addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [_decrementButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [_decrementButton addTarget:self action:@selector(buttonDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [_decrementButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel];
    
    _decrementButton.userInteractionEnabled = YES;
    
    [self.view addSubview:_decrementButton];
    [self.view addSubview:_incrementButton];
}

- (void)setupLabels
{
    _repetitionsTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 50)];
    _repetitionsTotalLabel.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.25);
    _repetitionsTotalLabel.text = [NSString stringWithFormat:@"%ld", (long)_counter];
    _repetitionsTotalLabel.textAlignment = NSTextAlignmentCenter;
    _repetitionsTotalLabel.textColor = [UIColor whiteColor];
    _repetitionsTotalLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:50.0f];
    [self.view addSubview:_repetitionsTotalLabel];
}

#pragma mark -
#pragma mark - incrementerButton pressed
- (void) buttonPress:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    // Do something else
}

- (void) buttonRelease:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    if (button == _incrementerMainButton)
    {
        _counter = _counter + _incrementCount;
        _repetitionsTotalLabel.text = [NSString stringWithFormat:@"%ld", (long)_counter];
    }
    else if (button == _incrementButton)
    {
        _incrementCount = _incrementCount + 1;
        NSString *buttonTitle = [NSString stringWithFormat:@"+%ld", _incrementCount];
        [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateNormal];
        [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateSelected];
        [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateHighlighted];
    }
    else if (button == _decrementButton)
    {
        if (_incrementCount > 1)
            _incrementCount = _incrementCount - 1;
        
        NSString *buttonTitle = [NSString stringWithFormat:@"+%ld", _incrementCount];
        [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateNormal];
        [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateSelected];
        [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateHighlighted];
    }
    
}

- (void)buttonDragExit:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

- (void)buttonCancel:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

#pragma mark -
#pragma mark - backButtonPressed
- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - resetButtonPressed
- (void)resetButtonPressed:(id)sender
{
    _counter = 0;
    _repetitionsTotalLabel.text = [NSString stringWithFormat:@"%ld", (long)_counter];
    
    _incrementCount = 1;
    NSString *buttonTitle = [NSString stringWithFormat:@"+%ld", _incrementCount];
    [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateNormal];
    [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateSelected];
    [_incrementerMainButton setTitle:buttonTitle forState:UIControlStateHighlighted];
}

@end
