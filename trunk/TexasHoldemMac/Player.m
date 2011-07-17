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
@synthesize moneyField;

-(id)init {
	if (self = [super init]) {
		currentBet = 0;
		playerHand = [[Hand alloc] init];
		money = 100.00;
		name = [[NSString alloc] initWithString:@"Player"];
		self.nibName = @"Player";
		[self loadView];
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
	
	
	
		
	if ([playerHand.cards count]<2) {
		return;
	}
	NSString *aString = [[NSString alloc] init];
   printf("%s\n",[self.name UTF8String] );
	for (int i=0;i<2;i++) {
		aString =[aString stringByAppendingString:[((Card*)[playerHand.cards objectAtIndex:i]) print]]; // There is a leak here.
		
	}
    [cardImage1 setImage:[((Card *)[playerHand.cards objectAtIndex:0]) image] ];
    [cardImage2 setImage:[((Card *)[playerHand.cards objectAtIndex:1]) image] ];
    
	[self.handField setStringValue:aString];
	[self.moneyField setStringValue:[NSString stringWithFormat:@" $ %.2f",money]];
	
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

-(void)controlTextDidEndEditing:(NSNotification *)obj {
	((NSButton *)[obj object]).resignFirstResponder;
	//	[self betButton:self];
}

-(void)playerLostHand{}
-(void)playerWonHand{}




@end