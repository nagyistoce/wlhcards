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
    float   lastBet;
	NSString *name;
	GameView *gameView;

    NSString *nibName;
    float winChance;

	IBOutlet NSTextField *nameLabel;
	IBOutlet NSTextField *handField;
	IBOutlet NSTextField *betField;
    
	IBOutlet NSButton *betButton;
    IBOutlet NSButton *checkButton;
    IBOutlet NSButton *callButton;
    IBOutlet NSButton *foldButton;
    IBOutlet NSButton *raiseButton;
    
    
	IBOutlet NSTextField *moneyField;
    IBOutlet NSImageView *cardImage1;
    IBOutlet NSImageView *cardImage2;
    IBOutlet NSTextField *winField;
		
}

@property (nonatomic, retain) Hand *playerHand;
@property (nonatomic) float currentBet, lastBet;
@property (nonatomic) float money;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) GameView *gameView;
@property (nonatomic, retain) NSString *nibName;
@property (nonatomic, retain) NSTextField *nameLabel;
@property (nonatomic, retain) NSTextField *handField;
@property (nonatomic, retain) NSTextField *betField;
@property (nonatomic, retain) NSButton *betButton;
@property (nonatomic, retain) NSButton *checkButton;
@property (nonatomic, retain) NSButton *callButton;
@property (nonatomic, retain) NSButton *foldButton;
@property (nonatomic, retain) NSButton *raiseButton;



@property (nonatomic, retain) NSTextField *moneyField;
@property (nonatomic, retain) NSTextField *winField;
@property float winChance;

-(void) loadTheNib;
-(void)askForBet; // returns bet amount
-(void)playerLostHand;
-(void)playerWonHand;
-(Hand *) getPlayerHand;
-(void)display;
-(IBAction)betButton:(id) sender ;
-(IBAction)callButton:(id)sender;
-(IBAction)raiseButton:(id)sender;

@end
