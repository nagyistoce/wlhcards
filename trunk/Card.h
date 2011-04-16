//
//  card.h
//  cards
//
//  Created by Warren Holybee on 1/2/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import <Foundation/Foundation.h>

#define wSpade		0
#define wHeart		1
#define wClub		2
#define wDiamond	3


#define wAce		14
#define wTwo		2
#define wThree		3
#define wFour		4
#define wFive		5
#define wSix		6
#define wSeven		7
#define wEight		8
#define wNine		9
#define wTen		10
#define wJack		11
#define wQueen		12
#define wKing		13


@interface Card : NSObject {
	
	int suit;
	int faceValue;
	
}
@property int suit;
@property int faceValue;

-(void) print;
-(NSComparisonResult) compare:(Card *)otherCard;

@end
