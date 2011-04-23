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
@end
