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
   }


-(IBAction) startGame:(id)sender;
-(IBAction)closePrefs:(id)sender;
-(IBAction)showPrefs:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) game *theGame;


@end
