//
//  kConstants.h
//  SOLPM
//
//  Created by Ryan Badilla on 11/13/14.
//  Copyright (c) 2014 Newdesto. All rights reserved.
//

#ifndef SOLPM_kConstants_h
#define SOLPM_kConstants_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum MoveType
{
    powermove,
    footwork,
    stretching
} MoveType;

////////////////////////////////////////
////////////////////////////////////////
//
// Global Font Settings
//
////////////////////////////////////////
////////////////////////////////////////

static CGFloat const kDefaultNavigationBarFontSize = 24.0f;
static CGFloat const kTableCellFontSize = 30.0f;
static CGFloat const kTableCellRowHeight = 50.0f;

static NSString *const kDefaultFontName = @"Lato-Light";
static NSString *const kDefaultFontNameBold = @"Lato-Bold";

////////////////////////////////////////
////////////////////////////////////////
//
// Move Dictionary Keys
//
////////////////////////////////////////
////////////////////////////////////////
static NSString *const kMovesMovesKey = @"moves";
static NSString *const kMovesPowermovesKey = @"powermoves";
static NSString *const kMovesCombosKey = @"combos";
static NSString *const kMovesFreezesKey = @"freezes";
static NSString *const kMovesTricksKey = @"tricks";
static NSString *const kMovesFlipsKey = @"flips";
static NSString *const kMovesMiscKey = @"misc";
static NSString *const kMovesFootworkKey = @"footwork";
static NSString *const kMovesToolsKey = @"tools";

static NSString* const kFootworkNameKey = @"footworkName";
static NSString* const kFootworkCategoryKey = @"footworkCategory";

static NSString* const kUserDefaultsFWCombosKey = @"savedFootworkCombos";

// SOLPM keys
static NSString* const kSOPLMMovesNameKey = @"name";
static NSString* const kSOPLMMovesStepDescriptionKey = @"stepDescription";
static NSString* const kSOPLMMovesStepVideoKey = @"stepVideo";
static NSString* const kSOPLMMovesStepGoalNumberKey = @"stepGoalNumber";
static NSString* const kSOPLMMovesStepIncrementNumber = @"stepIncrementNumber";
static NSString* const kSOPLMMovesStepRepTotal = @"stepRepTotal";


//--------------------------------
//--------------------------------
//
// Move Strings
//
//--------------------------------
//--------------------------------
// Move type strings

static NSString *const kMoveTypeMoves = @"Moves";
static NSString *const kMoveTypePowermoves = @"Powermoves";
static NSString *const kMoveTypePowermoveCombos = @"Powermove combos";
static NSString *const kMoveTypeFreezes = @"Freezes";
static NSString *const kMoveTypeFlips = @"Flips";
static NSString *const kMoveTypeTricks =  @"Tricks";
static NSString *const kMoveTypeFootwork =  @"Footwork";
static NSString *const kMoveTypeMisc = @"Misc";
static NSString *const kMoveTypeTools =  @"Tools";
 
// powermove list strings

#define POWERMOVE_WINDMILLS @"Windmills"
#define POWERMOVE_BABYMILLS @"Babymills"
#define POWERMOVE_BELLYMILLS @"Bellymills"
#define POWERMOVE_NUTCRACKER_MILLS @"Nutcracker mills"
#define POWERMOVE_HALOS @"Halos"
#define POWERMOVE_FLARES @"Flares"
#define POWERMOVE_ELBOW_FLARES @"Elbow Flares"
#define POWERMOVE_AIRFLARES @"Airflares"
#define POWERMOVE_HEADSPINS @"Headspins"
#define POWERMOVE_HANDHOPS @"Hand Hops"

// freezes list strings
#define FREEZES_AIRCHAIR @"Airchair"
#define FREEZES_DOUBLE_AIRCHAIR @"Double Airchair"
#define FREEZES_ONE_ARM_HANDSTAND @"One-arm Handstand"
#define FREEZES_HOLLOWBACK @"Hollowback"
#define FREEZES_PLANCHE @"Planche"

// flips list strings
#define FLIPS_AERIAL_CARTWHEEL @"Aerial Cartwheel"
#define FLIPS_WEBSTER @"Webster"
#define FLIPS_RAIZ_FLIP @"Raiz Flip"
#define FLIPS_CORKSCREW @"Corkscrew"
#define FLIPS_GAINERFLIP @"Gainerflip"
#define FLIPS_BTWIST @"Btwist"
#define FLIPS_BACKFLIP @"Backflip"

// powermove combo list string
#define COMBO_WINDMILL_TO_FLARE @"Windmill to Flare"
#define COMBO_FLARE_TO_HEADSPIN @"Flare to Headspin"

// misc list string
#define MISC_STRETCHING @"Stretching"

//footwork
#define FOOTWORK_FOURSTEP @"Fourstep"
#define FOOTWORK_THREESTEP @"Threestep"
#define FOOTWORK_SEVENSTEP @"Sevenstep"

//freezes
#define FREEZES_BABYFREEZE @"Babyfreeze"
#define FREEZES_CHAIRFREEZE @"Chairfreeze"
#define FREEZES_ELBOW_HANDSTAND @"Elbow Handstand"
#define FREEZES_HEADSTAND @"Headstand"
#define FREEZES_AIRBABY @"Airbaby"
#define FREEZES_HANDSTAND @"Handstand"
#define FREEZES_RUMMENIGGE @"Rummenigge"
//--------------------------------
//--------------------------------
//
// Amount of steps
//
//--------------------------------
//--------------------------------
// powermove list
#define POWERMOVE_WINDMILLS_STEPS_TOTAL 16
#define POWERMOVE_BABYMILLS_STEPS_TOTAL 10
#define POWERMOVE_BELLYMILLS_STEPS_TOTAL 13
#define POWERMOVE_NUTCRACKER_STEPS_TOTAL 16
#define POWERMOVE_HALOS_STEPS_TOTAL 16
#define POWERMOVE_FLARES_STEPS_TOTAL 16
#define POWERMOVE_ELBOW_FLARES_STEPS_TOTAL 16
#define POWERMOVE_AIRFLARES_STEPS_TOTAL 16
#define POWERMOVE_HEADSPINS_STEPS_TOTAL 16
#define POWERMOVE_HANDHOPS_STEPS_TOTAL 16

// freezes list strings
#define FREEZES_AIRCHAIR_STEPS_TOTAL 16
#define FREEZES_DOUBLE_AIRCHAIR_STEPS_TOTAL 16
#define FREEZES_ONE_ARM_HANDSTAND_STEPS_TOTAL 16
#define FREEZES_HOLLOWBACK_STEPS_TOTAL 16
#define FREEZES_PLANCHE_STEPS_TOTAL 16

// flips list strings
#define FLIPS_AERIAL_CARTWHEEL_STEPS_TOTAL 16
#define FLIPS_WEBSTER_STEPS_TOTAL 16
#define FLIPS_RAIZ_FLIP_STEPS_TOTAL 16
#define FLIPS_CORKSCREW_STEPS_TOTAL 16
#define FLIPS_GAINERFLIP_STEPS_TOTAL 16
#define FLIPS_BTWIST_STEPS_TOTAL 16
#define FLIPS_BACKFLIP_STEPS_TOTAL 16

// powermove combo list string
#define COMBO_WINDMILL_TO_FLARE_STEPS_TOTAL 16
#define COMBO_FLARE_TO_HEADSPIN_STEPS_TOTAL 16

// misc list string
#define MISC_STRETCHING_STEPS_TOTAL 16


#endif
