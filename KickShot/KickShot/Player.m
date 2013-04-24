//
//  Player.m
//  KickShot
//
//  Created by Austin on 4/9/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize isHomeTeam, playableCardsLeft;


- (id) initPlayer: (bool) homeTeam
{
    if(self = [super init])
    {
        self.isHomeTeam = homeTeam;
    }
    return self;
}

- (Card*) playCard: (int) CardNum
{
    Card *temp = [[Hand objectAtIndex:CardNum] mutableCopy];
    [Hand removeObjectAtIndex:CardNum];
    return temp;
    
}

//uses bubble sort because there are only a max of 7 cards and once sorted
//should only take one pass to put the card in the right place
- (void) sortHand
{
    Card *temp1, *temp2;
    int change = 1;
    while(change > 0)
    {
        change = 0;
        for ( int i = 0 ; i < ([Hand count] -1 ); i++ )
        {
            temp1 = [Hand objectAtIndex:i];
            temp2 = [Hand objectAtIndex:(i+1)];
            if(temp1.value > temp2.value)
            {
                [Hand exchangeObjectAtIndex:i withObjectAtIndex:(i+1)];
                change++;
            }
        }
    }
    
}

- (void) checkPlayableCards: (int) possesion
{
    playableCardsLeft = false;
    Card *temp;
    for (int i = 0; i < [Hand count]; i++) {
        temp = [Hand objectAtIndex:i];
        if(temp.type == possesion)
        {
            playableCardsLeft = true;
        }
    }
    
}

- (void) addToHand: (Card*) aCard
{
    [Hand addObject:aCard];
}

- (NSInteger) cardsRemaining
{
    return Hand.count;
}

@end
