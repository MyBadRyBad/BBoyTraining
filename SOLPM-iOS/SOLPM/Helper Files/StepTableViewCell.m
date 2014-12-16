//
//  StepTableViewCell.m
//  SOLPM
//
//  Created by Ryan Badilla on 12/15/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "StepTableViewCell.h"
#import "MSCellAccessory.h"
#import "kColorConstants.h"
#import "kConstants.h"

#define STEP_LABEL_X_POS            16
#define SUB_X_POS                   100
#define NUMBER_X_POS                (SUB_X_POS + 80)

#define STEP_LABEL_Y_POS            8
#define REPS_COMPLETED_Y_POS        0
#define REPS_GOAL_Y_POS             16



@implementation StepTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor whiteColor]];
        [self setupLabels];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupLabels
{
    _stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(STEP_LABEL_X_POS, 8, (self.contentView.frame.size.width - (STEP_LABEL_X_POS * 2)), 26)];
    _stepLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:16.0f];
    _stepLabel.textColor = [UIColor whiteColor];
    
    _repsCompletedLabel = [[UILabel alloc] initWithFrame:CGRectMake(SUB_X_POS, REPS_COMPLETED_Y_POS, (self.contentView.frame.size.width - (SUB_X_POS * 2)), 26)];
    _repsCompletedLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:12.0f];
    _repsCompletedLabel.textColor = [UIColor whiteColor];
    _repsCompletedLabel.text = @"Completed:";
    
    _repsGoalLabel = [[UILabel alloc] initWithFrame:CGRectMake(SUB_X_POS, REPS_GOAL_Y_POS, (self.contentView.frame.size.width - (SUB_X_POS * 2)), 26)];
    _repsGoalLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:12.0f];
    _repsGoalLabel.textColor = [UIColor whiteColor];
    _repsGoalLabel.text = @"Goal:";
    
    _completedNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(NUMBER_X_POS, REPS_COMPLETED_Y_POS, (self.contentView.frame.size.width - NUMBER_X_POS), 26)];
    _completedNumberLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:12.0f];
    _completedNumberLabel.textColor = [UIColor whiteColor];
    
    _goalNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(NUMBER_X_POS, REPS_GOAL_Y_POS, (self.contentView.frame.size.width - NUMBER_X_POS), 26)];
    _goalNumberLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:12.0f];
    _goalNumberLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_stepLabel];
    [self.contentView addSubview:_repsCompletedLabel];
    [self.contentView addSubview:_repsGoalLabel];
    [self.contentView addSubview:_completedNumberLabel];
    [self.contentView addSubview:_goalNumberLabel];
}

@end
