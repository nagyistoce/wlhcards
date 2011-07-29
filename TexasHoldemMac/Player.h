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

@interface Player : NSViewController {
	Hand   *playerHand;
	float	money;
	float	currentBet;
	NSString *name;
	GameView *gameView;
	BOOL	hasBet;
    NSString *nibName;
    float winChance;

	IBOutlet NSTextField *nameLabel;
	IBOutlet NSTextField *handField;
	IBOutlet NSTextField *betField;
	IBOutlet NSButton *betButton;
	IBOutlet NSTextField *moneyField;
    IBOutlet NSImageView *cardImage1;
    IBOutlet NSImageView *cardImage2;
    IBOutlet NSTextField *winField;
		
}

@property (nonatomic, retain) Hand *playerHand;
@property (nonatomic) float currentBet;
@property (nonatomic) float money;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) GameView *gameView;
@property (nonatomic, retain) NSString *nibName;
@property (nonatomic) BOOL hasBet;
@property (nonatomic, retain) NSTextField *nameLabel;
@property (nonatomic, retain) NSTextField *handField;
@property (nonatomic, retain) NSTextField *betField;
@property (nonatomic, retain) NSButton *betButton;
@property (nonatomic, retain) NSTextField *moneyField;
@property (nonatomic, retain) NSTextField *winField;
@property float winChance;


-(void)askForBet; // returns bet amount
-(void)playerLostHand;
-(void)playerWonHand;
-(Hand *) getPlayerHand;
-(void)display;
-(IBAction)betButton:(id) sender ;


@end
