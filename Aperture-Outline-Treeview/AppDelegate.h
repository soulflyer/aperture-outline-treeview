//
//  AppDelegate.h
//  Aperture-Outline-Treeview
//
//  Created by Iain Wood on 23/12/2014.
//  Copyright (c) 2014 soulflyer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Aperture;

@interface AppDelegate : NSObject <NSApplicationDelegate>{
  IBOutlet NSTreeController *treeController;
  IBOutlet NSOutlineView *outlineView;
  Aperture *aperture;
}


@end

