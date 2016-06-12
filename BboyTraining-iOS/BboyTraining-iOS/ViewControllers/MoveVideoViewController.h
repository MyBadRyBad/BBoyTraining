//
//  MoveVideoViewController
//  SOLPM
//
//  Created by Ryan Badilla on 11/12/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import "kConstants.h"


@interface MoveVideoViewController : UIViewController

@property (nonatomic) MoveType moveType;

@property (nonatomic, strong) NSString *moveName;
@property (nonatomic, strong) NSString *moveDescription;
@property (nonatomic, strong) NSString *videoString;
@property (nonatomic, strong) NSNumber *stepNumber;
@property (nonatomic, strong) NSNumber *incrementCount;
@property (nonatomic, strong) NSNumber *goal;

@property (nonatomic, strong) UILabel *goalLabel;
@property (nonatomic, strong) UILabel *goalTotalLabel;
@property (nonatomic, strong) UILabel *repetitionsLabel;
@property (nonatomic, strong) UILabel *repetitionsTotalLabel;

@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) UIButton *incrementerButton;

@end
