//
//  Card.h
//  KickShot
//
//  Created by Austin on 4/4/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
header, endCName//fill in the rest of the cards and off cards
} CName;

typedef enum {
    home, away, reff, endCType
} CType;

typedef enum {
    offense, defense, official
} PlayType;



@interface Card : NSObject
{

    CType team;
    CName value;
    PlayType type;
    
}

@property (nonatomic) CName value;
@property (nonatomic) CType type;

- (id) initWithValue:(CName) aValue type:(PlayType) aPlay;

@end
