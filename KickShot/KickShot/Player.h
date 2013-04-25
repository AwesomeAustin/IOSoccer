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

@private
    NSMutableArray *Hand;
    bool isHomeTeam;
    bool playableCardsLeft;
}

@property (nonatomic) bool isHomeTeam;
@property (nonatomic) bool playableCardsLeft;

-(id) initPlayer: (bool) homeTeam;

- (Card*) playCard: (int) CardNum;
- (void) checkPlayableCards: (int) possesion;
- (void) sortHand;
- (void) addToHand: (Card*) aCard;
- (int) cardsRemaining;

@end
