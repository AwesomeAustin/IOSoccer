//
//  Player.h
//  KickShot
//
//  Created by Austin on 4/9/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "card.h"

@interface Player : NSObject{

    NSArray *Hand;
    bool isHomeTeam;
    bool playableCardsLeft;
}

-(id) initPlayer: (bool) homeTeam;

- (Card*) playCard: (int) CardNum;
- (void) checkPlayableCards;
- (void) sortHand;
- (void) addToHand: (Card*) aCard;

@end
