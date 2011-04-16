//
//  gameView.m
//  cards
//
//  Created by Warren Holybee on 4/7/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "GameView.h"
#import "Player.h"
#import "Hand.h"
#import "Card.h"

@implementation GameView
@synthesize players, numberOfPlayers, flop;

-(void)display {
	
	
	for (int i=0;i<numberOfPlayers;i++)
	{
		printf("Player Number: %d\n\n",i+1);
		[self displayPlayer:[players objectAtIndex:i]];
		printf("\n\n\n");
	
	}
	
	printf("Board: (%d cards)\n",[flop count]);
	for (int i=0;i<[flop count];i++) {
		[[flop objectAtIndex:i] print];
	}
	printf("\n\n");
	
}

-(void)displayPlayer:(Player *)player {
	
	for (int i=0;i<[player.playerHand.cards count];i++) {
		printf(" ");
		[[player.playerHand.cards objectAtIndex:i] print];
	}
	
}


-(int)askNumberOfPlayers {
	return 4;
}

-(void)getEveryonesBet{}

-(void)getBlindBets{

	
	float p2bet;
	float p3bet;
	
	[[players objectAtIndex:1] print];
	printf("Player 2, what is your bet? (low blind): ");
	scanf("%f",&p2bet);
	((Player *)[players objectAtIndex:1]).currentBet = p2bet;
	
	if ([players count] > 2) {
		[[players objectAtIndex:2] print];
		printf("Player 3, what is your bet? (low blind): ");
		scanf("%f",&p3bet);
	((Player *)[players objectAtIndex:2]).currentBet = p2bet;	
	}
	
}

@end
