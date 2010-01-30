//
//  PetriDish.m
//  Cocoa Game of Life
//
//  Created by Geoff Hulette on 8/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PetriDish.h"
#import <dispatch/dispatch.h>


@implementation PetriDish

-(id)init
{
	self = [super init];
  if(self) {
		size = GRID_SIZE;
		world = malloc(size * size * sizeof(BOOL));
		buffer = malloc(size * size * sizeof(BOOL));
		srandomdev();
  }
  return self;
}

-(void)dealloc
{
	free(buffer);
	free(world);
  [super dealloc];
}

-(int)size
{
  return size;
}

-(BOOL)cellAtX:(int)x Y:(int)y
{
  if(x < 0 || x >= GRID_SIZE || y < 0 || y >= GRID_SIZE) {
    return false;
  } else {
    return world[y * size + x];
  }
}

-(int)neighborsAtX:(int)x Y:(int)y
{
  int sum = 0;
  sum += [self cellAtX: x-1 Y: y-1];
  sum += [self cellAtX: x   Y: y-1];
  sum += [self cellAtX: x+1 Y: y-1];
  sum += [self cellAtX: x-1 Y: y];
  sum += [self cellAtX: x+1 Y: y];
  sum += [self cellAtX: x-1 Y: y+1];
  sum += [self cellAtX: x   Y: y+1];
  sum += [self cellAtX: x+1 Y: y+1];
  return sum;
}

-(void)prepareUpdate
{
  memcpy(buffer, world, size * size * sizeof(BOOL));
}

-(void)swap
{
  memcpy(world, buffer, size * size * sizeof(BOOL));
}

-(void)setCellAtX:(int)x Y:(int)y toVal:(BOOL)v
{
	buffer[y * size + x] = v;
}

-(void)randomize
{
  [self prepareUpdate];
	for(int row=0; row < size; row++) {
		for(int col=0; col < size; col++) {
			[self setCellAtX:col Y:row toVal:random()&01];
		}
	}
  [self swap];
}

-(void)clear
{
  [self prepareUpdate];
	for(int row=0; row < size; row++) {
		for(int col=0; col < size; col++) {
			[self setCellAtX:col Y:row toVal:false];
		}
	}
  [self swap];
}

-(int)step
{
  int numTransitions = 0;
  [self prepareUpdate];
	for(int row=0; row < size; row++) {
		for(int col=0; col < size; col++) {
      int n = [self neighborsAtX:col Y:row];
      if([self cellAtX:col Y:row]) {
        if(n <= 1 || n >= 4) {
          [self setCellAtX:col Y:row toVal:false];
          numTransitions ++;
        }
      }
      else {
        if(n == 3) {
          [self setCellAtX:col Y:row toVal:true];
          numTransitions ++;
        }
      }
    }
  }
  [self swap];
  return numTransitions;
}

-(int)stepGCD
{
  dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  int numTransitions = 1;
  [self prepareUpdate];
  dispatch_apply(size, q, ^(size_t row){
		for(int col=0; col < size; col++) {
      int n = [self neighborsAtX:col Y:row];
      if([self cellAtX:col Y:row]) {
        if(n <= 1 || n >= 4) {
          [self setCellAtX:col Y:row toVal:false];
        }
      }
      else {
        if(n == 3) {
          [self setCellAtX:col Y:row toVal:true];
        }
      }
    }
  });
  [self swap];
  return 1;
}

-(void)flipCellAtX:(int)x Y:(int)y
{
  [self prepareUpdate];
  [self setCellAtX:x Y:y toVal:![self cellAtX:x Y:y]];
  [self swap];
}

@end
