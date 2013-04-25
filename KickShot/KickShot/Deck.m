//
//  Deck.m
//  KickShot
//
//  Created by Austin on 4/5/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import "Deck.h"

@implementation Deck

- (id) init {
	
	return self;
}

//builds a deck with all the cards needed in a team deck for a warmup game
- (id) initAsPlayer: (CType) dTeam
{
    if (self = [super init])
    {
        cards = [[NSMutableArray alloc ] init];
        for (int i = 0; i < 17; i++)//the warmup game require 17 pass cards
        {
            Card * card = [[Card alloc] initWithValue: pass type: offense];
            card.team = dTeam;
            [cards addObject:card];
        }
        for (int i = 0; i < 5; i++)//the warmup game require 5 shot cards from each side
        {                            //also 5 intercepts and 5 block from each side
            Card * card = [[Card alloc] initWithValue: goalShotRight type: offense];
            card.team = dTeam;
            [cards addObject:card];
            Card * card1 = [[Card alloc] initWithValue: goalShotLeft type: offense];
            card.team = dTeam;
            [cards addObject:card1];
            Card * card2 = [[Card alloc] initWithValue: intercept type: defense];
            card.team = dTeam;
            [cards addObject:card2];
            Card * card3 = [[Card alloc] initWithValue: goalBlockedRight type: defense];
            card.team = dTeam;
            [cards addObject:card3];
            Card * card4 = [[Card alloc] initWithValue: goalBlockedLeft type: defense];
            card.team = dTeam;
            [cards addObject:card4];
        }
        [self shuffle];
    }
    return self;
}

//builds a deck with all the official cards needed for a warmup game
- (id) initAsOfficial
{
    if(self = [super init])
    {
        cards = [[NSMutableArray alloc ] init];
        for (int i = 0; i < 5; i++)//the warmup game require 5 direct free kicks and thats it
        {
            Card * card = [[Card alloc] initWithValue: directFreeKick type: official];
            card.team = reff;
            [cards addObject:card];
        }
        [self shuffle];
    }
    return self;
}


//simple shuffle of deck
- (void) shuffle {
    
    NSUInteger count = [cards count];
    for (uint i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = arc4random_uniform(nElements) + i;
        [cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}


//copies the last card out and deletes it from the array then returns a copy
- (Card *) draw {
    
    Card * temp2 = [cards lastObject];
    Card *temp = [[Card alloc]initWithValue:temp2.value type:temp2.type];
    temp.team = temp2.team;
    [cards removeLastObject];
    return temp;
 
}

- (Card * ) drawFromIndex:(int)number
{
    Card * temp2 = [cards objectAtIndex:number];
    Card *temp = [[Card alloc]initWithValue:temp2.value type:temp2.type];
    temp.team = temp2.team;
    [cards removeObjectAtIndex:number];
    return temp;
}

//returns how many objects are in the deck
- (NSInteger) cardsRemaining {
	return [cards count];
}

- (int) cardAtIndex: (int)number
{
    Card * temp = [cards objectAtIndex:number];
    return temp.value;
}

- (void) removeAtIndex:(int)number
{
    [cards removeObjectAtIndex:number];
}

@end
