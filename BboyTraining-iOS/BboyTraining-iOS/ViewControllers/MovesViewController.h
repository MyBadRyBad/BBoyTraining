//
//  MovesViewController.h
//  BboyTraining-iOS
//
//  Created by Ryan Badilla on 6/5/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *navigationBarTitle;


@property (nonatomic, strong) NSArray *moveNodesArray;
@property (nonatomic, strong) UITableView *tableView;

@end
