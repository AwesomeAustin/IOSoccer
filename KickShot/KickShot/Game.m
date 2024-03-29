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
@synthesize Player1Active;
@synthesize roll1, roll2;

- (id) init
{
    if(self = [super init])
    {
        hDeck = [[Deck alloc]initAsPlayer:home];
        aDeck = [[Deck alloc]initAsPlayer:away];
        oDeck = [[Deck alloc]initAsOfficial];
        Player1 = [[Player alloc]initPlayer:true];
        Player2 = [[Player alloc]initPlayer:false];
        ActivePlayer = Player1;
        Player1Active = true; //remove when hands implemented
        ballPosition = 0;
        hScore = aScore = 0;
        activeCard = 1;
        isHomeBall = true;
        shotRightTaken = shotLeftTaken = false;
        /*for (int i = 0; i<5; i++)
        {
            [Player1 addToHand:hDeck.draw];
            [Player2 addToHand:aDeck.draw];
        }
        [Player1 addToHand:oDeck.draw];
        [Player1 addToHand:oDeck.draw];
        [Player2 addToHand:oDeck.draw];
        [Player2 addToHand:oDeck.draw];
        */
        roll1 = roll2 = 0;
    }
    return self;
}

//action taken anytime that the play card button it hit
- (void) playActive
{
    //Card * temp = [ActivePlayer playCard:activeCard];
    Card * temp;
    if(ActivePlayer == Player1)
    {
        switch (activeCard) {//remove when hand is fixed
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
                temp = [hDeck drawFromIndex:activeCard];//temporary till get hands to fill
                break;
            case 5:
                if(oDeck.cardsRemaining>1)
                    temp = [oDeck drawFromIndex:1];
                else
                    temp = [hDeck drawFromIndex:5];
                break;
            case 6:
                if(oDeck.cardsRemaining>1)
                    temp = [oDeck drawFromIndex:1];
                else if(oDeck.cardsRemaining>0)
                    temp = [oDeck drawFromIndex:0];
                else
                    temp = [hDeck drawFromIndex:6];
                break;
            default:
                temp = [hDeck draw];//temporary till get hands to fill
                break;
        }
    }
    else
    {
        switch (activeCard) {//remove when hand is fixed
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
                temp = [aDeck drawFromIndex:activeCard];//temporary till get hands to fill
                break;
            case 5:
                if(oDeck.cardsRemaining>1)
                    temp = [oDeck drawFromIndex:1];
                else
                    temp = [aDeck drawFromIndex:5];
                break;
            case 6:
                if(oDeck.cardsRemaining>1)
                    temp = [oDeck drawFromIndex:1];
                else if(oDeck.cardsRemaining>0)
                    temp = [oDeck drawFromIndex:0];
                else
                    temp = [aDeck drawFromIndex:6];
                break;
            default:
                temp = [aDeck draw];//temporary till get hands to fill
                break;
        }
        
    }
    bool tempOfficialCardPlayed = false;
    int die1, die2;
    die1 = (rand()%5)+1;
    die2 = (rand()%5)+1;
    roll1 = die1;
    roll2 = die2;//could be used to replace local die1, die2, put in to display rolls
    
    
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
                    //[ActivePlayer addToHand:hDeck.draw];
                    ActivePlayer = Player2;
                    Player1Active = false;//remove when hand implemented
                }
                else
                {
                    ballPosition = 12 - die1 - die2;
                    //[ActivePlayer addToHand:aDeck.draw];
                    ActivePlayer = Player1;
                    Player1Active = true;//remove when hand implemented
                }
            }
            else//other team scores a goal do a kick off and back to other teams ball
            {
                isHomeBall = !isHomeBall;//turnover ball
                if(ActivePlayer == Player1)//kick off
                {
                    aScore++;
                    ballPosition = 0 + die1 + die2;
                    //[ActivePlayer addToHand:hDeck.draw];
                }
                else
                {
                    hScore++;
                    ballPosition = 0 - die1 - die2;
                    //[ActivePlayer addToHand:aDeck.draw];
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
                    //[ActivePlayer addToHand:hDeck.draw];
                    ActivePlayer = Player2;
                    Player1Active = false;//remove when hand implemented
                }
                else
                {
                    ballPosition = 12 - die1 - die2;
                    //[ActivePlayer addToHand:aDeck.draw];
                    ActivePlayer = Player1;
                    Player1Active = true;//remove when hand implemented
                }
            }
            else//other team scores a goal do a kick off and back to other teams ball
            {
                isHomeBall = !isHomeBall;//turnover ball
                if(ActivePlayer == Player1)//kick off
                {
                    hScore++;
                    ballPosition = 0 + die1 + die2;
                    //[ActivePlayer addToHand:hDeck.draw];
                }
                else
                {
                    aScore++;
                    ballPosition = 0 - die1 - die2;
                    //[ActivePlayer addToHand:aDeck.draw];
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
                //[ActivePlayer addToHand:temp];
            }
            else
            {
                aScore++;
                ballPosition = 0 - die1 - die2;
                //[ActivePlayer addToHand:temp];
            }
        }
        shotLeftTaken = shotRightTaken = false;//reset flags
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
                if ((ActivePlayer == Player1 && isHomeBall)||
                    (ActivePlayer == Player2 && !isHomeBall))
                    //only does a shot if on offense otherwise discards
                {
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
                }
                break;
            case goalShotLeft:
                //roll both if sum gets to goal than possible score
                //if not countered, otherwise a turn over
                if ((ActivePlayer == Player1 && isHomeBall)||
                    (ActivePlayer == Player2 && !isHomeBall))
                    //only does a shot if on offense otherwise discards
                {
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
                //[ActivePlayer addToHand:hDeck.draw];
            }
            else
            {
                if(oDeck.cardsRemaining == 0)
                {
                    //[ActivePlayer addToHand:hDeck.draw];
                }
                else
                {
                    //[ActivePlayer addToHand:oDeck.draw];
                }
                tempOfficialCardPlayed = false;
            }
            [ActivePlayer sortHand];
            ActivePlayer = Player2;
            Player1Active = false;//remove when hand implemented
        }
        else
        {
            if(tempOfficialCardPlayed == false)
            {
                //[ActivePlayer addToHand:aDeck.draw];
            }
            else
            {
                if(oDeck.cardsRemaining == 0)
                {
                    //[ActivePlayer addToHand:aDeck.draw];
                }
                else
                {
                    //[ActivePlayer addToHand:oDeck.draw];
                }
                tempOfficialCardPlayed = false;
            }
            [ActivePlayer sortHand];
            ActivePlayer = Player1;
            Player1Active = true;//remove when hand implemented
        }
    }
    [self checkWin];
}

//if the player wishes to skip thier turn
- (void) skipTurn
{
    if(ActivePlayer == Player1)
    {
        ActivePlayer = Player2;
        Player1Active = false;//remove when hand implemented
    }
    else
    {
        ActivePlayer = Player1;
        Player1Active = true;//remove when hand implemented
    }
}
//checks for an endgame status
//probably more aptley named checkEndStatus
- (bool) checkWin
{
    //if (Player1.cardsRemaining < 7 && Player2.cardsRemaining < 7)
    if(hDeck.cardsRemaining < 7 && aDeck.cardsRemaining < 7)
    {
        return true;
    }
    return false;
}


- (int) hDeck:(int)number
{
    return [hDeck cardAtIndex:number];
}

- (int) aDeck:(int)number
{
    return [aDeck cardAtIndex:number];
}

- (int) oDeck:(int)number
{
    return [oDeck cardAtIndex:number];
}

- (int) hDeckRemaining{return [hDeck cardsRemaining];}
- (int) aDeckRemaining{return [aDeck cardsRemaining];}
- (int) oDeckRemaining{return [oDeck cardsRemaining];}


@end
