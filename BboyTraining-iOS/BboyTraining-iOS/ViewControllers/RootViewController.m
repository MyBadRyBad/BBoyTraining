//
//  RootViewController.m
//  SOLPM
//
//  Created by Ryan Badilla on 5/14/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "RootViewController.h"
#import "MoveListViewController.h"
#import "MovesViewController.h"
#import "kColorConstants.h"
#import "kConstants.h"
#import <ZCFocusLabel.h>

static CGFloat const kFrameSpacing = 20.0f;
static CGFloat const kLabelHeight = 90.0f;

@interface RootViewController ()

@property (nonatomic, strong) ZCFocusLabel *middleLabel;

@end

@implementation RootViewController


#pragma mark -
#pragma mark - View Controller lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   // [self animateLabels];
    [self presentMoveListViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark - setup
- (void)setup {
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews {
    [self.view addSubview:[self middleLabel]];
}

- (void)setupConstraints {
    
}


#pragma mark -
#pragma mark - animateLabels
- (void)animateLabels
{

    [self setupLabel:_middleLabel
            withText:NSLocalizedString(@"There are no limits.\nThere are only plateaus.", nil)
           withColor:[UIColor blackColor]
   animationDuration:.10
      animationDelay:0.1];
    
    [_middleLabel startAppearAnimation];
    
    [self performSelector:@selector(presentMoveListViewController) withObject:nil afterDelay:10.0f];
}

- (void)animateLabel:(ZCFocusLabel *)label {
    [label startAppearAnimation];
}

#pragma mark -
#pragma mark - setupLabel
- (void)setupLabel:(ZCFocusLabel *)label
          withText:(NSString *)text
         withColor:(UIColor *)color
 animationDuration:(NSTimeInterval)animationDuration
    animationDelay:(NSTimeInterval)animationDelay {
    
    if (!text) text = @"";
    
    label.text = text;

    label.animationDuration = animationDuration;
    label.animationDelay = animationDelay;
    label.onlyDrawDirtyArea = YES;
    label.layerBased = NO;
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 5;
    style.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:kDefaultFontName size:kTableCellFontSize],
                                 NSParagraphStyleAttributeName : style,
                                 NSForegroundColorAttributeName : color};
    
    NSMutableAttributedString *mutableString = [[[NSAttributedString alloc] initWithString:label.text attributes:attributes] mutableCopy];
    
    label.attributedString = mutableString;
    
}

#pragma mark -
#pragma mark - present viewcontroller
- (void)presentMoveListViewController {
 //   MoveListViewController *moveListViewController = [[MoveListViewController alloc] init];
    MovesViewController *movesViewController = [[MovesViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:movesViewController];
    
    [self presentViewController:navigationController animated:NO completion:nil];
}

#pragma mark -
#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - getter methods
- (ZCFocusLabel *)middleLabel {
    if (!_middleLabel) {
        CGFloat xPos = kFrameSpacing;
        CGFloat yPos = (self.view.frame.size.height * 0.5) - (kLabelHeight * 0.5);
        CGFloat width = self.view.frame.size.width - (kFrameSpacing * 2);
        CGFloat height = kLabelHeight;
        
        CGRect frame = CGRectMake(xPos, yPos, width, height);
        
        _middleLabel = [[ZCFocusLabel alloc] initWithFrame:frame];

        
    }
    
    return _middleLabel;
}

@end
