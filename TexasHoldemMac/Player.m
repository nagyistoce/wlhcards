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

@implementation Player
@synthesize playerHand, name, gameView;
@synthesize currentBet, money, hasBet;

@synthesize nibName, nameLabel, handField, betField, betButton;


-(id)init {
	if (self = [super init]) {
		currentBet = 0;
		playerHand = [[Hand alloc] init];
		money = 100.00;
		name = [[NSString alloc] initWithString:@"Player"];
		self.nibName = @"Player";
		self.loadView;
	}
	return self;


}
		
-(void) dealloc {
	[playerHand release];
	[name release];
	[super dealloc];
}
	
-(void) display {
	
	
	self.nameLabel.stringValue = name;
	
	printf("%s\n",[name UTF8String]);
	
		
	if ([playerHand.cards count]<2) {
		return;
	}
	NSString *aString = [[NSString alloc] init];

	for (int i=0;i<2;i++) {
		aString =[aString stringByAppendingString:[((Card*)[playerHand.cards objectAtIndex:i]) print]]; // There is a leak here.
		printf(" ");
	}
	[self.handField setStringValue:aString];
	
	printf("\n");
}




-(Hand *) getPlayerHand {
	return playerHand;
}

-(float)askForBet{

	[self display];
	[gameView displayBoard];
	printf("\nWhat is your bet?");
	hasBet = NO;
	[self.betButton setEnabled:YES];
	[self.betField becomeFirstResponder];
	
	while (hasBet==NO) {
		
	}
	[self.betButton setEnabled:NO];
	
	printf("%f\n",currentBet);
	
	return currentBet;
	
} 


-(IBAction)betButton:(id) sender {
	currentBet = betField.floatValue; 
	hasBet = YES;
}


-(void)playerLostHand{}
-(void)playerWonHand{}




@end
