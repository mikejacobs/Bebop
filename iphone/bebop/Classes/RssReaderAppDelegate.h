//
//  RssReaderAppDelegate.h
//  RssReader
//
//  Created by Oscar Del Ben on 6/11/10.
//  Copyright DibiStore 2010. All rights reserved.
//

@interface RssReaderAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

