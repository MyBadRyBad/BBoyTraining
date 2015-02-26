//
//  FootworkGeneratorViewController.m
//  SOLPM
//
//  Created by Ryan Badilla on 12/24/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "FootworkGeneratorViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PowerMoveMainViewController.h"
#import "kColorConstants.h"
#import "kConstants.h"
#import "HelperFunctions.h"
#import "MSCellAccessory.h"
#import "MoveData.h"

@interface FootworkGeneratorViewController ()
{
    NSMutableArray *_footworkArray;
    NSMutableArray *_footworkCategoryArray;
}

@end

@implementation FootworkGeneratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - tableSetup
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
    [self setupTableHeaderView:_tableView];
    [_tableView setAllowsSelection:YES];
    
    [self.view addSubview:_tableView];
}

- (void)setupTableHeaderView:(UITableView *)tableView
{
    
    CGRect headerFrame = CGRectMake(0, 0, _tableView.frame.size.width, 60);
    
    CGRect generateButtonFrame = CGRectMake(0, 0, 100, 40);
    CGPoint generateButtonCenter = CGPointMake(_tableView.frame.size.width * 0.5, headerFrame.size.height - 30);
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:headerFrame];
    
    UIButton *generateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    generateButton = [self setupButton:generateButton frame:generateButtonFrame center:generateButtonCenter buttonTitle:@"Generate" fontSize:14.0f isCircle:NO];

    [headerView addSubview:generateButton];
    
    tableView.tableHeaderView = headerView;
}

-(UIButton *)setupButton:(UIButton *)button frame:(CGRect)frame center:(CGPoint)center buttonTitle:(NSString *)buttonTitle fontSize:(CGFloat)fontSize isCircle:(BOOL)isCircle
{
    
    button.frame = frame;
    button.center = center;
    
    button.clipsToBounds = YES;
    button.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 2.0f;
    if (isCircle)
        button.layer.cornerRadius = button.frame.size.width * 0.5;
    else
        button.layer.cornerRadius = 10;
        
    button.clipsToBounds = YES;
    
    button.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:fontSize];

    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateSelected];
    [button setTitle:buttonTitle forState:UIControlStateHighlighted];

    [button setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueWetAsphalt:1.0f]] forState:UIControlStateNormal];
    [button setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateSelected];
    [button setBackgroundImage:[HelperFunctions imageWithColor:[kColorConstants blueMidnightBlue:1.0f]] forState:UIControlStateHighlighted];

    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(buttonRelease:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [button addTarget:self action:@selector(buttonDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [button addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchCancel];
    
    return button;
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
        [self performSegueWithIdentifier:@"segueToPowerMoveMainViewControllerFromFootworkGenerator" sender:indexPath];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = sender;
    PowerMoveMainViewController *powermoveMainViewController = [segue destinationViewController];
    NSString *moveName = [_footworkArray objectAtIndex:indexPath.row];

    powermoveMainViewController.moveName = moveName;
    
    powermoveMainViewController.moveType = stretching;
        
    powermoveMainViewController.stepNumber = [NSNumber numberWithInteger: indexPath.row + 1];
    powermoveMainViewController.moveDescription = nil;
    
    powermoveMainViewController.moveType = footwork;
    powermoveMainViewController.moveName = moveName;
    powermoveMainViewController.videoString = [moveName lowercaseString];


}




#pragma mark -
#pragma mark - backButtonPressed
- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - menuButtonPressed
- (void)buttonPress:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.1, 1.1);
}

- (void)buttonRelease:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [self generateFootwork];
}

- (void)buttonDragExit:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

- (void)buttonCancel:(UIButton *)button
{
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

#pragma mark -
#pragma mark - generateFootwork
-(void)generateFootwork
{
    _footworkArray = nil;
    _footworkArray = [[NSMutableArray alloc] init];
    
    _footworkCategoryArray = nil;
    _footworkCategoryArray = [[NSMutableArray alloc] init];
    
    int randSize = (arc4random() % 7) + 4;
    for (int index = 0; index < randSize; index++)
    {
        int footworkIndex = (arc4random() % 10);
        NSArray *footwork = [self getFootwork:footworkIndex];
        int randomMove = (arc4random() % [footwork count]);
        
        NSString *footworkName = [footwork objectAtIndex:randomMove];
        NSString *footworkCategory = [self getFootworkCategory:footworkIndex];
        
        // check if there are duplicate freezes one after another
        if (index > 0)
        {
            NSString *previousFootworkName = [_footworkArray objectAtIndex:(index - 1)];
            NSString *previousFootworkCategory = [_footworkCategoryArray objectAtIndex:(index - 1)];
            
            // there is a duplicate freeze, re
            if ([footworkName isEqualToString:previousFootworkName] &&
                [footworkCategory isEqualToString:previousFootworkCategory])
            {
                while ([footworkName isEqualToString:previousFootworkName])
                {
                    int footworkIndexDup = (arc4random() % 10);
                    NSArray *footworkDup = [self getFootwork:footworkIndexDup];
                    int randomMoveDup = (arc4random() % [footworkDup count]);
                    
                    footworkName = [footworkDup objectAtIndex:randomMoveDup];
                    footworkCategory = [self getFootworkCategory:footworkIndexDup];
                }
            }
        }
        
        [_footworkArray addObject:footworkName];
        [_footworkCategoryArray addObject:footworkCategory];
    }
    
    [_tableView reloadData];
}

-(NSArray *)getFootwork:(NSInteger)index
{
    if (index == 0)
        return [_moveData objectForKey:@"inYourFace"];
    else if (index == 1)
        return [_moveData objectForKey:@"hook&sling"];
    else if (index == 2)
        return [_moveData objectForKey:@"backbone"];
    else if (index == 3)
        return [_moveData objectForKey:@"circulating"];
    else if (index == 4)
        return [_moveData objectForKey:@"atomicStyle"];
    else if (index == 5)
        return [_moveData objectForKey:@"pretzels"];
    else if (index == 6)
        return [_moveData objectForKey:@"godowns"];
    else if (index == 7)
        return [_moveData objectForKey:@"nohanded"];
    else if (index == 8)
        return [_moveData objectForKey:@"misc"];
    else
        return [_moveData objectForKey:@"freezes"];
    
}

-(NSString *)getFootworkCategory:(NSInteger)index
{
    if (index == 0)
        return @"In Your Face";
    else if (index == 1)
        return @"Hook & Sling";
    else if (index == 2)
        return @"Backbone Basics";
    else if (index == 3)
        return @"Circulating";
    else if (index == 4)
        return @"Atomic Style";
    else if (index == 5)
        return @"Pretzels";
    else if (index == 6)
        return @"Go Downs";
    else if (index == 7)
        return @"No handed";
    else if (index == 8)
        return @"Misc";
    else
        return @"Freezes";
}

@end
