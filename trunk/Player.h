//
//  Player.h
//  cards
//
//  Created by Warren Holybee on 4/2/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Hand;
@class GameView;

@interface Player : NSObject {
	Hand   *playerHand;
	float	money;
	float	currentBet;
	NSString *name;
	GameView *gameView;
	
}
@property (nonatomic, retain) Hand *playerHand;
@property (nonatomic) float currentBet;
@property (nonatomic) float money;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) GameView *gameView;

-(float)askForBet; // returns bet amount
-(void)playerLostHand;
-(void)playerWonHand;
-(Hand *) getPlayerHand;
-(void)display;
-(void)print;

@end
