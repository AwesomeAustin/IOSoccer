//
//  Deck.h
//  KickShot
//
//  Created by Austin on 4/5/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject {
    
@private
	NSMutableArray *cards;
}

- (void) shuffle;
- (Card *) draw;
- (NSInteger) cardsRemaining;

@end
