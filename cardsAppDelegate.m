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
@synthesize minField, maxField, startFundsField, bigBlindField, littleBlindField, blindButton;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

	srandom(time(NULL));

	[self startGame:self];
	

}

-(IBAction) startGame:(id)sender {


	[theGame startGame];
 }

-(IBAction)closePrefs:(id)sender{
    [prefs orderOut:self];
}

-(IBAction)showPrefs:(id)sender {
    [prefs orderFront:self];
    
}

@end

