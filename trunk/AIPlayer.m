//
//  AIPlayer.m
//  cards
//
//  Created by Warren Holybee on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AIPlayer.h"
#import "cardsAppDelegate.h"


@implementation AIPlayer


-(void)askForBet{
    
	[self display];
	[gameView displayBoard];
	hasBet = NO;
	[self sendBet];
    
} 

-(void) loadTheNib {
    name = [[NSString alloc] initWithString:@"Player"];
    self.nibName = @"AIPlayer";
    [self loadView];
    
    
}


-(void)sendBet{

	cardsAppDelegate *appDelegate =	[[NSApplication sharedApplication] delegate];

    if (betRound!=[[appDelegate theGame] nextStep]) { // to prevent an infinite loop of raising
        
    
        if (winField.floatValue < 50) {
            currentBet = [[appDelegate theGame] currentBet];
            betRound = [[appDelegate theGame] nextStep];
        } else if (winField.floatValue < 75) {
            currentBet = (1.5 * ([[appDelegate theGame] currentBet]));
            betRound = [[appDelegate theGame] nextStep];
        } else {
            currentBet = (2.0*([[appDelegate theGame] currentBet]));
            betRound = [[appDelegate theGame] nextStep];
        }
    } else {
        currentBet = [[appDelegate theGame] currentBet]; // default bet if already raised once.
    }
    
    
	hasBet = YES;
    betField.floatValue = currentBet;
	[[appDelegate theGame] gotBetFromPlayer:self];
}


@end
