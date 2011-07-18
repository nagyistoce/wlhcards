//
//  cardsAppDelegate.m
//  cards
//
//  Created by Warren Holybee on 4/21/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "cardsAppDelegate.h"
#import "game.h"

@implementation cardsAppDelegate

@synthesize window;
@synthesize theGame;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

	srandom(time(NULL));

	
	[self startGame:self];
	

}

-(IBAction) startGame:(id)sender {
	theGame = [[game alloc] init];
	[theGame setWindow:window];
	[theGame gameLoop];
 }

@end

