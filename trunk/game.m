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


-(void)gameLoop {
	
// set up the gameView
	
	gameView = [[GameView alloc] init];
	
	
	int numberOfPlayers = 0;

// Set up the Deck
	
	deck = [[Deck alloc] init];
	[deck shuffle];
	flop = [[NSMutableArray alloc] init];
	
// how many players?
		
	numberOfPlayers = [gameView askNumberOfPlayers];
	
	gameView.numberOfPlayers = numberOfPlayers;
// create players
	players = [[NSMutableArray alloc] init];
	gameView.players = self.players;
	
	for ( int i=0;i<numberOfPlayers;i++) {
		Player *newPlayer = [[Player alloc] init];
				
		[players addObject:newPlayer];
		[newPlayer release];
		
	}
	
	
if (numberOfPlayers > 1) 
{

	// blind bets
	[gameView getBlindBets];	
	
	NSLog(@"Deal 2 cards");
// deal 2 cards to players
	for (int i=0; i< numberOfPlayers; i++) {
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[deck dealCard]];
		[temp.playerHand addCard:[deck dealCard]];
						
	}
	[gameView display];
// get bets from players
	[gameView getEveryonesBet];
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
	 [gameView getEveryonesBet];
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
	  [gameView getEveryonesBet];
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
	   [gameView getEveryonesBet];
// determine winner
	NSLog(@"Determine Winner");  
	
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
	for (winner = 0;([[players objectAtIndex:winner] getPlayerHand] != [allHands lastObject]); winner++ )
	{ 
		// NSLog(@"%d",winner); // this should be replaced with error handling code to prevent an infinite loop.
	}
	
		
			
	
	// call gameview winner
	NSLog(@"And the winner is! %d",winner+1);
	   
}
	[gameView release];
	[deck release];
	[players release];
	[flop release];
}


@end
