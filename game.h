//
//  game.h
//  cards
//
//  Created by Warren Holybee on 1/19/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Foundation/Foundation.h>
#define wDeal2Cards	0
#define wDealFlop	1
#define wDealTurn	2
#define wDealRiver	3
#define wDetermineWinner 4
#define wHandOver	5


@class GameView;
@class Deck;
@class cardsAppDelegate;
@class Player;

@interface game : NSObject {
	NSMutableArray *players;
	GameView *gameView;
	Deck *deck;
	NSMutableArray *flop;
	float pot;
	float currentBet;
	float lastBet;
	int numberOfPlayers;
	cardsAppDelegate  *delegate;
	int bettingPlayer;
	int nextStep;
	bool allPlayersBet;
	
#if !(text_only==1)
	NSWindow *aWindow;
#endif
}
@property (nonatomic, retain) cardsAppDelegate *delegate;
@property (nonatomic, retain) NSMutableArray *players;
@property float pot;
@property (nonatomic, retain) GameView *gameView;
#if !(text_only==1)
@property (nonatomic, retain) NSWindow *aWindow;
#endif

-(void) gameLoop;
-(BOOL) betsAreSquare;
-(void) endHand;
-(void) startHand;

-(void) setWindow:(NSWindow *)window;

-(void)setupDeckFlopPlayers;
-(void)setupNewDeck;
-(void)gotBetFromPlayer:(Player *) player;

@end
