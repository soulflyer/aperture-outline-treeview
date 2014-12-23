//
//  AppDelegate.m
//  Aperture-Outline-Treeview
//
//  Created by Iain Wood on 23/12/2014.
//  Copyright (c) 2014 soulflyer. All rights reserved.
//

#import "AppDelegate.h"
#import "TreeNode.h"
@class Aperture;

@interface Aperture:NSObject
// declare methods here
+(NSString *)libraryPath;
-(NSString *)libraryPath;
-(NSArray  *)topLevelFolders;
-(NSArray  *)getAllProjects;

@end

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

- (void)awakeFromNib{
  aperture = [[NSClassFromString(@"Aperture") alloc] init];
  [treeController setContent:[self generateApertureTree:[aperture getAllProjects]]];
  [outlineView reloadData];
}

-(NSArray *)generateApertureTree:(NSArray *)apertureData {
  //  apertureData is an array of Dictionaries representing each year
  //  each year dictionary contains a yearName and an array of dictionaries representing months
  //  each month dictionary contains a name and an array of dictionaries representing projects
  //  ie:
  //
  //  NSArray *ar = [aperture getAllProjects];
  //  NSArray *aYear = ar[0];
  //  NSArray *aMonth = [aYear valueForKey:@"months"][2];
  //  NSDictionary *aProject = [aMonth valueForKey:@"projectNames"][3];
  //  NSLog(@"%@",aProject);
  //
  //  will show the 4th project of the 3rd month of the first year
  
  NSTreeNode *yearNode;
  NSTreeNode *monthNode;
  NSTreeNode *projectNode;
  NSMutableArray *rootNodes = [NSMutableArray array];
  for (id year in apertureData) {
    yearNode = [ TreeNode makeNode:[year valueForKey:@"yearName"]];
    for (id month in [year valueForKey:@"months"]){
      monthNode = [TreeNode makeNode:[month valueForKey:@"monthName"]];
      for (id project in [month valueForKey:@"projectNames"]){
        projectNode = [TreeNode makeNode:[project valueForKey:@"projectName"]];
        [[monthNode mutableChildNodes] addObject:projectNode];
      }
      [[yearNode mutableChildNodes] addObject:monthNode];
    }
    [rootNodes addObject:yearNode];
  }
  return rootNodes;
}


@end
