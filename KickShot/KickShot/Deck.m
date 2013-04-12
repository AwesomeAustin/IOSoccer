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

- (id) initAsPlayer
{
    if (self = [super init])
    {
        cards = [[NSMutableArray alloc ] init];
        for (int i = 0; i <= 2; i++)//the number two is replaced by howevermany are needed of specific card
        {
            Card * card = [[Card alloc] initWithValue: header type: offense];
            [cards addObject:card];
        }
    }
}

/*
 * Random sort used from this blog post
 * http://zaldzbugz.wordpress.com/2010/07/16/randomly-sort-nsarray/
 */
int randomSort(id obj1, id obj2, void *context ) {
	// returns random number -1 0 1
	return (arc4random()%3 - 1);
}

- (void) shuffle {
}


- (Card *) draw {
 
}

- (NSInteger) cardsRemaining {
	return [cards count];
}

- (NSString *) description {


}

- (void) dealloc {
}

@end
