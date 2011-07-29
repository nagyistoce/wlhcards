//
//  Hand.m
//  cards
//
//  Created by Warren Holybee on 1/3/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "Hand.h"
#import "Deck.h"

@implementation Hand
@synthesize cards, isSevenCardHand;
@synthesize highCardRank;


-(id) init {
	isSevenCardHand = FALSE;
	cards = [[NSMutableArray alloc] init];
	rank = 0;
	highCardRank = 0;
	[super init];
	return self;
	
}

-(BOOL) addCard:(Card *)card {
	rank = 0; // any previously calculated rank is invalid
	/*
	int c;
	if (isSevenCardHand) {
		c = 7;
		
	} else {
		c = 5;
	}

	if ([cards count]>=c) {
		return FALSE;
	}
	 */
	
	[self.cards addObject:card];
	
	return TRUE;
	

}

// print each card in the hand, for testing purposes (and for text game, which itself is for testing purposes)
-(void) print {
	
	


}	


-(void)sort {
	[self.cards sortUsingSelector:@selector(compare:)];
}

-(void)rankHighCards {
	if (highCardRank) {
		return;
	}
	for (int i=4;i>=0;i--) { // for each of the 5 cards, store the face value in the least significant 4 bits of highCardsRank
		int c = [[self.cards objectAtIndex:i] faceValue];
		highCardRank<<=4; // shift left 4 bits for room for the next card.
		highCardRank |= c;
		
		
	}
}
// this method will find and store to (int)rank a pair, 2 pairs

-(void)isPair {
	// For this to work, hand must be sorted. To save time I assume it is, which is bad.
	// But this will only be called after other operations which sort the hand.
	
	// compare each card to the previous card
	for (int i=0;i<4;i++) { 
		int c1 = [[self.cards objectAtIndex:i] faceValue]; 		//get 2 cards to compare
		int c2 = [[self.cards objectAtIndex:i + 1] faceValue]; 	
		if (c1 == c2) {
			rank|=c1; // if a pair is found, set bit 1-4 as pairs face value
			// NSLog(@"found one pair %d",c2);
			
			for (i++;i<4;i++) { // check for a pair again in the rest of the hand
				int c3 = [[self.cards objectAtIndex:i] faceValue]; 
				int c4 = [[self.cards objectAtIndex:i+1] faceValue];
				if ((c3 == c4) &&   // if a pair is found
					(c3 != c1)) {  // and it isn't the same as the first pair
					
					c3 <<= 4; // shift c3 4 bits left					
					rank|=c3; // set bits 5-8 as sencond pairs facevalue.
					// NSLog(@"found second pair %d",c4);
					return;
				} // if second pair
			} // for loop for second pair
		} // if first pair
	} // for
	
	
} // is pair


-(void)isThreeOfKind {
	for (int i = 0;i < 3;i++) {
		int c1 = [[self.cards objectAtIndex:i] faceValue];
		int c2 = [[self.cards objectAtIndex:i+1] faceValue];	
		int c3 = [[self.cards objectAtIndex:i+2] faceValue];	
		
		if ((c1 == c2) && (c1 == c3)) { // three of a kind
			
			c1<<=8;
			rank|=c1; // set bits 9-12
			// NSLog(@"Found 3 of a kind %d",c2);
			return;
		}
	} // for
} // isThreeOfKind


// I assume that the Hand is sorted
-(BOOL)isStraight {
	int c1 = [[self.cards objectAtIndex:0] faceValue];
	int c2 = [[self.cards objectAtIndex:1] faceValue];	
	int c3 = [[self.cards objectAtIndex:2] faceValue];
	int c4 = [[self.cards objectAtIndex:3] faceValue];
	int c5 = [[self.cards objectAtIndex:4] faceValue];
	
	if ((c2 == (c1+1)) && (c3 == (c1+2)) && (c4 == (c1+3)) && (c5 == (c1+4))) { // plain straight
		// NSLog(@"Found Straight");
		c5<<=13; // shift left 12 bits
		rank|=c5; // set bits 13-16 to high card of straight
		return TRUE;
	} // if straight
	
	if ((c5 == 14) && (c1 == 2) && (c2 == 3) && (c3 == 4) && (c4 == 5)) { // Ace Low straight
		// NSLog(@"Found Ace Low Straight");
		c1<<=13; // shift left 12 bits
		rank|=c1; // set bits 13-16 to high card of straight
		return TRUE;
	} // if Ace low straight
	
	
	return FALSE;
} // isStraight

	


