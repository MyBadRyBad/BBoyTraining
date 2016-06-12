//
//  FootworkComboViewController.m
//  SOLPM
//
//  Created by Ryan Badilla on 11/29/15.
//  Copyright © 2015 Newdesto. All rights reserved.
//

#import "FootworkComboViewController.h"
#import "MoveVideoViewController.h"
#import "MSCellAccessory.h"
#import "kColorConstants.h"
#import "kConstants.h"
#import "MoveData.h"

@interface FootworkComboViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation FootworkComboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setup
- (void)setup
{
    [self setupNavigationBar];
    [self setupTable];
}

#pragma mark -
#pragma mark - setup navigation button
- (void)setupNavigationBar
{
    self.navigationItem.title = _comboTitle;
    
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

#pragma mark -
#pragma mark - navigation back
-(void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    return [_footworkArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName;
    NSString *cellCategory;
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellID];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        backgroundView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        
        cell.selectedBackgroundView = backgroundView;
    }
    
    if ([_footworkArray count] > 0)
        cellName = [_footworkArray objectAtIndex:indexPath.row];
    else
        cellName = @"";
    
    if ([_footworkCategoryArray count] > 0)
        cellCategory = [_footworkCategoryArray objectAtIndex:indexPath.row];
    else
        cellCategory = @"";
    
    cell.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    
    cell.textLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
    cell.textLabel.text = cellName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:12.0f];
    cell.detailTextLabel.text = cellCategory;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    if ([MoveData hasVideo:cellName])
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor whiteColor]];
    else
        cell.accessoryView = nil;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellName = [_footworkArray objectAtIndex:indexPath.row];
    if ([MoveData hasVideo:cellName])
    {
        MoveVideoViewController *powermoveMainViewController = [[MoveVideoViewController alloc] init];
        
        NSString *moveName = [_footworkArray objectAtIndex:indexPath.row];
        powermoveMainViewController.moveName = moveName;
        powermoveMainViewController.moveType = stretching;
        powermoveMainViewController.stepNumber = [NSNumber numberWithInteger: indexPath.row + 1];
        powermoveMainViewController.moveDescription = nil;
        powermoveMainViewController.moveType = footwork;
        powermoveMainViewController.moveName = moveName;
        powermoveMainViewController.videoString = [moveName lowercaseString];
        
        [self.navigationController pushViewController:powermoveMainViewController animated:YES];
    }

    
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
