//
//  RssReaderAppDelegate.m
//  RssReader
//
//  Created by Oscar Del Ben on 6/11/10.
//  Copyright DibiStore 2010. All rights reserved.
//

#import "RssReaderAppDelegate.h"
#import "RootViewController.h"


@implementation RssReaderAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