-(BOOL)isFlush {
	int c1 = [[self.cards objectAtIndex:0] suit];
	int c2 = [[self.cards objectAtIndex:1] suit];	
	int c3 = [[self.cards objectAtIndex:2] suit];
	int c4 = [[self.cards objectAtIndex:3] suit];
	int c5 = [[self.cards objectAtIndex:4] suit];
	
	if ((c1 == c2) && (c1 == c3) && (c1 == c4) && (c1 == c5)) {
		// NSLog(@"Found Flush %d %d %d %d %d", c1,c2,c3,c4,c5);
		int c6 = [[self.cards objectAtIndex:4] faceValue];   // get facevalue of high card to store in rank
			if ([[self.cards objectAtIndex:0] faceValue] == 1) { // if low card is an Ace
				c6 = 14;										// store a high ace as the high card
			} // if ace high
		c6<<=16; // shift left 16 bits
		rank|=c6; // store in bits 17-20
		return TRUE;
	} // if flush
		
	return FALSE;	
} // is Flush

-(void)isFullHouse {
	int c1 = [[self.cards objectAtIndex:0] faceValue];
	int c2 = [[self.cards objectAtIndex:1] faceValue];	
	int c3 = [[self.cards objectAtIndex:2] faceValue];
	int c4 = [[self.cards objectAtIndex:3] faceValue];
	int c5 = [[self.cards objectAtIndex:4] faceValue];

	if ((c1 == c2) && (c1 == c3) && (c4 == c5)) { // 3 low cards
		c1<<=20;
		c4<<=24;
		rank|=c1; // store low card in bits 21-24
		rank |=c4; // store high card in bits 25-28
		// NSLog(@"Full house with 3 low cards");
	} // 3 low cards full house
	
	if ((c1 == c2) && (c3 == c4) && (c3 == c5)) { // 3 high cards
		c1<<=24;
		c4<<=20;
		rank|=c1; // store low card in bits 25-28
		rank|=c4; // store high card in bits 21-24
		// NSLog(@"Full House with 3 high cards");
	} // 3 high cards full house
	


} // isFullHouse	
	

-(void)isFourOfKind {
	for (int i = 0;i < 2;i++) {
		int c1 = [[self.cards objectAtIndex:i] faceValue];
		int c2 = [[self.cards objectAtIndex:i+1] faceValue];	
		int c3 = [[self.cards objectAtIndex:i+2] faceValue];	
		int c4 = [[self.cards objectAtIndex:i+3] faceValue];
		
		if ((c1 == c2) && (c1 == c3) && (c1 == c4)) {
			c1<<=24;
			rank|=c1; // store in bits 25-32
			// NSLog(@"Found 4 of a Kind %d",c2);
			return;
		}
	}
}
		
// isStraight Flush will always call isFlush and isStraigt so those methods don't need to be called later.	
-(void) isStraightFlush {
	if ([self isFlush]) {
		if ([self isStraight]) {
			long s = (rank & 0xf000); // get straight high card from bits 13-16
			s<<=20; // shift from bits 13-16 to 33-36
			rank|=s;
			// NSLog(@"Found Straight Flush");
		} // if straight
	} else [self isStraight]; // if flush
}



-(long)rankFive {
//    NSLog(@"Rank 5");
	if (rank) {
		return rank;
	}
	
	[self sort];
	[self isStraightFlush];
	[self isFourOfKind];
	[self isFullHouse];
	[self isThreeOfKind];
	[self isPair];
	[self rankHighCards];
	return rank;
}



-(NSComparisonResult)compare:(Hand *)otherHand {
	// compare rank, and return sort order
	if (self.rank > otherHand.rank) {
//		// NSLog(@"Decending");
		return NSOrderedDescending;
		
	}
	
	if (self.rank < otherHand.rank) {
//		// NSLog(@"Ascending");
		return NSOrderedAscending;
		
	}
	// if Hands are equal, then sort on highcard rank
	if (self.rank == otherHand.rank) {
		if (self.highCardRank > otherHand.highCardRank) {
//			// NSLog(@"Decending highCardRank");
			return NSOrderedDescending;
			
		}
		
		if (self.highCardRank < otherHand.highCardRank) {
//			// NSLog(@"Acending highCardRank");
			return NSOrderedAscending;
			
		}
		
		// there should never be two of the exact same card in a deck or hand
//		// NSLog(@"Same! How is this Possible?");
		return NSOrderedSame;
	}
	// NSLog(@"Sort Error.");
	return NSOrderedSame;
	
}

