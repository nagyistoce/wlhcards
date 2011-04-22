//
//  cardsAppDelegate.h
//  cards
//
//  Created by Warren Holybee on 4/21/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface cardsAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
