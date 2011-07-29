//
//  AIPlayer.h
//  cards
//
//  Created by Warren Holybee on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@interface AIPlayer : Player
{
    int betRound;
}

-(void) sendBet;

@end