-(float)strengthAgainst:(Hand *)otherHand {
	NSLog(@"strenghtAgainst");
	int cardsRemaining = 7 - [self.cards count];
	int numberOfTests = 20;
	int wins = 0;
	float chance = 0.0;
    
	for (int i=0; i<numberOfTests ; i++) {		// loop through a bunch of tests							
		Deck *tempDeck = [[Deck alloc] init];
        [tempDeck shuffle];										// a deck to draw random cards from

 // this is a temp hand that is used to build a full hand from the cards in self       
        Hand *tempSelf = [[Hand alloc] init];       
        for (int j=0;j<[self.cards count];j++) {
            [tempSelf.cards addObject:[self.cards objectAtIndex:j]];
        } // copy

        for (int j=0;j<cardsRemaining;j++) { // add cards to make a full hand
            [tempSelf.cards addObject:[tempDeck.cards objectAtIndex:0]];
            [tempDeck.cards removeObjectAtIndex:0];
        } // add cards to make a full hand
        
        
        
// this is a temp hand that is used to build a full hand from the 2 known face up cards in otherHand
        
		Hand *temp = [[Hand alloc] init];						// the temp hand that will be dealt a full hand
		for (int j=0;j<2;j++) {                                 // copy face up 2 cards other hand
			[temp.cards addObject:[otherHand.cards objectAtIndex:j]];
		} //copy

		for (int j=0;j<3;j++) {                                 // add cards to make a full hand
			[temp.cards addObject:[tempDeck.cards objectAtIndex:0]];
			[tempDeck.cards removeObjectAtIndex:0];
		} // add cards to make a full hand
//		NSLog(@"self count = %d",[[tempSelf cards] count]);
//        NSLog(@"temp count = %d",[[temp cards] count]);
			
		if (tempSelf.rank > temp.rank)  {
			wins+=1;
		}
	
		if ((tempSelf.rank == temp.rank) && (tempSelf.highCardRank > temp.highCardRank)) {
			wins+=1;
		}
		[tempSelf release];
		[temp release];
		[tempDeck release];
		
	} // loop thorugh a bunch of tests
//	NSLog(@"Wins %d",wins);
//	NSLog(@"Tests %d",numberOfTests);
    chance = (float)wins/numberOfTests;
//	NSLog(@"chance %f",chance);
    
	return chance;	
}

-(long)rankSeven {  // seems to work, but doesn't fall back to high card if ranks are the same.
 //   NSLog(@"Rank Seven");
	long highestRank = 0;
	long tempRank = 0;
	int highestHighCard = 0;
	

	
	if ([self.cards count] == 7) {
		
	for (int i=0;i<7;i++) {
		for (int j=0;j<6;j++) {
		// create temp hand as copy of hand
			Hand *tempHand = [[Hand alloc ] init];
			for (int k=0;k<7;k++) {
				[tempHand addCard:[self.cards objectAtIndex:k]];
				 }
			
		// delete 2 cards i and j
			[tempHand.cards removeObjectAtIndex:i];
			[tempHand.cards removeObjectAtIndex:j];
			
		// rank the hand
			
			tempRank = [tempHand rank];
			
		// if rank > highest so far, save it
			
			if (tempRank > highestRank) {
				highestRank = tempRank;
	
				highestHighCard = tempHand.highCardRank;
			}
			
		// release temp hand
			
			[tempHand release];
		}
	}
		
	} else {  // if 7 card hand
		NSLog(@" Error! Wrong number of cards to Rank 7 Card Hand %d",[self.cards count]);
	}
	highCardRank = highestHighCard;
	rank = highestRank;
		return rank;


}

-(long)rank {
	
//	NSLog(@"Ranking %d card hand",[self.cards count]);
	if ([self.cards count] == 5) {
        
		return [self rankFive];
	}
	
	if ([self.cards count] == 7) {
		return [self rankSeven];
	}
	NSLog(@"Error! Wrong number of cards to rank! %d",[self.cards count]);
	return 0;
}


-(void)invalidateRank {
	rank=0;
	return;
}

-(void)dealloc {
	[cards release];
	[super dealloc];
}

@end
