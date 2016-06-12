//
//  MoveNode.h
//  BboyTraining-iOS
//
//  Created by Ryan Badilla on 6/8/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum CategoryType {
    CategoryTypePowermoves,
    CategoryTypePowermoveCombos,
    CategoryTypeFreezes,
    CategoryTypeTricks,
    CategoryTypeFlips,
    CategoryTypeMisc,
    CategoryTypeFootwork,
    CategoryTypeTools
} CategoryType;

@interface MoveNode : NSObject

- (instancetype)initWithMoveDictionary:(NSDictionary *)moveDictionary categoryType:(CategoryType)categoryType;
- (instancetype)initWithCategory:(NSString *)categoryName movesArray:(NSArray *)movesArray categoryType:(CategoryType)categoryType;

@property (nonatomic, assign) CategoryType categoryType;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSArray *movesArray;
@property (nonatomic, strong) NSDictionary *moveDictionary;


@end
