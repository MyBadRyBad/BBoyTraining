//
//  FootworkListViewController.m
//  SOLPM
//
//  Created by Ryan Badilla on 11/29/15.
//  Copyright © 2015 Newdesto. All rights reserved.
//

#import "FootworkListViewController.h"
#import "FootworkComboViewController.h"
#import "MCSwipeTableViewCell.h"
#import "MSCellAccessory.h"
#import "kConstants.h"
#import "kColorConstants.h"

@interface FootworkListViewController () <UITableViewDataSource, UITableViewDelegate, MCSwipeTableViewCellDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *footworkComboListArray;
@property (nonatomic) NSInteger removeIndex;

@end

@implementation FootworkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - setup navigation button
- (void)setupNavigationBar
{
    
    NSString *title = @"Footwork Generator";
    self.navigationItem.title = title;
    
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
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_footworkComboListArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
    if (cell == nil) {
        
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        backgroundView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        
        cell.selectedBackgroundView = backgroundView;
    }
        
    [self configureCell:cell forRowAtIndexPath:indexPath];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSDictionary *footworkDictionary = [_footworkComboListArray objectAtIndex:indexPath.row];
    
    FootworkComboViewController *footworkComboViewController = [[FootworkComboViewController alloc] init];
    
    footworkComboViewController.footworkArray = footworkDictionary[kFootworkNameKey];
    footworkComboViewController.footworkCategoryArray = footworkDictionary[kFootworkCategoryKey];
    
    [self.navigationController pushViewController:footworkComboViewController animated:YES];
    
}


- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *resetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    UIColor *redColor = [kColorConstants redPomegranate:1.0f];
    
    cell.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
    cell.textLabel.text = [NSString stringWithFormat:@"Combo %ld", (long)indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    [cell hideLabels:YES];
    
    // Setting the default inactive state color to the tableView background color
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    
    [cell setSwipeGestureWithView:resetView color:redColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        
        _removeIndex = indexPath.row;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reset"
                                                            message:@"Are you sure you want to delete this combo?"
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Yes", nil];
        [alertView show];
    }];
}

#pragma mark -
#pragma mark - alertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        NSMutableArray *copy = [NSMutableArray arrayWithArray:_footworkComboListArray];
        [copy removeObjectAtIndex:_removeIndex];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:copy forKey:kUserDefaultsFWCombosKey];
        [userDefaults synchronize];
        
        _footworkComboListArray = copy;
        [_tableView reloadData];
    }
}

#pragma mark -
#pragma mark - navigation back
-(void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - setup
- (void)setup
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _footworkComboListArray = [userDefaults objectForKey:kUserDefaultsFWCombosKey];
    
    [self setupTable];
    [self setupNavigationBar];
}


- (void)setupTable
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    footerView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
    
    _tableView.tableFooterView = footerView;
    [_tableView setAllowsSelection:YES];
    
    [self.view addSubview:_tableView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
