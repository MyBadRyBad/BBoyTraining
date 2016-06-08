//
//  MovesViewController.m
//  BboyTraining-iOS
//
//  Created by Ryan Badilla on 6/5/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "MovesViewController.h"
#import "PowerMoveStepsViewController.h"
#import "FootworkGeneratorViewController.h"
#import "kColorConstants.h"
#import "HelperFunctions.h"
#import "MSCellAccessory.h"
#import "kConstants.h"
#import "MoveData.h"

static NSString *kNavigationBarTitle = @"Moves";

@interface MovesViewController ()

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

@implementation MovesViewController

#pragma mark -
#pragma mark - View Controller lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupConstaints];
    [self setUpDataArray];
    [self configureNavigationBar];
    
    // remove hairline
    _navBarHairlineImageView = [HelperFunctions findHairlineImageViewUnder:self.navigationController.navigationBar];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _navBarHairlineImageView.hidden = YES;
    
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
      [UIFont fontWithName:kDefaultFontName size:kTableCellFontSize], NSFontAttributeName,
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_moveType count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [self setupCell:cell withIndexPath:indexPath];
    
    return cell;
}

- (void)setupCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    //  cell.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont fontWithName:kDefaultFontName size:kTableCellFontSize];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [_moveType objectAtIndex:indexPath.row];
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
    
}


#pragma mark -
#pragma mark - tableView Hegihts
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableCellRowHeight;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat contentHeight = 0.0;
    for (int section = 0; section < [self numberOfSectionsInTableView: tableView]; section++) {
        for (int row = 0; row < [self tableView: tableView numberOfRowsInSection: section]; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: row inSection: section];
            contentHeight += [self tableView: tableView heightForRowAtIndexPath: indexPath];
        }
    }
    
    return ((tableView.bounds.size.height - contentHeight) * 0.5) - self.navigationController.navigationBar.frame.size.height;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame: CGRectZero];
    view.backgroundColor = [UIColor clearColor];
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
        _tableView.frame = self.view.bounds;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //    _tableView.backgroundColor = [kColorConstants blueMidnightBlue:1.0f];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelection = YES;
    }
    
    return _tableView;
    
}


@end
