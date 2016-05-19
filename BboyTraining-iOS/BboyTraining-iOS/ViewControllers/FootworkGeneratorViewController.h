//
//  FootworkGeneratorViewController.h
//  SOLPM
//
//  Created by Ryan Badilla on 12/24/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootworkGeneratorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *moveData;

@end
