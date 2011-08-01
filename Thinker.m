//
//  Thinker.m
//  cards
//
//  Created by Warren Holybee on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Thinker.h"
#import "Player.h"
#import "Hand.h"
#import "cardsAppDelegate.h"

@implementation Thinker

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(id)initWithI:(int)a andJ:(int)b;
{
    i = a;
    j = b;
    return [self init];
}

-(void)think {
    float chance = 1.0;
    cardsAppDelegate *appDelegate =	[[NSApplication sharedApplication] delegate];
    NSMutableArray *players = [[appDelegate theGame] players];
    
            float temp = [[[players objectAtIndex:i] playerHand] 
                          strengthAgainst:[[players objectAtIndex:j] playerHand]];
            if (temp < chance) {
                chance = temp;    
            }
              
    [[players objectAtIndex:i] setWinChance:chance];
    NSLog(@"Done Thinking about player: %@",[[players objectAtIndex:i] name] );
}

@end
