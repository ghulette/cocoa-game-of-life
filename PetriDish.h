//
//  PetriDish.h
//  Cocoa Game of Life
//
//  Created by Geoff Hulette on 8/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define GRID_SIZE (50)

@interface PetriDish : NSObject {
	int size;
	BOOL *world, *buffer;
}

-(int)size;
-(void)randomize;
-(void)clear;
-(int)step;
-(BOOL)cellAtX:(int)x Y:(int)y;
-(void)flipCellAtX:(int)x Y:(int)y;

@end
