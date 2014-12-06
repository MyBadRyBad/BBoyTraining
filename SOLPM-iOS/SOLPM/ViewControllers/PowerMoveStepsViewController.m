//
//  PowerMoveStepsViewController.m
//  SOLPM
//
//  Created by Ryan Badilla on 11/12/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "PowerMoveStepsViewController.h"
#import "PowerMoveMainViewController.h"
#import "LandscapeNavigationController.h"
#import "kConstants.h"
#import "kColorConstants.h"
#import "MSCellAccessory.h"

@interface PowerMoveStepsViewController ()
{
    NSString *_powermoveName;
    NSArray *_stepDescriptionArray;
    NSArray *_stepVideoArray;
    NSArray *_stepIncrementCountArray;
    NSArray *_stepGoalCountArray;
}

@end

@implementation PowerMoveStepsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupArrays];
    [self setupTable];
    [self setupNavigationBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setup navigation button
- (void)setupNavigationBar
{
    
    NSString *title = [_moveData objectForKey:@"name"];
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
#pragma mark - arraySetup
- (void)setupArrays
{
    if (_moveData)
    {
        _powermoveName = [_moveData objectForKey:@"name"];
        _stepDescriptionArray = [_moveData objectForKey:@"stepDescription"];
        _stepVideoArray = [_moveData objectForKey:@"stepVideo"];
        _stepIncrementCountArray = [_moveData objectForKey:@"stepIncrementNumber"];
        _stepGoalCountArray = [_moveData objectForKey:@"stepGoalNumber"];
    }
}

#pragma mark -
#pragma mark - tableSetup
- (void)setupTable
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
    _tableView.separatorColor = [kColorConstants blueMidnightBlue:1.0f];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    footerView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
    
    _tableView.tableFooterView = footerView;
    [_tableView setAllowsSelection:YES];
    
    
    [self.view addSubview:_tableView];
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
    return [_stepVideoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        backgroundView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        
        cell.selectedBackgroundView = backgroundView;
    }
    
    NSString *cellName = [NSString stringWithFormat:@"Step %ld", (long)(indexPath.row + 1)];
    
    cell.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    
    cell.textLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
    cell.textLabel.text = cellName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"segueToPowerMoveMainViewController" sender:indexPath];
        
    
}

#pragma mark -
#pragma mark - backButtonPressed
- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = sender;
    PowerMoveMainViewController *powermoveMainViewController = [segue destinationViewController];
  //  LandscapeNavigationController *navController = [segue destinationViewController];
   // PowerMoveMainViewController *powermoveMainViewController = (PowerMoveMainViewController *)navController.topViewController;
    NSString *moveName = [_moveData objectForKey:@"name"];
    
    powermoveMainViewController.moveName = moveName;
    powermoveMainViewController.stepNumber = [NSNumber numberWithInteger: indexPath.row + 1];
    powermoveMainViewController.moveDescription = [_stepDescriptionArray objectAtIndex:indexPath.row];
    powermoveMainViewController.videoString = [_stepVideoArray objectAtIndex:indexPath.row];
    powermoveMainViewController.incrementCount = [_stepIncrementCountArray objectAtIndex:indexPath.row];
    powermoveMainViewController.goal = [_stepGoalCountArray objectAtIndex:indexPath.row];
    
}


@end
