//
//  HelperFunctions.h
//  SOLPM
//
//  Created by Ryan Badilla on 12/24/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HelperFunctions : NSObject

+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (void)printAvailableFonts;

@end
