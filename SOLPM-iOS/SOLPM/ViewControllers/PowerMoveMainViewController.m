//
//  PowerMoveMainViewController.m
//  SOLPM
//
//  Created by Ryan Badilla on 11/12/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "PowerMoveMainViewController.h"
#import "kColorConstants.h"
#import "kConstants.h"
#import "FLAnimatedImage.h"

@interface PowerMoveMainViewController ()
{
    FLAnimatedImageView *imageView;
}

@end

@implementation PowerMoveMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setup navigation button
- (void)setupNavigationBar
{
    self.navigationItem.title = @"Training";
    
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)]];
    self.navigationItem.rightBarButtonItem = rightNavButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    
    NSDictionary *leftBarButtonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIFont fontWithName:@"OpenSans-Light" size:16.0],
                                             NSFontAttributeName,
                                             [UIColor whiteColor],
                                             NSForegroundColorAttributeName,
                                             nil];
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:leftBarButtonDictionary forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - setup view controller
- (void)setupView
{
    self.view.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
    
    UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    moveLabel.text = [NSString stringWithFormat:@"%@ - Step %ld", _moveName, (long)_stepNumber];
    moveLabel.textColor = [UIColor whiteColor];
    moveLabel.textAlignment = NSTextAlignmentCenter;
    moveLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
    [self.view addSubview:moveLabel];
    
    if (!imageView) {
        imageView = [[FLAnimatedImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
    }
    
    imageView.frame = CGRectMake(16, 120.0, self.view.bounds.size.width - 32, 300);
    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"windmill_step1" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data1];
    imageView.animatedImage = animatedImage;
    [self.view addSubview:imageView];
}

#pragma mark -
#pragma mark - backButtonPressed
- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
