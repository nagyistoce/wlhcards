//
//  gameView.m
//  cards
//
//  Created by Warren Holybee on 4/7/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "GameView.h"
#import "Player.h"
#import "Hand.h"
#import "Card.h"

@implementation GameView
@synthesize players, numberOfPlayers, flop;

-(void)addPlayersToWindow:(NSWindow *) window {}


-(id)init
{
	return self;
}

		
-(void)windowDidLoad
{
	NSLog(@"Nib file is loaded");
	
}

-(void)display {
	
	clrscrn();
		printf("---------------------------\n");	
	for (int i=0;i<numberOfPlayers;i++)
	{
		printf("%s\n",[((Player *)[players objectAtIndex:i]).name UTF8String] );
		[self displayPlayer:[players objectAtIndex:i]];
		printf("\n\n\n");
	
	}
		printf("---------------------------\n");
	// [self displayBoard];	
}

-(void)displayPlayer:(Player *)player {
	
	for (int i=0;i<[player.playerHand.cards count];i++) {
		printf(" ");
		[((Card *)[player.playerHand.cards objectAtIndex:i]) print];
	}
	
}


-(int)askNumberOfPlayers {
	return 4;
}



-(void)getBlindBets{

		
}

-(float)getBetFromPlayer:(Player *)player {
	return [player askForBet];
		
}

-(void)displayBoard {
	printf("\nBoard: (%d cards)\n",(int)[flop count]); 
	for (int i=0;i<[flop count];i++) {
		[((Card *)[flop objectAtIndex:i]) print];
	}
	
}	

-(void)invalidBet:(float)lastBet {
	printf("Invalid Bet! You must bet at least %f\n",lastBet);
}

@end
