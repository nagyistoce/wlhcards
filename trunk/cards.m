#import <Foundation/Foundation.h>
#import "Deck.h";
#import "Card.h";
#import "game.h";

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

		
	srandom(time(NULL));

	/*
	 
	// create a deck
	Deck *myDeck = [[Deck alloc] init];
	//verify new deck has 52 cards
	printf("There are %d cards in the deck.\n",(int)[myDeck.cards count]);
	//verify new deck shuffles properly
	[myDeck shuffle];
	
	// deal a hand and print it
	Hand *hand = [myDeck deal];
	[hand retain];
	// manually set up a hand to test ranking
	
	[[hand.cards objectAtIndex:0] setFaceValue:3];
	[[hand.cards objectAtIndex:1] setFaceValue:3];
	[[hand.cards objectAtIndex:2] setFaceValue:4];
	[[hand.cards objectAtIndex:3] setFaceValue:4];
	[[hand.cards objectAtIndex:4] setFaceValue:4];

	
	[[hand.cards objectAtIndex:3] setSuit:1];
	[[hand.cards objectAtIndex:3] setSuit:2];
	[[hand.cards objectAtIndex:3] setSuit:0];
	[[hand.cards objectAtIndex:3] setSuit:1];
	[[hand.cards objectAtIndex:4] setSuit:3];
	
	printf("Testing that sorting a Hand works\n");
	// test that sort works
	[hand sort];
	// check hand
	printf("Rank of test hand %ld\n",hand.rank);
	
	[hand print];
	
	// verify that the 5 cards were removed from the deck
	printf("There are %d cards in the deck.\n\n",(int)[myDeck.cards count]);
	
	// deal four hands

	printf("Testing that 5 hands can be sorted by winners\n");
	printf("Dealing out four hands.\n");
	NSMutableArray *playerHands; // array of hands
	playerHands = [[NSMutableArray alloc] init];
	for (int i=0;i<5;i++) { // we are going to deal out 5 hands
		[playerHands addObject:[myDeck deal]];
		[[playerHands objectAtIndex:i] print];
	}
		 
	// sort the playerHands by winner
	
	[playerHands sortUsingSelector:@selector(compare:)];
	
	// print the hands
	
	printf("\n\nRanked Hands.\n");
	
	for (int i=0;i<5;i++) {
		[[playerHands objectAtIndex:i] print];
	}
	printf("\n\nTesting that strength of a hand can be checked against partial hand\n");
	// create a partial hand
	Hand *otherHand = [[Hand alloc]init];		//create empty hand
	[hand release];
	hand = [playerHands objectAtIndex:1];		// use a random hand that was dealt to a player.
	[hand retain];	
	for (int i=0;i<3;i++) {
		[otherHand.cards addObject:[[Card alloc] init]]; // add 3 cards
	}
	[[otherHand.cards objectAtIndex:0] setFaceValue:2]; // set the values
	[[otherHand.cards objectAtIndex:1] setFaceValue:3];
	[[otherHand.cards objectAtIndex:2] setFaceValue:4];
	
	[[otherHand.cards objectAtIndex:0] setSuit:2];
	[[otherHand.cards objectAtIndex:1] setSuit:2];
	[[otherHand.cards objectAtIndex:2] setSuit:2];

	printf("Hand:\n");
	[hand print];
	printf("otherHand\n");
	[otherHand print];
	
	float t = [hand strengthAgainst:otherHand];
    printf("Strength of hand %f\n\n\n",t);
	
	// testing that we can rank a 7 card hand.
	
	printf("Testing 7 Card Rank\n");
	
	Card *c1=[[Card alloc] init];
	Card *c2=[[Card alloc] init];
	c1.suit=2;c1.faceValue=4;
	c1.suit=3;c1.faceValue=10;
	hand.isSevenCardHand = TRUE;
	[hand addCard:c1];
	[hand addCard:c2];
	[hand rank];
	[hand print];
	long tempRank=[hand rankSeven];
	
	printf("The strongest rank was %ld\n\n\n",tempRank);
	
	[hand release];
	[myDeck release];
	[playerHands release];
*/
	
	game *theGame = [[game alloc] init];
	[theGame gameLoop];
	
	
    [pool drain];
    return 0;
}


