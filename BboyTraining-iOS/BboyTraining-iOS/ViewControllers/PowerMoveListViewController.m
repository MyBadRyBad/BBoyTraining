//
//  MoveListViewController.m
//  BboyTraining-iOS
//
//  Created by Ryan Badilla on 11/12/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "PowerMoveListViewController.h"
#import "PowerMoveStepsViewController.h"
#import "FootworkGeneratorViewController.h"
#import "kColorConstants.h"
#import "MSCellAccessory.h"
#import "kConstants.h"
#import "MoveData.h"


static NSString *kNavigationBarTitle = @"Bboy Training";

@interface PowerMoveListViewController ()

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

@implementation PowerMoveListViewController

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
    self.navigationController.navigationBar.barTintColor = [kColorConstants navigationBarColor:1.0f];
    self.navigationController.navigationBar.tintColor = [kColorConstants navigationBarColor:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.topItem.title = kNavigationBarTitle;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor whiteColor],
       NSShadowAttributeName : shadow,
       NSFontAttributeName : [UIFont fontWithName:kNavigationBarTitle size:kDefaultNavigationBarFontSize]}];
}

- (void)setUpDataArray
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"moves" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    _powermoveListArray = [dict objectForKey:@"powermoves"];
    _powermoveComboListArray = [dict objectForKey:@"combos"];
    _freezesArray = [dict objectForKey:@"freezes"];
    _tricksArray = [dict objectForKey:@"tricks"];
    _flipsArray = [dict objectForKey:@"flips"];
    _miscArray = [dict objectForKey:@"misc"];
    _footworkArray = [dict objectForKey:@"footwork"];
    _toolsArray = [dict objectForKey:@"tools"];
    
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
    if (section == 0)
        return [_powermoveListArray count];
    else if (section == 1)
        return [_powermoveComboListArray count];
    else if (section == 2)
        return [_freezesArray count];
    else if (section == 3)
        return [_tricksArray count];
    else if (section == 4)
        return [_flipsArray count];
    else if (section == 5)
        return [_footworkArray count];
    else if (section == 6)
        return [_miscArray count];
    else
        return [_toolsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName;
    NSDictionary *moveDictionary;
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        backgroundView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        
        cell.selectedBackgroundView = backgroundView;
    }
    
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
    
    if (indexPath.section == 7 && indexPath.row == 0)
        [self performSegueWithIdentifier:@"segueToFootworkGeneratorViewController" sender:indexPath];
    else if (indexPath.section == 7 && indexPath.row == 1)
        [self performSegueWithIdentifier:@"segueToCustomIncrementerViewController" sender:indexPath];
    else
        [self performSegueWithIdentifier:@"segueToPowerMoveStepsViewController" sender:indexPath];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    //Set the header value for each section. We return the letter for this group.
    return [_moveType objectAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
    view.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, tableView.frame.size.width, 18)];
    label.font = [UIFont fontWithName:@"OpenSans-Light" size:18.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;

     NSString *string = [_moveType objectAtIndex:section];
    
    [label setText:string];
    
    [view addSubview:label];
    return view;
}

#pragma mark - 
#pragma mark - Navigation
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
        _tableView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelection = YES;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
        footerView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        _tableView.tableFooterView = footerView;
    }
    
    return _tableView;
    
}

@end
