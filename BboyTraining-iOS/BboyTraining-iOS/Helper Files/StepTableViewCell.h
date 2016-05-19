//
//  StepTableViewCell.h
//  SOLPM
//
//  Created by Ryan Badilla on 12/15/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, strong) UILabel *repsCompletedLabel;
@property (nonatomic, strong) UILabel *repsGoalLabel;

@property (nonatomic, strong) UILabel *completedNumberLabel;
@property (nonatomic, strong) UILabel *goalNumberLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
