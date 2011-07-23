//
//  cardsAppDelegate.h
//  cards
//
//  Created by Warren Holybee on 4/21/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameView.h"
#import "game.h"

@interface cardsAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet game *theGame;
    IBOutlet NSWindow *prefs;
    IBOutlet NSTextField *minField;
    IBOutlet NSTextField *maxField;
    IBOutlet NSTextField *startFundsField;
    IBOutlet NSTextField *littleBlindField;
    IBOutlet NSTextField *bigBlindField;
    IBOutlet NSButton *blindButton;
}


-(IBAction) startGame:(id)sender;
-(IBAction)closePrefs:(id)sender;
-(IBAction)showPrefs:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) game *theGame;
@property (nonatomic, retain) NSTextField *minField;
@property (nonatomic, retain) NSTextField *maxField;
@property (nonatomic, retain) NSTextField *startFundsField;
@property (nonatomic, retain) NSTextField *littleBlindField;
@property (nonatomic, retain) NSTextField *bigBlindField;
@property (nonatomic, retain) NSButton *blindButton;


@end
