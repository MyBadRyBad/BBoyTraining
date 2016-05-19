//
//  FootworkComboViewController.h
//  SOLPM
//
//  Created by Ryan Badilla on 11/29/15.
//  Copyright © 2015 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootworkComboViewController : UIViewController

@property (nonatomic, strong) NSString *comboTitle;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *footworkArray;
@property (nonatomic, strong) NSMutableArray *footworkCategoryArray;

@end
