//
//  Thinker.h
//  cards
//
//  Created by Warren Holybee on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Thinker : NSObject {

int i;
int j;

}

-(id)initWithI:(int)i andJ:(int)j;
-(void)think;


@end
