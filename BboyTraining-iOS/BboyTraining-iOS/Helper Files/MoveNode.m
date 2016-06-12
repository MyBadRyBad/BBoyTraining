//
//  MoveNode.m
//  BboyTraining-iOS
//
//  Created by Ryan Badilla on 6/8/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "MoveNode.h"
#import "kConstants.h"

@implementation MoveNode

#pragma mark -
#pragma mark - initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        _categoryName = nil;
        _movesArray = nil;
        _moveDictionary = nil;
    }
    
    return self;
}

- (instancetype)initWithMoveDictionary:(NSDictionary *)moveDictionary categoryType:(CategoryType)categoryType {
    self = [super init];
    if (self) {
        _categoryName = moveDictionary[kSOPLMMovesNameKey];
        _categoryType = categoryType;
        _moveDictionary = moveDictionary;
        _movesArray = nil;
        
    }
    
    return self;
}

- (instancetype)initWithCategory:(NSString *)categoryName movesArray:(NSArray *)movesArray categoryType:(CategoryType)categoryType{
    self = [super init];
    if (self) {
        _categoryName = categoryName;
        _categoryType = categoryType;
        _movesArray = movesArray;
        _moveDictionary = nil;
    }
    
    return self;
}

#pragma mark -
#pragma mark - getter methods
- (NSString *)categoryName {
    return _categoryName;
}

- (NSArray *)movesArray {
    return _movesArray;
}

- (NSDictionary *)moveDictionary {
    return _moveDictionary;
}

@end
