//
//  LifeView.h
//  Cocoa Game of Life
//
//  Created by Geoff Hulette on 8/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Controller.h"

@interface LifeView : NSView {
  IBOutlet Controller *controller;
}

@end
