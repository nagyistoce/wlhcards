//
//  Player.m
//  cards
//
//  Created by Warren Holybee on 4/2/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "Player.h"
#import "Hand.h"

@implementation Player
@synthesize playerHand;
@synthesize currentBet, money;

-(id)init {
	if (self = [super init]) {
		
		playerHand = [[Hand alloc] init];
		money = 100.00;
	}
	return self;
}
		
-(void) dealloc {
	[playerHand release];
	[super dealloc];
}
	
-(void) display {
	
	[playerHand print];
}

-(void) print {
	[self display];
}

-(Hand *) getPlayerHand {
	return playerHand;
}

-(float)askForBet{return 0;} // returns bet amount
-(void)playerLostHand{}
-(void)playerWonHand{}




@end
