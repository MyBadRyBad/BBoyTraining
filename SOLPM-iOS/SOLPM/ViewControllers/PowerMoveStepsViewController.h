//
//  PowerMoveStepsViewController.h
//  SOLPM
//
//  Created by Ryan Badilla on 11/12/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PowerMoveStepsViewController : UIViewController < UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDictionary *moveData;

@property (nonatomic) BOOL isStretching;

@end
