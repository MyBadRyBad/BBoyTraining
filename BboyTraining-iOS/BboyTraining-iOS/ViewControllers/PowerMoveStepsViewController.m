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
#import "StepTableViewCell.h"
#import "kColorConstants.h"
#import "MSCellAccessory.h"
#import "MoveData.h"
#import "HelperFunctions.h"

@interface PowerMoveStepsViewController () <UIAlertViewDelegate>
{
    NSIndexPath *_resetIndexPath;
    
    NSString *_powermoveName;
    
    //stretchingArray
    NSArray *_legsVideoArray;
    NSArray *_armsVideoArray;
    NSArray *_backVideoArray;
    
    // footwork
    NSArray *_atomicStyleArray;
    NSArray *_backboneArray;
    NSArray *_circulatingArray;
    NSArray *_freezesArray;
    NSArray *_godownsArray;
    NSArray *_hookandslingArray;
    NSArray *_inYourFaceArray;
    NSArray *_miscArray;
    NSArray *_nohandedArray;
    NSArray *_pretzelsArray;
    
    
    
    // others
    NSArray *_stepDescriptionArray;
    NSArray *_stepVideoArray;
    NSArray *_stepIncrementCountArray;
    NSArray *_stepGoalCountArray;
    NSArray *_stepRepTotalArray;
    
    NSUserDefaults *defaults;
}

@end

@implementation PowerMoveStepsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    [self setupArrays];
    [self setupTable];
    [self setupNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_tableView reloadData];
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
        
        if (_movetype == stretching)
        {
            _armsVideoArray = [_moveData objectForKey:@"arms"];
            _legsVideoArray = [_moveData objectForKey:@"legs"];
            _backVideoArray = [_moveData objectForKey:@"back"];
        }
        else if (_movetype == footwork)
        {
            _atomicStyleArray = [_moveData objectForKey:@"atomicStyle"];
            _backboneArray = [_moveData objectForKey:@"backbone"];
            _circulatingArray = [_moveData objectForKey:@"circulating"];
            _freezesArray = [_moveData objectForKey:@"freezes"];
            _godownsArray = [_moveData objectForKey:@"godowns"];
            _hookandslingArray = [_moveData objectForKey:@"hook&sling"];
            _inYourFaceArray = [_moveData objectForKey:@"inYourFace"];
            _miscArray = [_moveData objectForKey:@"misc"];
            _nohandedArray = [_moveData objectForKey:@"nohanded"];
            _pretzelsArray = [_moveData objectForKey:@"pretzels"];
        }
        else
        {
            _stepDescriptionArray = [_moveData objectForKey:@"stepDescription"];
            _stepVideoArray = [_moveData objectForKey:@"stepVideo"];
            _stepIncrementCountArray = [_moveData objectForKey:@"stepIncrementNumber"];
            _stepGoalCountArray = [_moveData objectForKey:@"stepGoalNumber"];
            _stepRepTotalArray = [_moveData objectForKey:@"stepRepTotal"];
        }
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
    _tableView.separatorColor = [ kColorConstants blueMidnightBlue:1.0f];
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
    if (_movetype == stretching)
        return 3;
    else if (_movetype == footwork)
        return 10;
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_movetype == stretching)
    {
        if (section == 0)
            return [_legsVideoArray count];
        else if (section == 1)
            return [_armsVideoArray count];
        else if (section == 2)
            return [_backVideoArray count];
        else return 0;
    }
    else if (_movetype == footwork)
    {
        if (section == 0)
            return [_inYourFaceArray count];
        else if (section == 1)
            return [_hookandslingArray count];
        else if (section == 2)
            return [_backboneArray count];
        else if (section == 3)
            return [_circulatingArray count];
        else if (section == 4)
            return [_atomicStyleArray count];
        else if (section == 5)
            return [_pretzelsArray count];
        else if (section == 6)
            return [_godownsArray count];
        else if (section == 7)
            return [_nohandedArray count];
        else if (section == 8)
            return [_miscArray count];
        else
            return [_freezesArray count];
    }
    
    else
        return [_stepVideoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    if ((_movetype == stretching) || (_movetype == footwork))
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
            backgroundView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
            
            cell.selectedBackgroundView = backgroundView;
        }
        NSString *cellName;
        if (_movetype == stretching)
            cellName = [NSString stringWithFormat:@"Step %ld", (long)(indexPath.row + 1)];
        else
            cellName = [self getFootworkNameFromIndexPath:indexPath];
        
        cell.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
        
        cell.textLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
        cell.textLabel.text = cellName;
        cell.textLabel.textColor = [UIColor whiteColor];
        
        if ([MoveData hasVideo:cellName])
            cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor whiteColor]];
        else
            cell.accessoryView = nil;
        
        return cell;
    }
    else
    {
  /*      MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
            
            backgroundView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
            
            cell.selectedBackgroundView = backgroundView;
        }
        
        [self configureCell:cell forRowAtIndexPath:indexPath];
        
        return cell; */
        
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_movetype == stretching || _movetype == footwork)
        return 44.0f;
    else
        return 70.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_movetype == stretching || _movetype == footwork)
    {
        NSString *cellName = [self getFootworkNameFromIndexPath:indexPath];
        if ([MoveData hasVideo:cellName])
            [self performSegueWithIdentifier:@"segueToPowerMoveMainViewController" sender:indexPath];
    }
    else
        [self performSegueWithIdentifier:@"segueToPowerMoveMainViewController" sender:indexPath];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_movetype == stretching || _movetype == footwork)
        return 36.0;
    else
        return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_movetype == stretching || _movetype == footwork)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
        view.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, tableView.frame.size.width, 22)];
        label.font = [UIFont fontWithName:@"OpenSans-Light" size:18.0f];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        NSString *string = [self getHeaderTitle:_movetype section:section];
        
        [label setText:string];
        
        [view addSubview:label];
        return view;
    }
    else
        return nil;
}



