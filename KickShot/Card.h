//
//  Card.h
//  KickShot
//
//  Created by Austin on 4/4/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    bicycleKick, corner, directFreeKick, dribble, goalBlockedRight, goalBlockedLeft, goaliePunt, goalShotRight, goalShotLeft, header, intercept, offside, pass, penaltyKick, refThrowIn, slideTackle, throwIn, wildCard, endCName
} CName;//actual card names

typedef enum {
    home, away, reff, endCType
} CType;//what team they belong to

typedef enum {
    offense, defense, official, endPlayType
} PlayType;//how you play them



@interface Card : NSObject
{
    
    CType team;
    CName value;
    PlayType type;
    
}

@property (nonatomic) CName value;
@property (nonatomic) CType team;
@property (nonatomic) PlayType type;

- (id) initWithValue:(CName) aValue type:(PlayType) aPlay;

@end
