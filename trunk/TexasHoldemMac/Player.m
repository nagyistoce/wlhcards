//
//  Player.m
//  cards
//
//  Created by Warren Holybee on 4/2/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "Player.h"
#import "Hand.h"
#import "GameView.h"
#import "cardsAppDelegate.h"

@implementation Player
@synthesize playerHand, name, gameView;
@synthesize currentBet, money, hasBet;

@synthesize nibName, nameLabel, handField, betField, betButton;
@synthesize moneyField, winField;

-(id)init {
	if (self = [super init]) {
		currentBet = 0;
		playerHand = [[Hand alloc] init];
		money = 100.00;
        [self loadTheNib];
	}
	return self;


}

-(void) loadTheNib {
    name = [[NSString alloc] initWithString:@"Player"];
    self.nibName = @"Player";
    [self loadView];

    
}

-(void) dealloc {
	[playerHand release];
	[name release];
	[super dealloc];
}
	
-(void) display {
	NSLog(@"player display");
    cardsAppDelegate *appDelegate =	[[NSApplication sharedApplication] delegate];	
	self.nameLabel.stringValue = name;
    if ([playerHand.cards count]<2) {
        return;
	}
    [cardImage1 setImage:[((Card *)[playerHand.cards objectAtIndex:0]) image] ];
    [cardImage2 setImage:[((Card *)[playerHand.cards objectAtIndex:1]) image] ];
    

	[self.moneyField setStringValue:[NSString stringWithFormat:@" $ %.2f",money]];

	if ([[appDelegate theGame] showWinChance]==1) {
        [winField setHidden:NO];
    } else {
        [winField setHidden:YES];
    }
}




-(Hand *) getPlayerHand {
	return playerHand;
}

-(void)askForBet{

	[self display];
	[gameView displayBoard];
	hasBet = NO;
	[self.betButton setEnabled:YES];
	[self.betField becomeFirstResponder];
	
		
} 


-(IBAction)betButton:(id) sender {
	currentBet = betField.floatValue; 
	hasBet = YES;
	cardsAppDelegate *appDelegate =	[[NSApplication sharedApplication] delegate];
	[[appDelegate theGame] gotBetFromPlayer:self];
}

-(void)controlTextDidEndEditing:(NSNotification *)obj {
	[[obj object] resignFirstResponder];
	}

-(void) setWinChance:(float)chance {
    winChance = chance*100;
    [winField setStringValue:[NSString stringWithFormat:@"%2.2f",winChance]];

    
}

-(float) winChance {
    return winChance;
}

-(void)playerLostHand{}
-(void)playerWonHand{}




@end
