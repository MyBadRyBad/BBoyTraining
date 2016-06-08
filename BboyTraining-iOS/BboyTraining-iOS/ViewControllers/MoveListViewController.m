//
//  MoveListViewController.m
//  BboyTraining-iOS
//
//  Created by Ryan Badilla on 11/12/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "MoveListViewController.h"
#import "PowerMoveStepsViewController.h"
#import "FootworkGeneratorViewController.h"
#import "kColorConstants.h"
#import "MSCellAccessory.h"
#import "kConstants.h"
#import "MoveData.h"


static NSString *kNavigationBarTitle = @"Bboy Training";

@interface MoveListViewController ()

@property (nonatomic, strong) NSArray *moveType;
@property (nonatomic, strong) NSArray *powermoveListArray;
@property (nonatomic, strong) NSArray *powermoveComboListArray;
@property (nonatomic, strong) NSArray *freezesArray;
@property (nonatomic, strong) NSArray *tricksArray;
@property (nonatomic, strong) NSArray *flipsArray;
@property (nonatomic, strong) NSArray *miscArray;
@property (nonatomic, strong) NSArray *stretchingVideoArray;

@property (nonatomic, strong) NSArray *footworkArray;
@property (nonatomic, strong) NSArray *toolsArray;

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation MoveListViewController

#pragma mark -
#pragma mark - View Controller lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupConstaints];
    [self setUpDataArray];
    [self configureNavigationBar];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

#pragma mark -
#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setup
- (void)setupViews {
    [self.view addSubview:[self tableView]];
}

- (void)setupConstaints {
    // Create a dictionary of views and metrics
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView);
    NSDictionary *metrics = nil;
    
    
    // Set up the vertical constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:metrics views:viewsDictionary]];
     
    // Set up the horizontal constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:metrics views:viewsDictionary]];
}

- (void)configureNavigationBar {
    // Configure the navigation bar to a flat grey design and other stuff
 //   self.navigationController.navigationBar.barTintColor = [kColorConstants navigationBarColor:1.0f];
 //   self.navigationController.navigationBar.tintColor = [kColorConstants navigationBarColor:1.0f];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.topItem.title = kNavigationBarTitle;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], NSForegroundColorAttributeName,
      shadow, NSShadowAttributeName,
      shadow, NSShadowAttributeName,
      [UIFont fontWithName:kDefaultFontNameBold size:kDefaultNavigationBarFontSize], NSFontAttributeName,
      nil]];
}

- (void)setUpDataArray
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"moves" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    _powermoveListArray = dict[kMovesPowermovesKey];
    _powermoveComboListArray = dict[kMovesCombosKey];
    _freezesArray = dict[kMovesFreezesKey];
    _tricksArray = dict[kMovesTricksKey];
    _flipsArray = dict[kMovesFlipsKey];
    _miscArray = dict[kMovesMiscKey];
    _footworkArray = dict[kMovesFootworkKey];
    _toolsArray = dict[kMovesToolsKey];
    
    _moveType = [MoveData getMoveTypeArray];
}

#pragma mark -
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_moveType count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [_powermoveListArray count];
        case 1:
            return [_powermoveComboListArray count];
        case 2:
            return [_freezesArray count];
        case 3:
            return [_tricksArray count];
        case 4:
            return [_flipsArray count];
        case 5:
            return [_footworkArray count];
        case 6:
            return [_miscArray count];
        default:
            return [_toolsArray count];;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
   /*     UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        backgroundView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        
        cell.selectedBackgroundView = backgroundView; */
    }
    
    [self setupCell:cell withIndexPath:indexPath];
    
    return cell;
}

