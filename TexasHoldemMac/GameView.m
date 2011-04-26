

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
@synthesize nibName, boardField, statusOne;

-(id)init
{
	
	NSLog(@"Loaded Cocoa Version of GameView");
	
	self.nibName = @"Board";
	self.loadView;
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
	
	NSSize subSize = subView.frame.size;
	
	float subHeight = subSize.height;
	subHeight -= 50; // this number is the offset from the top of the frame that players will start to be added
	
	// for each player  {
	
	for (int i = 0;i < numberOfPlayers;i++) {
		
	
	// get the players view
		NSView *pView = ((Player *)[players objectAtIndex:i]).view;
		
	// add that view to the contentView
	
		[subView addSubview:pView];
		

	// set Views x and y  -   (void)setFrameOrigin:(NSPoint)newOrigin }
		float x= 10; // this is the horz. offset of the players added
		float y= subHeight-((i+1)*80); // the multiplier is the space in the view given to each player
		NSPoint aPoint = NSMakePoint(x, y);
		[pView setFrameOrigin:aPoint];  // this places the player
		
	}
	// Add the board to the view
	
	[subView addSubview:self.view];
	NSPoint aPoint = NSMakePoint(210, subHeight-110);
	[self.view setFrameOrigin:aPoint];

	[subView setNeedsDisplay:YES];
	
}

-(void)display {
	

		printf("---------------------------\n");	
	for (int i=0;i<numberOfPlayers;i++)
	{
		[[players objectAtIndex:i] display];
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
	float bet = [player askForBet];
	[statusOne setStringValue:@""];
	return bet;
		
}

-(void)displayBoard {
	NSString *bString = [[NSString alloc] init];
	printf("\nBoard: (%d cards)\n",(int)[flop count]); 
	for (int i=0;i<[flop count];i++) {
		bString = [bString stringByAppendingString: [((Card *)[flop objectAtIndex:i]) print]];
	}
	[boardField setStringValue:bString];
}	

-(void)invalidBet:(float)lastBet {
	NSString *aString = [NSString stringWithFormat:@"Bet at least %f\n",lastBet];
	printf("Invalid Bet! You must bet at least %f\n",lastBet);
	[statusOne setStringValue:aString];
}



@end
