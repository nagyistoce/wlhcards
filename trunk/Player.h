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
//	GameView	*view;
}
@property (nonatomic, retain) Hand *playerHand;
@property (nonatomic) float currentBet;
@property (nonatomic) float money;

-(float)askForBet; // returns bet amount
-(void)playerLostHand;
-(void)playerWonHand;

-(void)display;
-(void)print;

@end
