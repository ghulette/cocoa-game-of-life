//
//  LifeView.m
//  Cocoa Game of Life
//
//  Created by Geoff Hulette on 8/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LifeView.h"

@implementation LifeView

-(id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  return self;
}

-(void)drawRect:(NSRect)rect
{
  PetriDish *dish = [controller petriDish];
  int dishSize = [dish size];
  NSRect frame = [self frame];
  float cellWidth = frame.size.width / dishSize;
  float cellHeight = frame.size.height / dishSize;
  NSRect cellRect;
  cellRect.size.width = cellWidth;
  cellRect.size.height = cellHeight;
  NSColor *onColor = [NSColor yellowColor];
  NSColor *offColor = [NSColor darkGrayColor];
  NSColor *strokeColor = [NSColor blackColor];
  
  
  [strokeColor setStroke];
  for(int row=0; row < dishSize; row ++) {
    for(int col=0; col < dishSize; col ++) {
      cellRect.origin.x = col * cellWidth;
      cellRect.origin.y = row * cellHeight;
      NSColor *fillColor = [dish cellAtX:col Y:row] ? onColor : offColor;
      [fillColor setFill];
      [NSBezierPath fillRect:cellRect];
      [NSBezierPath strokeRect:cellRect];
    }
  }
}

-(void)mouseDown:(NSEvent *)event
{
  PetriDish *dish = [controller petriDish];
  NSPoint pt = [self convertPoint:[event locationInWindow] fromView:nil];
  NSRect rect = [self frame];
  int x = (pt.x / rect.size.width) * [dish size];
  int y = (pt.y / rect.size.height) * [dish size];
  NSLog(@"Click: %d,%d", x, y);
  [controller flipCellAtX:x Y:y];
}

@end