#pragma mark -
#pragma mark - cell configurations
- (NSString *)getHeaderTitle:(MoveType)movetype section:(NSInteger)section
{
    if (_movetype == stretching)
    {
        if (section == 0)
            return @"Legs Stretching";
        else if (section == 1)
            return @"Arms Stretching";
        else
            return @"Back Stretching";
    }
    else if (_movetype == footwork)
    {
        if (section == 0)
            return @"In Your Face";
        else if (section == 1)
            return @"Hook & Sling";
        else if (section == 2)
            return @"Backbone Basics";
        else if (section == 3)
            return @"Circulating";
        else if (section == 4)
            return @"Atomic Style";
        else if (section == 5)
            return @"Pretzels";
        else if (section == 6)
            return @"Go Downs";
        else if (section == 7)
            return @"No handed";
        else if (section == 8)
            return @"Misc";
        else
            return @"Freezes";
    }
    else
        return @"";
}

- (NSString *)getFootworkNameFromIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return [_inYourFaceArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 1)
        return [_hookandslingArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 2)
        return [_backboneArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 3)
        return [_circulatingArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 4)
        return [_atomicStyleArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 5)
        return [_pretzelsArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 6)
        return [_godownsArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 7)
        return [_nohandedArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 8)
        return [_miscArray objectAtIndex:indexPath.row];
    else
        return [_freezesArray objectAtIndex:indexPath.row];
}

