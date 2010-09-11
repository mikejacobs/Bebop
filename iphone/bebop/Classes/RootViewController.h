//
//  RootViewController.h
//  RssReader
//
//  Created by Oscar Del Ben on 6/11/10.
//  Copyright DibiStore 2010. All rights reserved.
//

@interface RootViewController : UITableViewController {
	UIActivityIndicatorView *activityIndicator;
	NSArray *items;
}

@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) NSArray *items;

@end
