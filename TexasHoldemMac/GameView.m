

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

-(void) dealloc {
	[cardBack release];
	[flopImages release];
	[super dealloc];
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
    [self displayBoard];

}







-(void)displayBoard {
	NSString *bString = [[NSString alloc] init];

    
	for (int i=0;i<5;i++) { // set all flop images to the card back
		[[flopImages objectAtIndex:i] setImage:cardBack];
	}	
	
	for (int i=0;i<[flop count];i++) {
		bString = [bString stringByAppendingString: [((Card *)[flop objectAtIndex:i]) print]];
		[[flopImages objectAtIndex:i] setImage:[[flop objectAtIndex:i] image]];
	}
	
    
	
	[boardField setStringValue:bString];
	
    
	
	
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


-(IBAction) dealCards:(id)sender {
    NSLog(@"dealCards");
	[statusOne setStringValue:@" "];
	cardsAppDelegate *appDelegate =	[[NSApplication sharedApplication] delegate];
	[[appDelegate theGame] endHand];
	[[appDelegate theGame] startHand];
}


#pragma mark Betting


-(void)getCheckOrBetFromPlayer:(Player *)player { // This is bet type 1
    NSLog(@"\n\nPlayer %@, It is your bet.",player.name);
    NSLog(@"You can Check or Bet.");
    [[player checkButton] setEnabled:YES];
    [[player betButton] setEnabled:YES];
    [[player foldButton] setEnabled:NO];
    [[player raiseButton] setEnabled:NO];
    [[player callButton] setEnabled:NO];
    
    
    [self getBetFromPlayer:player];
    
}
-(void)getCallOrRaiseFromPlayer:(Player *)player withCurrentBetOf:(int)currentBet{ // This is bet type 2
 
    NSLog(@"\n\nPlayer %@, It is your bet.",player.name);
    NSLog(@"The Current Bet is: %d ",currentBet );
    NSLog(@"You can Call, Raise, or Fold");
    
    [[player checkButton] setEnabled:NO];
    [[player betButton] setEnabled:NO];
    [[player foldButton] setEnabled:YES];
    [[player raiseButton] setEnabled:YES];
    [[player callButton] setEnabled:YES];
    
    [self getBetFromPlayer:player];
    
}
-(void)getBetFromPlayer:(Player*) player ofType:(int)type withCurrentBetOf:(int)currentBet{

        if (type==wCheckOrBet) {
            [self getCheckOrBetFromPlayer:player];
    } else {
        if (type ==wCallOrRaise) {
            [self getCallOrRaiseFromPlayer:player withCurrentBetOf:currentBet];
        }
        
    }
    
}

-(void)getBetFromPlayer:(Player *)player {
    
	[player askForBet];
	
    
}


-(void)getBlindBets{

		
}

-(void)invalidBet:(float)lastBet {
	NSString *aString = [NSString stringWithFormat:@"Invalid Bet\n",lastBet];
    
	[statusOne setStringValue:aString];
}


	

@end
