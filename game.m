//
//  game.m
//  cards
//
//  Created by Warren Holybee on 1/19/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "game.h"
#import "GameView.h"
#import "Deck.h"
#import "Card.h"
#import "Player.h"
#import "Hand.h"

@implementation game
@synthesize players;
@synthesize delegate;
@synthesize pot;
@synthesize gameView;
#if !(text_only==1)
@synthesize aWindow;
#endif

#pragma mark Text Based Implemetation

-(void) dealloc {
	[gameView release];
	[deck release];
	[players release];
	[flop release];
	[super dealloc];
}

-(id) init {
	// set up the gameView
	
	gameView = [[GameView alloc] init];
	numberOfPlayers = [gameView askNumberOfPlayers];
	[self setupDeckFlopPlayers];
	return self;
}	

-(void)gameLoop {

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	
while ([players count]>1) // while more then one player exists
{

	// blind bets
//	[gameView getEveryonesBet];	
	
	NSLog(@"Deal 2 cards");
// deal 2 cards to players
	for (int i=0; i< numberOfPlayers; i++) {
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[deck dealCard]];
		[temp.playerHand addCard:[deck dealCard]];
						
	}
	[gameView display];
// get bets from players
	
	
	
	[self getEveryonesBet];

	// deal flop
	NSLog(@"Deal Flop");
	[flop addObject:[deck dealCard]];
	[flop addObject:[deck dealCard]]; 
	[flop addObject:[deck dealCard]];
	 for (int i=0;i<numberOfPlayers;i++)
	 {
		 Player *temp = [players objectAtIndex:i];
		 [temp.playerHand addCard:[flop objectAtIndex:0]];
		 [temp.playerHand addCard:[flop objectAtIndex:1]];
		 [temp.playerHand addCard:[flop objectAtIndex:2]];
	 }
	 gameView.flop = flop;
	 [gameView display];
	 
// get bets
	 [self getEveryonesBet];
// deal the turn
	NSLog(@"Deal turn");
	 [flop addObject:[deck dealCard]];
	  for (int i=0;i<numberOfPlayers;i++)
	  {
		  Player *temp = [players objectAtIndex:i];
		  [temp.playerHand addCard:[flop objectAtIndex:3]];
	  }
	  [gameView display];
		  
// get bets
	  [self getEveryonesBet];
// deal river
	NSLog(@"Deal River");
	
	  [flop addObject:[deck dealCard]];
	   for (int i=0;i<numberOfPlayers;i++)
	   {
		   Player *temp = [players objectAtIndex:i];
		   [temp.playerHand addCard:[flop objectAtIndex:4]];
	   }
	   [gameView display];
// get bets
	   [self getEveryonesBet];
// determine winner
	NSLog(@"Determine Winner");  

	[gameView display];
	
	// create array of hands, and rank them
	
	NSMutableArray *allHands = [[NSMutableArray alloc] init];
	for (int i=0;i<numberOfPlayers;i++) {
		Player *thePlayer = [players objectAtIndex:i];
		[thePlayer.playerHand rank];
		[allHands addObject:thePlayer.playerHand];
		 }
		 

	
	// sort the array
	
	[allHands sortUsingSelector:@selector(compare:)];
	
	// loop through players
	// compare winning hand (last object in array) with players hand
	// if they are the same, that player is the winner
	
	int winner;
	for (winner = 0;([((Player*)[players objectAtIndex:winner]) getPlayerHand] != [allHands lastObject]); winner++ )
	{ 
		// NSLog(@"%d",winner); // this should be replaced with error handling code to prevent an infinite loop.
	}
	[allHands release];
	
	
		
	// give money to winner player		
	((Player *)[players objectAtIndex:winner]).money+= pot;
	pot = 0;
	[gameView updatePot:pot];
	[gameView winner:winner];
	
	
	// clear player hands and flop
	for (int i =0;i<numberOfPlayers;i++) {
		
		((Player *)[players objectAtIndex:i]).playerHand = [[Hand alloc] init];
		 }
	[flop release];
	flop = [[NSMutableArray alloc] init];
	 gameView.flop = flop;
	
	if (((numberOfPlayers*2)+5) > [deck.cards count]) { // do we have enough cards for another hand?
		NSLog(@"shuffling a new deck");
		self.setupNewDeck;
	}
	
	// any players out of money?
	for (int i = 0;i < [players count];i++) {
		Player *player = ((Player *)[players objectAtIndex:i]); 
		float pMoney = (player.money);
		
		if ( pMoney < 0 ) {
			[gameView removePlayer:player fromWindow:aWindow];
			[players removeObjectAtIndex:i];
			numberOfPlayers--;
		}
	}
	  
} // while
	
	//remove remaining objects from window
	[gameView removePlayer:[players objectAtIndex:0] fromWindow:aWindow];
	[gameView removeBoard];
	[pool drain];
	
	
} // game loop


