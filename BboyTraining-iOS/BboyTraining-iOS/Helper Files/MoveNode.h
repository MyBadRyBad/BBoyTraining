//
//  MoveNode.h
//  BboyTraining-iOS
//
//  Created by Ryan Badilla on 6/8/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoveNode : NSObject

- (instancetype)initWithMoveDictionary:(NSDictionary *)moveDictionary;
- (instancetype)initWithCategory:(NSString *)categoryName movesArray:(NSArray *)movesArray;

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSArray *movesArray;
@property (nonatomic, strong) NSDictionary *moveDictionary;


@end
