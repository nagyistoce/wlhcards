

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
#import "cardsAppDelegate.h"

@implementation GameView
@synthesize players, numberOfPlayers, flop;
@synthesize nibName, boardField, statusOne;
@synthesize potField;


-(id)init
{
	
	NSLog(@"Loaded Cocoa Version of GameView");
	
	self.nibName = @"Board";
	[self loadView];
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *cardFile = @"/back.png";
    NSString *filePath = [resourcePath stringByAppendingString:cardFile];
    flopImages = [NSArray arrayWithObjects:flop1,flop2,flop3,flop4,flop5,nil];
	[flopImages retain];
    
    
    cardBack = [[NSImage alloc] initWithContentsOfFile:filePath];
	
	return self;
}

		
-(void)windowDidLoad
{
	NSLog(@"Nib file is loaded");
	
}

-(void)removeBoard {
	[self.view removeFromSuperview];
}

-(void)removePlayer:(Player*) player fromWindow:(NSWindow *) window {
	NSView *pView = player.view;
	// NSView *subView = [window contentView];
	[pView removeFromSuperview];

}

-(void)addPlayersToWindow:(NSWindow *) window{
	
	NSLog(@"Add Players To Window %@", window);
	// get windows view
	
	NSView *subView = [window contentView];
	
	NSSize subSize = subView.frame.size;
	
	float subHeight = subSize.height;
	subHeight -= 80; // this number is the offset from the top of the frame that players will start to be added
	
	// for each player  {
	
	for (int i = 0;i < [players count];i++) {
		
	
	// get the players view
		NSView *pView = ((Player *)[players objectAtIndex:i]).view;
		
	// add that view to the contentView
	
		[subView addSubview:pView];

/* This is the vertical layout		

	// set Views x and y  -   (void)setFrameOrigin:(NSPoint)newOrigin }
		float x= 10; // this is the horz. offset of the players added
		float y= subHeight-((i+1)*192); // the multiplier is the space in the view given to each player
		NSPoint aPoint = NSMakePoint(x, y);
		[pView setFrameOrigin:aPoint];  // this places the player
		
	
 
*/
        
        
    // Horizontal Layout
        float x = 10 + (i * 233); // approx width of a player view
        float y = subHeight - 400 ; 
		NSPoint aPoint = NSMakePoint(x, y);
		[pView setFrameOrigin:aPoint];  // this places the player
        
    }
        
	// Add the board to the view
	
	[subView addSubview:self.view];
	NSPoint aPoint = NSMakePoint(20, subHeight-150);
	[self.view setFrameOrigin:aPoint];

	[subView setNeedsDisplay:YES];
	
}

-(void)display {
	
	for (int i=0;i<[players count];i++) {
		[[players objectAtIndex:i] display];
	}
	
}



-(int)askNumberOfPlayers {
	return 4;
}


-(void)getBlindBets{

		
}




-(void)getBetFromPlayer:(Player *)player {
		
	[player askForBet];
	
			
}

-(void)displayBoard {
	NSString *bString = [[NSString alloc] init];
	printf("\nBoard: (%d cards)\n",(int)[flop count]); 

	for (int i=0;i<5;i++) { // set all flop images to the card back
		[[flopImages objectAtIndex:i] setImage:cardBack];
	}	
	
	for (int i=0;i<[flop count];i++) {
		bString = [bString stringByAppendingString: [((Card *)[flop objectAtIndex:i]) print]];
		[[flopImages objectAtIndex:i] setImage:[[flop objectAtIndex:i] image]];
	}
	
		
	
	[boardField setStringValue:bString];
	
		
	
	
}	

-(void)invalidBet:(float)lastBet {
	NSString *aString = [NSString stringWithFormat:@"Bet at least $ %.2f\n",lastBet];
	printf("Invalid Bet! You must bet at least %f\n",lastBet);
	[statusOne setStringValue:aString];
}

-(void)updatePot:(float) pot {
	[potField setStringValue:[NSString stringWithFormat:@" $ %.2f",pot]];
	 }

-(void)winner:(int) winner {
	NSString *aString = [NSString stringWithFormat:@"The Winner is:"];
	NSString *bString = ((Player *)[players objectAtIndex:winner]).name;
	[[players objectAtIndex:winner] display];
	[statusOne setStringValue:[aString stringByAppendingString:bString]];



	 }
-(void) dealloc {
	[cardBack release];
	[flopImages release];
	[super dealloc];
}

-(IBAction) dealCards:(id)sender {
	[statusOne setStringValue:@" "];
	cardsAppDelegate *appDelegate =	[[NSApplication sharedApplication] delegate];
	[[appDelegate theGame] endHand];
	[[appDelegate theGame] startHand];
}
	

@end
