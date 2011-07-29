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
    
    // prefs
    float maxBet;
    float minBet;
    float startFunds;
    float littleBlind;
    float bigBlind;
    BOOL useBlind;
    BOOL showAICards;
    BOOL showWinChance;
    
    IBOutlet NSTextField *minField;
    IBOutlet NSTextField *maxField;
    IBOutlet NSTextField *startFundsField;
    IBOutlet NSTextField *littleBlindField;
    IBOutlet NSTextField *bigBlindField;
    IBOutlet NSButton *blindButton;
    IBOutlet NSWindow *prefs;
    IBOutlet NSButton *showAICardsButton;
    IBOutlet NSButton *showWinChanceButton;
	


}
@property (nonatomic, retain) cardsAppDelegate *delegate;
@property (nonatomic, retain) NSMutableArray *players;
@property (nonatomic, retain) GameView *gameView;
@property (nonatomic, retain) NSWindow *aWindow;
@property (nonatomic, retain) NSWindow *playersSheet;
@property (nonatomic,retain) NSTextField *numberOfPlayersText;
@property (nonatomic, retain) NSTextField *minField;
@property (nonatomic, retain) NSTextField *maxField;
@property (nonatomic, retain) NSTextField *startFundsField;
@property (nonatomic, retain) NSTextField *littleBlindField;
@property (nonatomic, retain) NSTextField *bigBlindField;
@property (nonatomic, retain) NSButton *blindButton;
@property (nonatomic, retain) NSButton *showAICardsButton;
@property (nonatomic, retain) NSButton *showWinChanceButton;
@property (nonatomic, retain) NSWindow *prefs;
@property (readonly) int nextStep;
@property (readonly) BOOL showAICards;
@property (readonly) BOOL showWinChance;
// deal cards methods

// start/end hand or game

-(void) openPlayersSheet;
-(IBAction) endPlayersSheet:(id)sender;
-(void) setupDeckFlopPlayers;
-(void) setupNewDeck;
-(void) endHand;
-(void) endGame;
-(void) startGame;
-(void) startHand;
-(void) playAgain;


// user prefs
-(void) registerUserDefaults;
-(void) showPrefs;
-(void) closePrefs;
-(void) readDefaults;

// game logic
-(void) gotBetFromPlayer:(Player *) player;
-(BOOL) betsAreSquare;
-(void) determineWinner;
-(void) disableBetButtons;
-(void) subtractMoneyFromPlayer:(Player *) player;
-(void) advanceGame;
-(void) gotBetFromPlayer:(Player *) player;
-(void) determineWinner;
-(void) setPlayerChanceToWin;
-(float) currentBet;

@end