-(void) getEveryonesBet {

// get Everyone's initial bet
	lastBet = 0;
	currentBet = -1.0;
	
	for (int i=1;i<[players count];i++){
	currentBet = [gameView getBetFromPlayer:[players objectAtIndex:i]];
		while (currentBet < lastBet) {		// make sure bet is at least as high as previous bet
			[gameView invalidBet:lastBet];
			currentBet = [gameView getBetFromPlayer:[players objectAtIndex:i]];
		}
		
		lastBet = currentBet;
	}
		currentBet = [gameView getBetFromPlayer:[players objectAtIndex:0]]; // dont forget the dealer is last, so not in the for-loop.

	while (currentBet < lastBet) {		// make sure bet is at least as high as previous bet
		[gameView invalidBet:lastBet];
		currentBet = [gameView getBetFromPlayer:[players objectAtIndex:0]];
	}
	
	lastBet = currentBet;
	

	
// while bets are not square (all the same) ask the next player for a bet.
	int j = 1;
	while (![self betsAreSquare]) { // while bets are not square (all the same) ask the next player for a bet.
		
		currentBet = [gameView getBetFromPlayer:[players objectAtIndex:j]];
		while (currentBet < lastBet) {		// make sure bet is at least as high as previous bet
			[gameView invalidBet:lastBet];
			currentBet = [gameView getBetFromPlayer:[players objectAtIndex:j]];
		}
		
		lastBet = currentBet;
		
		
		if ( (++j)==[players count]) {j = 0;} // loop back to player 0 until while loop is satisfied.
		}

	// update the money in the pot
	pot += lastBet * [players count];
	[gameView updatePot:pot];

	// subtract the bets from the players
	for (int i=0;i<[players count];i++) {
		((Player *)[players objectAtIndex:i]).money -= lastBet;
	}
	
	
}
	
	


-(BOOL) betsAreSquare {
	BOOL square = TRUE;
	for (int i=1;i<[players count];i++) {
		if (  
			(((Player *)[players objectAtIndex:i]).currentBet) !=
			(((Player *)[players objectAtIndex:i-1]).currentBet)
			) {
			square = FALSE;
		}
	}
	
	return square;
}
		
#pragma mark Mac GUI Implemetation

-(void) setWindow:(NSWindow *)window {

#if !(text_only==1)
		self.aWindow = window;
	[gameView addPlayersToWindow:aWindow];	
#endif
	
	
}

#pragma mark Commom stuff

-(void)setupDeckFlopPlayers {
		
	// Set up the Deck
	
	self.setupNewDeck;
	
	flop = [[NSMutableArray alloc] init];
	
	// how many players?
	

	
	gameView.numberOfPlayers = numberOfPlayers;
	
	// create players
	players = [[NSMutableArray alloc] init];
	gameView.players = self.players;
	
	for ( int i=0;i<numberOfPlayers;i++) {
		Player *newPlayer = [[Player alloc] init];
		newPlayer.name = [NSString stringWithFormat:@"Player %d",i+1];	
		newPlayer.gameView = gameView;
		[players addObject:newPlayer];
		[newPlayer release];
		
	}
	
	((Player *)[players objectAtIndex:0]).name = [NSString stringWithFormat:@"Dealer"];
	
}	

-(void)setupNewDeck {
	// Set up the Deck
	if (deck) [deck release];
		
	deck = [[Deck alloc] init];
	[deck shuffle];
	
}
	

@end