/*- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *resetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    UIColor *redColor = [kColorConstants redPomegranate:1.0f];
    
    UIView *completeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    UIColor *greenColor = [kColorConstants greenEmeraldColor:1.0f];
    
    NSNumber *goalNumber = [_stepRepTotalArray objectAtIndex:indexPath.row];
    NSNumber *dailyNumber = [_stepGoalCountArray objectAtIndex:indexPath.row];
    NSNumber *repsNumber = [defaults objectForKey:[MoveData getMoveKeyString:_powermoveName step:(indexPath.row + 1)]];
    
    if ([repsNumber integerValue] >= [goalNumber integerValue])
    {
      [cell setCompleted:YES];
        cell.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:[kColorConstants greenEmeraldColor:1.0f]];
    }
    else
    {
        [cell setCompleted:NO];
        cell.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor whiteColor]];
    }
    
    cell.stepLabel.text = [NSString stringWithFormat:@"Step %ld", (long)(indexPath.row + 1)];
    cell.completedNumberLabel.text = ((repsNumber) ? [repsNumber stringValue] : @"0");
    cell.goalNumberLabel.text = [goalNumber stringValue];
    cell.dailyNumberLabel.text = [dailyNumber stringValue];
    

    
    // Setting the default inactive state color to the tableView background color
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    
    [cell setSwipeGestureWithView:resetView color:redColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        
        _resetIndexPath = indexPath;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reset"
                                                            message:@"Are you sure you want to reset your progress?"
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Yes", nil];
        [alertView show];
    }];
    
    [cell setSwipeGestureWithView:completeView color:greenColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        
            // Store the data first
            NSString *key = [MoveData getMoveKeyString:_powermoveName step:[[NSNumber numberWithInteger: indexPath.row + 1] longValue]];
    
            [defaults setObject:[NSNumber numberWithInteger:[goalNumber integerValue]] forKey:key];
        
            [defaults synchronize];
        
            // finally set completed
            [cell setCompleted:YES];
            cell.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
            cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:[kColorConstants greenEmeraldColor:1.0f]];
            [_tableView reloadData];
    }];
} */


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
    powermoveMainViewController.moveName = _powermoveName;
    
    if (_movetype == stretching)
    {
        powermoveMainViewController.moveType = stretching;
        
        powermoveMainViewController.stepNumber = [NSNumber numberWithInteger: indexPath.row + 1];
        powermoveMainViewController.moveDescription = nil;
        
        if (indexPath.section == 0)
            powermoveMainViewController.videoString = [_legsVideoArray objectAtIndex:indexPath.row];
        else if (indexPath.section == 1)
            powermoveMainViewController.videoString = [_armsVideoArray objectAtIndex:indexPath.row];
        else if (indexPath.section == 2)
            powermoveMainViewController.videoString = [_backVideoArray objectAtIndex:indexPath.row];
        powermoveMainViewController.incrementCount = nil;
        powermoveMainViewController.goal = nil;
    }
    else if (_movetype == footwork)
    {
        
        NSString *moveName = [self getFootworkNameFromIndexPath:indexPath];
        powermoveMainViewController.moveType = footwork;
        powermoveMainViewController.moveName = moveName;
        powermoveMainViewController.videoString = [moveName lowercaseString];
    }
    else
    {
        powermoveMainViewController.moveType = powermove;
        powermoveMainViewController.stepNumber = [NSNumber numberWithInteger: indexPath.row + 1];
        powermoveMainViewController.moveDescription = [_stepDescriptionArray objectAtIndex:indexPath.row];
        powermoveMainViewController.videoString = [_stepVideoArray objectAtIndex:indexPath.row];
        powermoveMainViewController.incrementCount = [_stepIncrementCountArray objectAtIndex:indexPath.row];
        powermoveMainViewController.goal = [_stepGoalCountArray objectAtIndex:indexPath.row];
    }
}


#pragma mark -
#pragma mark - alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // No
    if (buttonIndex == 0) {
        _resetIndexPath = nil;
    }
    
    // Yes
    else {
        NSString *key = [MoveData getMoveKeyString:_powermoveName step:(_resetIndexPath.row + 1)];
        [defaults setObject:[NSNumber numberWithInteger:0] forKey:key];
        [defaults synchronize];
        
        [_tableView reloadData];
    }
}
@end
