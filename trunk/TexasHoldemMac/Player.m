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
@synthesize currentBet, money;

@synthesize nibName;


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
	printf("%s\n",[name UTF8String]);
	if ([playerHand.cards count]<2) {
		return;
	}
	
	for (int i=0;i<2;i++) {
		[((Card*)[playerHand.cards objectAtIndex:i]) print];
		printf(" ");
	}
	printf("\n");
}

-(void) print {
	[self display];
}

-(Hand *) getPlayerHand {
	return playerHand;
}

-(float)askForBet{

	float bet;
	[self print];
	[gameView displayBoard];
	printf("\nWhat is your bet?");
	scanf("%f",&bet);
	currentBet = bet;
	clrscrn();
	return bet;
	
} 

-(void)playerLostHand{}
-(void)playerWonHand{}




@end
