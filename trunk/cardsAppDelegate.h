//
//  cardsAppDelegate.h
//  cards
//
//  Created by Warren Holybee on 4/21/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameView.h"

@interface cardsAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	GameView *gameView;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet GameView *gameView;

@end
