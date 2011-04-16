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
}
@property (nonatomic, retain) NSMutableArray *players;

-(void) gameLoop;

@end
