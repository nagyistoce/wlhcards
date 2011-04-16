//
//  gameView.h
//  cards
//
//  Created by Warren Holybee on 4/7/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface GameView : NSObject {
	
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
-(void)getEveryonesBet;
-(void)getBlindBets;


@end