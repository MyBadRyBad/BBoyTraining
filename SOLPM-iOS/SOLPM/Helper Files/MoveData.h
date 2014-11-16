//
//  MoveData.h
//  SOLPM
//
//  Created by Ryan Badilla on 11/15/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoveData : NSObject

+ (NSDictionary *)getMoveData;

+ (NSArray *)getMoveTypeArray;
+ (NSArray *)getPowermoveListArray;
+ (NSArray *)getFreezesArray;
+ (NSArray *)getFlipsArray;
+ (NSArray *)getPowermoveCombosArray;
+ (NSArray *)getMiscArray;

+ (NSInteger)getNumberOfStepsForMove:(NSString *)move;


@end
