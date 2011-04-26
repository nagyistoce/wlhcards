//
//  deck.m
//  cards
//
//  Created by Warren Holybee on 1/2/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@implementation Deck
@synthesize cards;

-(id)init {
	if (self.cards) {
		[self.cards release];
	}
	// create an empty deck
	
	cards = [[NSMutableArray alloc] init];	
	
	
	// add 52 cards by looping through 4 suits and 13 face values
	for (int suit=wSpade; suit <= wDiamond; suit++) {
		for (int card = wTwo; card <= wAce; card ++) {
			Card *tempCard = [[Card alloc] init];
			tempCard.suit = suit;
			tempCard.faceValue = card;
			[self.cards addObject:tempCard];
			[tempCard release];
		}
	}
	return self;
}


-(void)shuffle {
	
	// shuffle each card once
	int deckSize = [cards count];
	
	// loop through each card of the deck, and swap it with a random card
	for (int i=0;i<deckSize;i++) {
		int swapcard = (random()%deckSize);
		Card *tempCard = [[cards objectAtIndex:swapcard] retain];
		[cards replaceObjectAtIndex:swapcard withObject:[cards objectAtIndex:i]];
		[cards replaceObjectAtIndex:i withObject:tempCard];
		[tempCard release];
	}
}

// print each card in the deck, for testing purposes
-(void) print {
	printf("Printing a Deck...\n");
	for (int i=0;i<[cards count];i++) {
		printf("\n");
		[((Card *)[self.cards objectAtIndex:i]) print];
	}
}	

// deal a 5 or 7 card hand
// also remove the cards from the deck

-(Hand *) deal {
	int c;

	Hand *hand = [[[Hand alloc] init] autorelease]; // autorelease so caller has a chance to retain deck
	if (hand.isSevenCardHand) // number of cards to deal
		c = 7;
	else
		c = 5;
// add the cards
// loop 5 or 7 times
// add the first card of the deck to the Hand
// if successfull, remove the first card from the deck
	
	for (int i=0;i<c;i++) {
		if ([hand addCard:[cards objectAtIndex:0]]) {
			[cards removeObjectAtIndex:0];
		}
	}
	return hand;
}

-(Card *) dealCard {
	Card *newCard = [cards objectAtIndex:0];
	[newCard retain];   // This is a memory leak. Using autorelease causes crash.
	[cards removeObjectAtIndex:0];
	return newCard;
}

-(void)sort {
	[self.cards sortUsingSelector:@selector(compare:)];
}


-(void) dealloc {
	[cards release];
	[super dealloc];
}


@end
