

// ******** This version only for Mac Cocoa !!!! Not for Console !

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

-(id)init
{
	
	NSLog(@"Loaded Cocoa Version of GameView");
	return self;
}

		
-(void)windowDidLoad
{
	NSLog(@"Nib file is loaded");
	
}


-(void)addPlayersToWindow:(NSWindow *) window{
	
	NSLog(@"Add Players To Window %@", window);
	// get windows view
	
	NSView *subView = [window contentView];
	
	// for each player  {
	
	for (int i = 0;i < numberOfPlayers;i++) {
		
	
	// get the players view
		NSView *pView = ((Player *)[players objectAtIndex:i]).view;
		
	// add that view to the contentView
	
		[subView addSubview:pView];
		
		
	// set Views x and y  -   (void)setFrameOrigin:(NSPoint)newOrigin }
		float x= 10;
		float y=80*(i);
		NSPoint aPoint = NSMakePoint(x, y);
		[pView setFrameOrigin:aPoint];
		
	}
	
	// (void)setNeedsDisplay:(BOOL)flag

	[subView setNeedsDisplay:YES];
	
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
		[[player.playerHand.cards objectAtIndex:i] print];
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
		[[flop objectAtIndex:i] print];
	}
	
}	

-(void)invalidBet:(float)lastBet {
	printf("Invalid Bet! You must bet at least %f\n",lastBet);
}


-(IBAction)player1Bet {
}

-(IBAction)player2Bet{
}

-(IBAction)player3Bet{
}

-(IBAction)player4Bet{
}

@end
