//
//  deck.h
//  cards
//
//  Created by Warren Holybee on 1/2/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "card.h"
#import "Hand.h"

@interface Deck : NSObject {

	NSMutableArray *cards;
	

}

-(void)shuffle;
-(void)print;
-(Hand *)deal; // Deal a Hand
-(void)sort;
-(Card *)dealCard; // Deal only one card


@property (retain, nonatomic) NSMutableArray *cards;
@end