- (void)setupCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *moveDictionary;
    NSString *cellName;
    
    if (indexPath.section == 0)
        moveDictionary = [_powermoveListArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 1)
        moveDictionary = [_powermoveComboListArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 2)
        moveDictionary = [_freezesArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 3)
        moveDictionary = [_tricksArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 4)
        moveDictionary = [_flipsArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 5)
        moveDictionary = [_footworkArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 6)
        moveDictionary = [_miscArray objectAtIndex:indexPath.row];
    else if (indexPath.section == 7)
        moveDictionary = [_toolsArray objectAtIndex:indexPath.row];
    
    if (moveDictionary)
        cellName = [moveDictionary objectForKey:@"name"];
    
  //  cell.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont fontWithName:kDefaultFontName size:16.0f];
    cell.textLabel.text = cellName;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
  //  cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
  //  cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor whiteColor]];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // go to footwork generator
    if (indexPath.section == 7 && indexPath.row == 0) {
        
    }
    // go to incrementer
    else if (indexPath.section == 7 && indexPath.row == 1) {
     /*   Incred *powermovesStepViewController = [[PowerMoveStepsViewController alloc] init];
        powermovesStepViewController.moveData = nil;
        
        [self.navigationController pushViewController:powermovesStepViewController animated:YES];
        [self presentViewController:powermovesStepViewController animated:YES completion:nil]; */
    }
    else {
        PowerMoveStepsViewController *powermovesStepViewController = [[PowerMoveStepsViewController alloc] init];
        powermovesStepViewController.moveData = nil;
        
        [self.navigationController pushViewController:powermovesStepViewController animated:YES];
        [self presentViewController:powermovesStepViewController animated:YES completion:nil];
    }
    
   /* if (indexPath.section == 7 && indexPath.row == 0)
        [self performSegueWithIdentifier:@"segueToFootworkGeneratorViewController" sender:indexPath];
    else if (indexPath.section == 7 && indexPath.row == 1)
        [self performSegueWithIdentifier:@"segueToCustomIncrementerViewController" sender:indexPath];
    else
        [self performSegueWithIdentifier:@"segueToPowerMoveStepsViewController" sender:indexPath]; */
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_moveType objectAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
 //   view.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, tableView.frame.size.width, 18)];
    label.font = [UIFont fontWithName:kDefaultFontNameBold size:kTableCellFontSize];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [_moveType objectAtIndex:section];

    [view addSubview:label];
    
    return view;
}

#pragma mark - 
#pragma mark - Navigation
- (void)pushStepsViewControllerWithStepDictionary:(NSDictionary *)stepDictionary
                                        onCompletion:(void (^)(void))onCompletion {
    
    PowerMoveStepsViewController *powermovesStepViewController = [[PowerMoveStepsViewController alloc] init];
    powermovesStepViewController.moveData = stepDictionary;
    
    [self.navigationController pushViewController:powermovesStepViewController animated:YES];
    [self presentViewController:powermovesStepViewController animated:YES completion:onCompletion];
}

- (void)pushFootworkGeneratorViewControllerWithStepDictionary {
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segueToPowerMoveStepsViewController"])
    {
        NSIndexPath *indexPath = sender;

        PowerMoveStepsViewController *powermoveStepsViewController = [segue destinationViewController];
    
        NSDictionary *moveData;
        MoveType movetype = powermove;
    
        // powermoves
        if (indexPath.section == 0)
            moveData = [_powermoveListArray objectAtIndex:indexPath.row];
    
        // powermove combos
        else if (indexPath.section == 1)
            moveData = [_powermoveComboListArray objectAtIndex:indexPath.row];
    
        // freezes
        else if (indexPath.section == 2)
            moveData = [_freezesArray objectAtIndex:indexPath.row];
    
        // tricks
        else if (indexPath.section == 3)
            moveData = [_tricksArray objectAtIndex:indexPath.row];
    
        // flips
        else if (indexPath.section == 4)
            moveData = [_flipsArray objectAtIndex:indexPath.row];

        // footwork
        else if (indexPath.section == 5)
        {
            moveData = [_footworkArray objectAtIndex:indexPath.row];
            movetype = footwork;
        }
    
        // misc
        else if (indexPath.section == 6)
        {
            moveData = [_miscArray objectAtIndex:indexPath.row];
        
            if (indexPath.row == 0)
                movetype = stretching;
        }
    
        powermoveStepsViewController.moveData = moveData;
        powermoveStepsViewController.movetype = movetype;
    }
    
    else if ([segue.identifier isEqualToString:@"segueToFootworkGeneratorViewController"])
    {
        FootworkGeneratorViewController *footworkGeneratorViewController = [segue destinationViewController];
        
        footworkGeneratorViewController.moveData = [_footworkArray objectAtIndex:0];
    }
} 


#pragma mark -
#pragma mark - getter methods
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    //    _tableView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelection = YES;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
     //   footerView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = footerView;
    }
    
    return _tableView;
    
}

@end
