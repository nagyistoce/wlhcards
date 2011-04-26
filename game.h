//
//  game.h
//  cards
//
//  Created by Warren Holybee on 1/19/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameView;
@class Deck;

@interface game : NSObject {
	NSMutableArray *players;
	GameView *gameView;
	Deck *deck;
	NSMutableArray *flop;
	float pot;
	float currentBet;
	float lastBet;
#if !(text_only==1)
	NSWindow *aWindow;
#endif
}
@property (nonatomic, retain) NSMutableArray *players;
@property float pot;
@property (nonatomic, retain) GameView *gameView;
#if !(text_only==1)
@property (nonatomic, retain) NSWindow *aWindow;
#endif

// text based methods
-(void) gameLoop;
-(BOOL) betsAreSquare;
-(void) getEveryonesBet;

// GUI methods
#if !(text_only==1)
-(void) setWindow:(NSWindow *)window;
#endif

// Common
-(void)setupDeckFlopPlayers;

@end
