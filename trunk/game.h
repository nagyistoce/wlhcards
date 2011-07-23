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
    // game representation
	NSMutableArray *players;
	Deck *deck;
	NSMutableArray *flop;
	float pot;
	float currentBet;
	float lastBet;

    // GUI View of game     
    GameView *gameView;
	IBOutlet NSWindow *aWindow;
    IBOutlet NSWindow *playersSheet;
    IBOutlet NSTextField *numberOfPlayersText;
	cardsAppDelegate  *delegate;

    // game logic
	int bettingPlayer;
	int nextStep;
	bool allPlayersBet;
    bool inGame;
	int numberOfPlayers;
	


}
@property (nonatomic, retain) cardsAppDelegate *delegate;
@property (nonatomic, retain) NSMutableArray *players;
@property (nonatomic, retain) GameView *gameView;
@property (nonatomic, retain) NSWindow *aWindow;
@property (nonatomic, retain) NSWindow *playersSheet;
@property (nonatomic,retain) NSTextField *numberOfPlayersText;

// deal cards methods

// start/end hand or game

-(void) openPlayersSheet;
-(IBAction) endPlayersSheet:(id)sender;
-(void) setupDeckFlopPlayers;
-(void) setupNewDeck;
-(void) endHand;
-(void) startGame;
-(void) startHand;
-(void) playAgain;

// game logic
-(void) gotBetFromPlayer:(Player *) player;
-(BOOL) betsAreSquare;
-(void) determineWinner;
-(void) disableBetButtons;
-(void) subtractMoneyFromPlayer:(Player *) player;
-(void) advanceGame;





-(void)gotBetFromPlayer:(Player *) player;
-(void)determineWinner;
@end
