//
//  Game.h
//  KickShot
//
//  Created by Austin on 4/18/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Deck.h"
#import "Card.h"

@interface Game : NSObject{
    
    Player *Player1, *Player2, *ActivePlayer;
    Deck *hDeck, *aDeck, *oDeck;
    NSInteger ballPosition;
    NSInteger hScore, aScore;
    NSInteger activeCard;
    bool isHomeBall;
    bool shotRightTaken, shotLeftTaken;
    bool Player1Active;
    
    int roll1, roll2;
    
}


@property (nonatomic) NSInteger ballPosition;
@property (nonatomic) NSInteger hScore, aScore;
@property (nonatomic) NSInteger activeCard;
@property (nonatomic) bool isHomeBall;
@property (nonatomic) bool shotRightTaken;
@property (nonatomic) bool shotLeftTaken;
@property (nonatomic) bool Player1Active;
@property (nonatomic) int roll1, roll2;

- (id) init;
- (void) playActive;
- (void) skipTurn;
- (bool) checkWin;

- (int) hDeck:(int)number;
- (int) aDeck:(int)number;
- (int) oDeck:(int)number;

- (int) hDeckRemaining;
- (int) aDeckRemaining;
- (int) oDeckRemaining;

@end
