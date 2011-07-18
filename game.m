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

-(void)deal2cards {
	NSLog(@"Deal 2 cards");
	// deal 2 cards to players
	for (int i=0; i< numberOfPlayers; i++) {
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[deck dealCard]];
		[temp.playerHand addCard:[deck dealCard]];
		
	}
	[gameView display];
}


-(void)dealFlop {
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
	
}	
	
-(void)dealTurn {
	// deal the turn
	NSLog(@"Deal turn");
	[flop addObject:[deck dealCard]];
	for (int i=0;i<numberOfPlayers;i++)
	{
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[flop objectAtIndex:3]];
	}
	[gameView display];
	

}

-(void) dealRiver {
	// deal river
	NSLog(@"Deal River");
	
	[flop addObject:[deck dealCard]];
	for (int i=0;i<numberOfPlayers;i++)
	{
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[flop objectAtIndex:4]];
	}
	[gameView display];
}	
	
-(void)determineWinner {
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
	
}

-(void)endHand {
	// clear player hands and flop
	for (int i =0;i<numberOfPlayers;i++) {
		
		((Player *)[players objectAtIndex:i]).playerHand = [[Hand alloc] init];
	}
	[flop release];
	flop = [[NSMutableArray alloc] init];
	gameView.flop = flop;
	
	if (((numberOfPlayers*2)+5) > [deck.cards count]) { // do we have enough cards for another hand?
		NSLog(@"shuffling a new deck");
		[self setupNewDeck];
	}
	
	// any players out of money?
	for (int i = 0;i < [players count];i++) {
		Player *player = ((Player *)[players objectAtIndex:i]); 
		float pMoney = (player.money);
		
		if ( pMoney <= 0 ) {
			[gameView removePlayer:player fromWindow:aWindow];
			[players removeObjectAtIndex:i];
			numberOfPlayers--;
		}
	}
}

-(void)endGame {
	//remove remaining objects from window
	[gameView removePlayer:[players objectAtIndex:0] fromWindow:aWindow];
	[gameView removeBoard];

	
}	

-(void)startHand { 
	
	currentBet = -1.0;
	lastBet = -1.0;
	bettingPlayer = 0;
	nextStep = wDeal2Cards;
	[self deal2cards];
	nextStep += 1;
	allPlayersBet = NO;
	[gameView getBetFromPlayer:[players objectAtIndex:0]];
}

-(void)gameLoop {
    
   
	[self startHand];
	
}


// gotBetFromPlayer (Player *) player
-(void)gotBetFromPlayer:(Player *) player {
	NSLog(@"gotBetFromPlayer");

	for (int i=0;i<[players count];i++) {
		[[[players objectAtIndex:i] betButton] setEnabled:NO];
	}
	
// is bet from player we expect?
if (player != [players objectAtIndex:bettingPlayer]) {
	// if not throw error

	NSLog(@"Error! wrong player Bet!");
	
} else {
	// is bet valid?
	if (player.currentBet>=lastBet) {
		currentBet = player.currentBet;
		lastBet = currentBet;
		
		// subtract money from player
		if ( lastBet < player.money ) { // dont put more money in pot than player has
			player.money -= lastBet;
			pot += lastBet;
		} else {
			pot += player.money;
			player.money = 0;
		}
		[gameView updatePot:pot]; // display new pot amount	
		[player display];	

	
		// have all players bet?
		
		if ((++bettingPlayer)==[players count]) {
			// all players have bet
			bettingPlayer = 0;
			allPlayersBet = YES;
		}
		
		if (allPlayersBet == YES) {
			if ([self betsAreSquare]) { // if all bets are square
				allPlayersBet = NO;
				bettingPlayer = 0;
				lastBet = -1.0;
				switch (nextStep) {
					case wDealFlop:
						[self dealFlop];
						
						nextStep++;
						break;
					case wDealTurn:
						[self dealTurn];
						
						nextStep++;
						break;
					case wDealRiver:
						[self dealRiver];
						
						nextStep++;
						break;
					case wDetermineWinner:
						[self determineWinner];
						nextStep++;
						break;
					default:
						break;
				}
				NSLog(@"nextStep = %d",nextStep);
				
				
		} // if all bets are square
			
	} // all players have bet
	if (nextStep!=wHandOver) {
		[[gameView statusOne] setStringValue:@""];
		[gameView getBetFromPlayer:[players objectAtIndex:bettingPlayer]];
	} 	



		
		
	} else { // valid bet
		// this is not a valid bet
		[gameView invalidBet:lastBet];
		[gameView getBetFromPlayer:[players objectAtIndex:bettingPlayer]];
}
 
	
	
}

	
	
	

} // gotBetFromPlayer

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
	
	[self setupNewDeck];
	
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
