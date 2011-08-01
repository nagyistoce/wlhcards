//
//  AIPlayer.m
//  cards
//
//  Created by Warren Holybee on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AIPlayer.h"
#import "cardsAppDelegate.h"
#import "Hand.h"

@implementation AIPlayer


-(void)askForBet{
    
	[self display];
	[gameView displayBoard];
	
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
            currentBet = (int)[[appDelegate theGame] currentBet];
            betRound = [[appDelegate theGame] nextStep];
        } else if (winField.floatValue < 75) {
            currentBet = (int)(1.5 * ([[appDelegate theGame] currentBet]));
            betRound = [[appDelegate theGame] nextStep];
        } else {
            currentBet = (int)(2.0*([[appDelegate theGame] currentBet]));
            betRound = [[appDelegate theGame] nextStep];
        }
    } else {
        currentBet = [[appDelegate theGame] currentBet]; // default bet if already raised once.
    }
    
    

    betField.floatValue = currentBet;
	[[appDelegate theGame] gotBetFromPlayer:self];
}

-(void) display {
	NSLog(@"AI Player Display");
    cardsAppDelegate *appDelegate =	[[NSApplication sharedApplication] delegate];


    
	self.nameLabel.stringValue = name;
	    
    
	if ([playerHand.cards count]<2) {
		return;
	}
    
    if ([appDelegate theGame].showAICards==1) {
        [cardImage1 setImage:[((Card *)[playerHand.cards objectAtIndex:0]) image] ];
        [cardImage2 setImage:[((Card *)[playerHand.cards objectAtIndex:1]) image] ]; 
    } else {
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString *cardFile = @"/back.png";
        NSString *filePath = [resourcePath stringByAppendingString:cardFile];
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:filePath];
    
        [cardImage1 setImage:image];
        [cardImage2 setImage:image];
        [image release];
    }  
    if ([[appDelegate theGame] showWinChance]==1) {
        [winField setHidden:NO];
    } else {
        [winField setHidden:YES];
    }
    
	[self.moneyField setStringValue:[NSString stringWithFormat:@" $ %.2f",money]];
	
}



@end
