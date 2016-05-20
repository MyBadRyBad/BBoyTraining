//
//  RootViewController.m
//  SOLPM
//
//  Created by Ryan Badilla on 5/14/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "RootViewController.h"
#import "MoveListViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


#pragma mark -
#pragma mark - View Controller lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self presentMoveListViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark -
#pragma mark - 
- (void)presentMoveListViewController {
    MoveListViewController *moveListViewController = [[MoveListViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:moveListViewController];
    
    [self presentViewController:navigationController animated:NO completion:nil];
}

#pragma mark -
#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
