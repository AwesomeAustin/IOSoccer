//
//  Card.m
//  KickShot
//
//  Created by Austin on 4/4/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize value,type;

- (id) initWithValue:(CName) aValue type:(CType) aType {
	if(self = [super init]) {
		self.value = aValue;
		self.type = aType;
	}
	return self;
}

@end
