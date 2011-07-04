//
//  card.m
//  cards
//
//  Created by Warren Holybee on 1/2/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "Card.h"


@implementation Card
@synthesize suit, faceValue, image;
-(id)init {
	suit = wSpade;
	faceValue = wAce;
	[super init];
	return self;
}

-(void) loadImage {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *cardFile = [NSString stringWithFormat:@"/%@.png",[self cardString]];
    NSString *filePath = [resourcePath stringByAppendingString:cardFile];
    NSLog(@"%@",filePath);
    
    if (image) [image release];
    
    image = [[NSImage alloc] initWithContentsOfFile:filePath];
    
   
}

-(NSString *)cardString {
	char mysuit;
	char myfaceValue;
	switch (self.suit)
	{
		case wHeart:
			mysuit = 'H';
			break;
		case wClub:
			mysuit = 'C';
			break;
		case wSpade:
			mysuit = 'S';
			break;
		case wDiamond:
			mysuit = 'D';
			break;
		default:
			mysuit = '?';
			break;
            
	}
	
	switch (self.faceValue) {
		case wJack:
			myfaceValue = 'J';
			break;
		case wQueen:
			myfaceValue = 'Q';
			break;
		case wKing:
			myfaceValue = 'K';
			break;
		case wAce:
			myfaceValue = 'A';
			break;
		case wTen:
			myfaceValue = 'X';
			break;
		default:
			myfaceValue = self.faceValue+48;
			break;
	}
	
	NSString *cardStr = [NSString stringWithFormat:@"%c%c",myfaceValue,mysuit];
	[cardStr retain];
	[cardStr autorelease];
	return cardStr;
    
}

-(NSString *)print {
	NSString *cardStr = [self cardString];
	[cardStr retain];
	[cardStr autorelease];
	printf("%s",[cardStr UTF8String] );

	return cardStr;

}

-(NSComparisonResult)compare:(Card *)otherCard {
	// compare face value, and return sort order
	if (self.faceValue > otherCard.faceValue) {
		//NSLog(@"%d : %d Decending",self.faceValue,otherCard.faceValue);
		return NSOrderedDescending;
		
	}
	
	if (self.faceValue < otherCard.faceValue) {
		//NSLog(@"%d : %d Ascending",self.faceValue,otherCard.faceValue);
		return NSOrderedAscending;
	
	}
	// if cards are equal, then sort on suit
	if (self.faceValue == otherCard.faceValue) {
		if (self.suit > otherCard.suit) {
			//NSLog(@"%d : %d Decending suit",self.faceValue,otherCard.faceValue);
			return NSOrderedDescending;
			
		}
		
		if (self.suit < otherCard.suit) {
			//NSLog(@"%d : %d Acending suit",self.faceValue,otherCard.faceValue);
			return NSOrderedAscending;
			
		}
		
	// there should never be two of the exact same card in a deck or hand
//		NSLog(@"%d : %d Same! How is this Possible?",self.faceValue,otherCard.faceValue);
		return NSOrderedSame;
	}
	NSLog(@"Sort Error.");
	return NSOrderedSame;
	
}
	
-(void) dealloc {
    [image release];
    [super dealloc];
}
@end
