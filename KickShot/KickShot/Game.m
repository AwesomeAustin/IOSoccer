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
@synthesize shotRightTaken;
@synthesize shotLeftTaken;

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
        shotRightTaken = shotLeftTaken = false;
    }
    return self;
}

//action taken anytime that the play card button it hit
- (void) playActive
{
    //need to check move validity before doing it in another function in player
    Card * temp = [ActivePlayer playCard:activeCard];
    bool tempOfficialCardPlayed = false;
    int die1, die2;
    die1 = (rand()%5)+1;
    die2 = (rand()%5)+1;
    
    if (shotRightTaken || shotLeftTaken)//if shot was taken
    {
        if (temp.value == goalBlockedRight)
        {
            if(shotRightTaken)//proper block
            {
                isHomeBall = !isHomeBall;//turnover
                if(ActivePlayer == Player1)//goalie block and kick
                {
                    ballPosition = -12 + die1 + die2;
                    [ActivePlayer addToHand:hDeck.draw];
                    ActivePlayer = Player2;
                }
                else
                {
                    ballPosition = 12 - die1 - die2;
                    [ActivePlayer addToHand:aDeck.draw];
                    ActivePlayer = Player1;
                }
            }
            else//other team scores a goal do a kick off and back to other teams ball
            {
                isHomeBall = !isHomeBall;//turnover ball
                if(ActivePlayer == Player1)//kick off
                {
                    hScore++;
                    ballPosition = 0 + die1 + die2;
                    [ActivePlayer addToHand:hDeck.draw];
                }
                else
                {
                    aScore++;
                    ballPosition = 0 - die1 - die2;
                    [ActivePlayer addToHand:aDeck.draw];
                }
            }
        }
        else if (temp.value == goalBlockedLeft)
        {
            if(shotLeftTaken)//proper block
            {
                isHomeBall = !isHomeBall;//turnover
                if(ActivePlayer == Player1)//goalie block and kick
                {
                    ballPosition = -12 + die1 + die2;
                    [ActivePlayer addToHand:hDeck.draw];
                    ActivePlayer = Player2;
                }
                else
                {
                    ballPosition = 12 - die1 - die2;
                    [ActivePlayer addToHand:aDeck.draw];
                    ActivePlayer = Player1;
                }
            }
            else//other team scores a goal do a kick off and back to other teams ball
            {
                isHomeBall = !isHomeBall;//turnover ball
                if(ActivePlayer == Player1)//kick off
                {
                    hScore++;
                    ballPosition = 0 + die1 + die2;
                    [ActivePlayer addToHand:hDeck.draw];
                }
                else
                {
                    aScore++;
                    ballPosition = 0 - die1 - die2;
                    [ActivePlayer addToHand:aDeck.draw];
                }
            }
        }
        else//didn't play a block card do kickoff instead and give card back
        {
            isHomeBall = !isHomeBall;//turnover ball
            if(ActivePlayer == Player1)//kick off
            {
                hScore++;
                ballPosition = 0 + die1 + die2;
                [ActivePlayer addToHand:temp];
            }
            else
            {
                aScore++;
                ballPosition = 0 - die1 - die2;
                [ActivePlayer addToHand:temp];
            }
        }
    }
    else
    {
        switch (temp.value)
        {
            case pass:
                //roll two die go higher number
                //if either are a one its a turn over
                if ((ActivePlayer == Player1 && isHomeBall)||
                    (ActivePlayer == Player2 && !isHomeBall))
                //only does a pass if on offense otherwise discards
                {
                    if (die1 == 1 || die2 == 1)
                        isHomeBall = !isHomeBall;//turn over
                    else
                    {
                        if(die1 > die2)
                        {
                            if(isHomeBall == true)
                                ballPosition += die1;
                            else
                                ballPosition -= die1;
                        }
                        else
                        {
                            if(isHomeBall == true)
                                ballPosition += die2;
                            else
                                ballPosition -= die2;//add in score possibility
                        }
                        if (ballPosition > 12)
                            ballPosition = 12;
                        if(ballPosition < -12)
                            ballPosition = -12;
                        //can't go out of bounds
                    }
                }
                //can not score off pass in warmup game
                break;
            case goalShotRight:
                //roll both if sum gets to goal than possible score
                //if not countered, otherwise a turn over
                if (ActivePlayer == Player1)
                {
                    if(die1 + die2 + ballPosition >= 12)
                    {
                        shotRightTaken = true;
                        //shot taken wait and see if they play a shot block right
                    }
                    else
                    {
                        isHomeBall = !isHomeBall;//missed and turn over on spot
                    }
                }
                else
                {
                    if(ballPosition - (die1 + die2) <= -12)
                    {
                        shotRightTaken = true;
                        //shot taken wait and see if a shot block right is played
                    }
                    else
                    {
                        isHomeBall = !isHomeBall;//missed and turn over on spot
                    }
                }
                break;
            case goalShotLeft:
                //roll both if sum gets to goal than possible score
                //if not countered, otherwise a turn over
                if (ActivePlayer == Player1)
                {
                    if(die1 + die2 + ballPosition >= 12)
                    {
                        shotLeftTaken = true;
                        //shot taken wait and see if they play a shot block left
                    }
                    else
                    {
                        isHomeBall = !isHomeBall;//missed and turn over on spot
                    }
                }
                else
                {
                    if(ballPosition - (die1 + die2) <= -12)
                    {
                        shotLeftTaken = true;
                        //shot taken wait and see if a shot block left is played
                    }
                    else
                    {
                        isHomeBall = !isHomeBall;//missed and turn over on spot
                    }
                }
                break;
            case intercept:
                //roll both die get ball on all except snake eyes
                if ((ActivePlayer == Player1 && !isHomeBall)||
                    (ActivePlayer == Player2 && isHomeBall))
                //only plays if on defense otherwise discards
                {
                    if(die1 > 1 || die2 > 1)
                        isHomeBall = !isHomeBall; // turn over nothing happens otherwise
                }
                break;
            case goalBlockedRight:
                //if correct side ball gets turned over, else other team score starts
                //with kick from midfield
                break;
            case goalBlockedLeft:
                //ditto
                break;
            case directFreeKick:
                //roll best of two get a one on either die its a turn over
                if((ActivePlayer == Player1 && isHomeBall)||
                   (ActivePlayer == Player2 && !isHomeBall))//if played by offense
                {
                    if (die1 == 1 || die2 == 1)
                        isHomeBall = !isHomeBall;//turn over
                    else
                    {
                        if(die1 > die2)
                        {
                            if(isHomeBall == true)
                                ballPosition += die1;
                            else
                                ballPosition -= die1;
                        }
                        else
                        {
                            if(isHomeBall == true)
                                ballPosition += die2;
                            else
                                ballPosition -= die2;//add in score possibility
                        }
                        if(ballPosition > 12)
                            ballPosition = 12;
                        if(ballPosition < -12)
                            ballPosition = -12;
                        //no out of bounds
                    }
                }
                else//played by defense
                {
                    if (die1 != 1 && die2 != 1)
                    {
                        isHomeBall = !isHomeBall;//turn over
                        if(die1 > die2)
                        {
                            if(isHomeBall == true)
                                ballPosition += die1;
                            else
                                ballPosition -= die1;
                        }
                        else
                        {
                            if(isHomeBall == true)
                                ballPosition += die2;
                            else
                                ballPosition -= die2;//add in score possibility
                        }
                        if(ballPosition > 12)
                            ballPosition = 12;
                        if(ballPosition < -12)
                            ballPosition = -12;
                        //no out of bounds
                    }
                }
                tempOfficialCardPlayed = true;
                //can not score off of this in warm up game
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
                if(oDeck.cardsRemaining == 0)
                    [ActivePlayer addToHand:hDeck.draw];
                else
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
                if(oDeck.cardsRemaining == 0)
                    [ActivePlayer addToHand:aDeck.draw];
                else
                    [ActivePlayer addToHand:oDeck.draw];
            }
            [ActivePlayer sortHand];
            ActivePlayer = Player1;
        }
    }
    [self checkWin];
}


//checks for an endgame status 
- (void) checkWin
{
    if (Player1.cardsRemaining < 7 && Player2.cardsRemaining < 7)
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


@end
