//
//  Hand.h
//  cards
//
//  Created by Warren Holybee on 1/3/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Hand : NSObject {
	NSMutableArray *cards;
	BOOL	isSevenCardHand;
	long	rank;
	int		highCardRank;

}
@property (nonatomic, retain) NSMutableArray *cards;
@property (nonatomic) BOOL isSevenCardHand;
@property int highCardRank;

-(BOOL)addCard:(Card *)card;
-(void)print;
-(void)sort;
-(long)rank;
-(long)rankSeven;
-(float)strengthAgainst:(Hand *)otherHand;
-(void)invalidateRank;

@end
