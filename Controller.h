//
//  Controller.h
//  Cocoa Game of Life
//
//  Created by Geoff Hulette on 8/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PetriDish.h"
@class LifeView;


@interface Controller : NSObject {
  IBOutlet NSWindow* window;
  IBOutlet NSView *view;
  PetriDish *petriDish;
  NSTimer *timer;
}

-(PetriDish *)petriDish;
-(IBAction)randomize:(id)sender;
-(IBAction)clear:(id)sender;
-(IBAction)doStep:(id)sender;
-(void)flipCellAtX:(int)x Y:(int)y;
-(IBAction)start:(id)sender;
-(IBAction)stop:(id)sender;

@end
