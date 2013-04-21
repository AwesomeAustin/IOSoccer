//
//  Game.m
//  KickShot
//
//  Created by Austin on 4/18/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize ballPosition;
@synthesize hScore, aScore;
@synthesize activeCard;
@synthesize isHomeBall;

- (id) init
{
    if(self = [super init])
    {
        Player1 = [[Player alloc]initPlayer:true];
        Player2 = [[Player alloc]initPlayer:false];
        ActivePlayer = Player1;
        hDeck = [[Deck alloc]initAsPlayer:home];
        aDeck = [[Deck alloc]initAsPlayer:away];
        oDeck = [[Deck alloc]initAsOfficial];
        ballPosition = 0;
        hScore = aScore = 0;
        activeCard = 1;
        isHomeBall = true;
    }
    return self;
}

//action taken anytime that the play card button it hit
- (void) playActive
{
    //need to check move validity before doing it in another function in player
    Card * temp = [ActivePlayer playCard:activeCard];
    bool tempOfficialCardPlayed = false;
    switch (temp.value) {
        case pass:
            //do pass stuff
            break;
        case goalShotRight:
            //
            break;
        case goalShotLeft:
            //
            break;
        case intercept:
            //
            break;
        case goalBlockedRight:
            //
            break;
        case goalBlockedLeft:
            //
            break;
        case directFreeKick:
            //
            tempOfficialCardPlayed = true;
            break;
            //add more in to finish for each card listed in enum CName
        default:
            //have it point out that a blank card was played
            break;
    }
    if (ActivePlayer == Player1)
    {
        if(tempOfficialCardPlayed == false)
        {
            [ActivePlayer addToHand:hDeck.draw];
        }
        else
        {
            [ActivePlayer addToHand:oDeck.draw];
        }
        [ActivePlayer sortHand];
        ActivePlayer = Player2;
    }
    else
    {
        if(tempOfficialCardPlayed == false)
        {
            [ActivePlayer addToHand:aDeck.draw];
        }
        else
        {
            [ActivePlayer addToHand:oDeck.draw];
        }
        [ActivePlayer sortHand];
        ActivePlayer = Player1;

    }
    [self checkWin];
}


//checks for an endgame status 
- (void) checkWin
{
    if (!Player1.playableCardsLeft)
    {
        if(!Player2.playableCardsLeft)
        {
            if(hScore > aScore)
            {
                //do action for home win
            }
            else if (aScore > hScore)
            {
                //do action for away win
            }
            else
            {
                //do action for tie
            }
            //do action that happens no matter how it ends
        }
    }
    
}


@end
