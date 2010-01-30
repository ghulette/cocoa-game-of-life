//
//  Controller.m
//  Cocoa Game of Life
//
//  Created by Geoff Hulette on 8/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"


@implementation Controller

-(void)awakeFromNib
{
  NSSize aspectRatio = {1, 1};
  NSSize defaultSize = {300, 300};
  NSSize minSize = {200, 200};
  [window setContentAspectRatio:aspectRatio];
  [window setContentSize:defaultSize];
  [window setContentMinSize:minSize];
  [window center];  
  
  timer = nil;
  petriDish = [[PetriDish alloc] init];
  [petriDish randomize];
}

-(PetriDish *)petriDish
{
  return petriDish;
}

-(IBAction)randomize:(id)sender
{
  if(timer == nil) {
    [petriDish randomize];
    [view display];
  }
}

-(IBAction)clear:(id)sender
{
  if(timer == nil) {
    [petriDish clear];
    [view display];
  }
}

-(void)step
{
  int nt = [petriDish step];
  [view display];
  if(nt == 0 && timer != nil) {
    [self stop:nil];
  }
}

-(IBAction)doStep:(id)sender
{
  if(timer == nil) {
    [self step];
  }
}

-(IBAction)start:(id)sender
{
  if(timer == nil) {
    timer = [NSTimer timerWithTimeInterval:1.0f/10.0f
                                    target:self 
                                  selector:@selector(step) 
                                  userInfo:nil 
                                   repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
  }
}

-(IBAction)stop:(id)sender
{
  if(timer != nil) {
    [timer invalidate];
    timer = nil;
  }
}

-(void)flipCellAtX:(int)x Y:(int)y
{
  if(timer == nil) {
    [petriDish flipCellAtX:x Y:y];
    [view display];
  }
}

-(void)dealloc
{
  [petriDish release];
  [super dealloc];
}

@end
