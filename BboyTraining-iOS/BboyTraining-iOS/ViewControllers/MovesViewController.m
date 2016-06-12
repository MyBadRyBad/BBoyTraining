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
#import "MoveNode.h"
#import <IonIcons.h>

static NSString *kNavigationBarTitle = @"Moves";

@interface MovesViewController ()

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation MovesViewController

#pragma mark -
#pragma mark - View Controller lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _navBarHairlineImageView.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _navBarHairlineImageView.hidden = NO;
}


#pragma mark -
#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setup
- (void)setup {
    [self setupViews];
    [self setupConstaints];
    [self configureNavigationBar];
    
    // remove hairline
    _navBarHairlineImageView = [HelperFunctions findHairlineImageViewUnder:self.navigationController.navigationBar];
}

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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], NSForegroundColorAttributeName,
      shadow, NSShadowAttributeName,
      shadow, NSShadowAttributeName,
      [UIFont fontWithName:kDefaultFontName size:kDefaultNavigationBarFontSize], NSFontAttributeName,
      nil]];
    
    
    // set backbutton attributes
    NSDictionary *normalAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:kDefaultFontName size:kDefaultNavigationBarButtonFontSize], NSFontAttributeName,
                                      nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:normalAttributes
                                                forState:UIControlStateNormal];
    
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
    return [_moveNodesArray count];
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
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont fontWithName:kDefaultFontName size:kTableCellFontSize];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MoveNode *moveNode = [_moveNodesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = moveNode.categoryName;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoveNode *moveNode = [_moveNodesArray objectAtIndex:indexPath.row];
    
    // has a next category
    if (moveNode.movesArray != nil && [moveNode.movesArray count] > 0) {
        
        NSMutableArray *newArrayOfMoveNodes = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in moveNode.movesArray) {
            MoveNode *newMoveNode = [[MoveNode alloc] initWithMoveDictionary:dictionary categoryType:moveNode.categoryType];
            [newArrayOfMoveNodes addObject:newMoveNode];
        }
        
        // push a new movesViewController with subcategorys
        MovesViewController *movesViewController = [[MovesViewController alloc] init];
        movesViewController.moveNodesArray = newArrayOfMoveNodes;
        movesViewController.navigationBarTitle = moveNode.categoryName;
        
        [self.navigationController pushViewController:movesViewController animated:YES];
    } else {
        [self pushViewControllerOfCategoryType:moveNode.categoryType indexPath:indexPath];
    }
}

- (void)pushViewControllerOfCategoryType:(CategoryType)categoryType indexPath:(NSIndexPath *)indexPath {
    switch (categoryType) {
        case CategoryTypePowermoves:
            break;
        case CategoryTypePowermoveCombos:
            break;
        case CategoryTypeFreezes:
            break;
        case CategoryTypeTricks:
            break;
        case CategoryTypeFlips:
            break;
        case CategoryTypeMisc:
            break;
        case CategoryTypeFootwork:
            break;
        case CategoryTypeTools:
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark - tableView Heights
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
    
    return ((tableView.bounds.size.height - contentHeight) * 0.5) - (self.navigationController.navigationBar.frame.size.height + 20);
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame: CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    return view;
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
