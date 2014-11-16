//
//  MoveData.m
//  SOLPM
//
//  Created by Ryan Badilla on 11/15/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#import "MoveData.h"
#import "kColorConstants.h"
#import "kConstants.h"

@implementation MoveData

+ (NSDictionary *)getMoveData
{
    return nil;
}


#pragma mark -
#pragma mark - Move Arrays
+ (NSArray *)getMoveTypeArray
{
    NSArray *moveType = [[NSArray alloc] initWithObjects:
                                     MOVE_TYPE_POWERMOVES,
                                     MOVE_TYPE_POWERMOVE_COMBOS,
                                     MOVE_TYPE_FREEZES,
                                     MOVE_TYPE_FLIPS,
                                     MOVE_TYPE_MISC,
                                     nil];
    
    return moveType;
}

+ (NSArray *)getPowermoveListArray
{
    NSArray *powermoveListArray = [[NSArray alloc] initWithObjects:
                                   POWERMOVE_WINDMILLS,
                                   POWERMOVE_BABYMILLS,
                                   POWERMOVE_BELLYMILLS,
                                   POWERMOVE_NUTCRACKER_MILLS,
                                   POWERMOVE_HALOS,
                                   POWERMOVE_FLARES,
                                   POWERMOVE_ELBOW_FLARES,
                                   POWERMOVE_AIRFLARES,
                                   POWERMOVE_HEADSPINS,
                                   POWERMOVE_HANDHOPS,
                                   nil];
    
    return powermoveListArray;
}

+ (NSArray *)getFreezesArray
{
    NSArray *freezesArray = [[NSArray alloc] initWithObjects:
                             FREEZES_AIRCHAIR,
                             FREEZES_DOUBLE_AIRCHAIR,
                             FREEZES_ONE_ARM_HANDSTAND,
                             FREEZES_HOLLOWBACK,
                             FREEZES_PLANCHE,
                             nil];
    
    return freezesArray;
}

+ (NSArray *)getFlipsArray
{
    NSArray *flipsArray = [[NSArray alloc] initWithObjects:
                           FLIPS_AERIAL_CARTWHEEL,
                           FLIPS_WEBSTER,
                           FLIPS_RAIZ_FLIP,
                           FLIPS_CORKSCREW,
                           FLIPS_GAINERFLIP,
                           FLIPS_BTWIST,
                           FLIPS_BACKFLIP,
                           nil];
    
    return flipsArray;
}

+ (NSArray *)getPowermoveCombosArray
{
    NSArray * powermoveComboListArray = [[NSArray alloc] initWithObjects:
                                         COMBO_WINDMILL_TO_FLARE,
                                         COMBO_FLARE_TO_HEADSPIN,
                                         nil];
    
    return powermoveComboListArray;
}

+ (NSArray *)getMiscArray
{
    NSArray *miscArray = [[NSArray alloc] initWithObjects:MISC_STRETCHING, nil];
    
    return miscArray;
}

#pragma mark -
#pragma mark - Number of steps 
+ (NSInteger)getNumberOfStepsForMove:(NSString *)move
{
    //--------------------------------
    // powermove list
    //--------------------------------
    if ([move isEqualToString:POWERMOVE_WINDMILLS])
        return POWERMOVE_WINDMILLS_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_BABYMILLS])
        return POWERMOVE_BABYMILLS_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_BELLYMILLS])
        return POWERMOVE_BELLYMILLS_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_NUTCRACKER_MILLS])
        return POWERMOVE_NUTCRACKER_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_HALOS])
        return POWERMOVE_HALOS_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_FLARES])
        return POWERMOVE_FLARES_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_ELBOW_FLARES])
        return POWERMOVE_ELBOW_FLARES_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_AIRFLARES])
        return POWERMOVE_AIRFLARES_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_HEADSPINS])
        return POWERMOVE_HEADSPINS_STEPS_TOTAL;
    
    else if ([move isEqualToString:POWERMOVE_HANDHOPS])
        return POWERMOVE_HANDHOPS_STEPS_TOTAL;
    
    //--------------------------------
    //freezes list
    //--------------------------------
    else if ([move isEqualToString:FREEZES_AIRCHAIR])
        return FREEZES_AIRCHAIR_STEPS_TOTAL;
    
    else if ([move isEqualToString:FREEZES_DOUBLE_AIRCHAIR])
        return FREEZES_DOUBLE_AIRCHAIR_STEPS_TOTAL;
    
    else if ([move isEqualToString:FREEZES_ONE_ARM_HANDSTAND])
        return FREEZES_ONE_ARM_HANDSTAND_STEPS_TOTAL;
    
    else if ([move isEqualToString:FREEZES_HOLLOWBACK])
        return FREEZES_HOLLOWBACK_STEPS_TOTAL;
    
    else if ([move isEqualToString:FREEZES_PLANCHE])
        return FREEZES_PLANCHE_STEPS_TOTAL;

    //--------------------------------
    // flips list
    //--------------------------------
    else if ([move isEqualToString:FLIPS_AERIAL_CARTWHEEL])
        return FLIPS_AERIAL_CARTWHEEL_STEPS_TOTAL;
    
    else if ([move isEqualToString:FLIPS_WEBSTER])
        return FLIPS_WEBSTER_STEPS_TOTAL;
    
    else if ([move isEqualToString:FLIPS_RAIZ_FLIP])
        return FLIPS_RAIZ_FLIP_STEPS_TOTAL;
    
    else if ([move isEqualToString:FLIPS_CORKSCREW])
        return FLIPS_CORKSCREW_STEPS_TOTAL;
    
    else if ([move isEqualToString:FLIPS_GAINERFLIP])
        return FLIPS_GAINERFLIP_STEPS_TOTAL;
    
    else if ([move isEqualToString:FLIPS_BTWIST])
        return FLIPS_BTWIST_STEPS_TOTAL;
    
    else if ([move isEqualToString:FLIPS_BACKFLIP])
        return FLIPS_BACKFLIP_STEPS_TOTAL;
    
    //--------------------------------
    // powermove combo list string
    //--------------------------------
    else if ([move isEqualToString:COMBO_WINDMILL_TO_FLARE])
        return COMBO_WINDMILL_TO_FLARE_STEPS_TOTAL;
    
    else if ([move isEqualToString:COMBO_FLARE_TO_HEADSPIN])
        return COMBO_FLARE_TO_HEADSPIN_STEPS_TOTAL;
    
    //--------------------------------
    // misc list string
    //--------------------------------
    else if ([move isEqualToString:MISC_STRETCHING])
        return MISC_STRETCHING_STEPS_TOTAL;
    
    else
    return 0;

}


@end
