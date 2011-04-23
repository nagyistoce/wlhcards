
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
	
IBOutlet NSTextField *player1Label;	
IBOutlet NSTextField *player2Label;
IBOutlet NSTextField *player3Label;
IBOutlet NSTextField *player4Label;
	
IBOutlet NSTextField *player1Hand;
IBOutlet NSTextField *player2Hand;
IBOutlet NSTextField *player3Hand;
IBOutlet NSTextField *player4Hand;
	
IBOutlet NSTextField *player1Bet;
IBOutlet NSTextField *player2Bet;
IBOutlet NSTextField *player3Bet;
IBOutlet NSTextField *player4Bet;
	
	
	
}
@property (nonatomic, retain) NSMutableArray *players;
@property (nonatomic) int	numberOfPlayers;
@property (nonatomic, retain) NSMutableArray *flop;

-(void)displayPlayer:(Player *)player;
-(void)display;
-(int)askNumberOfPlayers;
-(void)getBlindBets;
-(float)getBetFromPlayer:(Player *)player;
-(void)displayBoard;
-(void)invalidBet:(float)lastBet;

-(IBAction)player1Bet;
-(IBAction)player2Bet;
-(IBAction)player3Bet;
-(IBAction)player4Bet;


@end
