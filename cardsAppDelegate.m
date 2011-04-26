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


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

	srandom(time(NULL));

	game *theGame = [[game alloc] init];
	theGame.aWindow = window;
	
	
	[NSThread detachNewThreadSelector:@selector(gameLoop) toTarget:theGame withObject:nil];
}

@end
