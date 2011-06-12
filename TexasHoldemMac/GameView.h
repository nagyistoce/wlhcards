
// ******** This version only for Mac Cocoa !!!! Not for Console !


//
//  gameView.h
//  cards
//
//  Created by Warren Holybee on 4/7/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Cocoa/Cocoa.h"

@interface GameView : NSViewController {
	
	int		numberOfPlayers;
	NSMutableArray *players;
	NSMutableArray *flop;
	
	IBOutlet NSTextField *boardField;
	IBOutlet NSTextField *statusOne;
	IBOutlet NSTextField *potField;	
	
	
}
@property (nonatomic, retain) NSMutableArray *players;
@property (nonatomic) int	numberOfPlayers;
@property (nonatomic, retain) NSMutableArray *flop;
@property (nonatomic, retain) NSString *nibName;
@property (nonatomic, retain) NSTextField *boardField;
@property (nonatomic, retain) NSTextField *statusOne;
@property (nonatomic, retain) NSTextField *potField;


-(void)displayPlayer:(Player *)player;
-(void)display;
-(int)askNumberOfPlayers;
-(void)getBlindBets;
-(float)getBetFromPlayer:(Player *)player;
-(void)displayBoard;
-(void)invalidBet:(float)lastBet;
-(void)addPlayersToWindow:(NSWindow *) window;
-(void)updatePot:(float) pot;
-(void)winner:(int) winner;
-(void)removePlayer:(Player *) player fromWindow:(NSWindow *) window;
-(void)removeBoard;

@end
