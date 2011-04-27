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

	theGame = [[game alloc] init];
	theGame.aWindow = window;
	
	
	[NSThread detachNewThreadSelector:@selector(gameLoop) toTarget:theGame withObject:nil];
}

@end
