//
//  HelperFunctions.m
//  SOLPM
//
//  Created by Ryan Badilla on 12/24/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "HelperFunctions.h"

@implementation HelperFunctions

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
