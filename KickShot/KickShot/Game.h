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
    
}

@property (nonatomic) NSInteger ballPosition;
@property (nonatomic) NSInteger hScore, aScore;
@property (nonatomic) NSInteger activeCard;
@property (nonatomic) bool isHomeBall;
@property (nonatomic) bool shotRightTaken;
@property (nonatomic) bool shotLeftTaken;


- (id) init;
- (void) playActive;
- (void) checkWin;

@end
