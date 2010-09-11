//
//  DetailController.h
//  RssReader
//
//  Created by Oscar Del Ben on 6/18/10.
//  Copyright 2010 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailController : UIViewController {
	NSDictionary *item;
	IBOutlet UILabel *itemTitle;
	IBOutlet UILabel *itemDate;
	IBOutlet UIWebView *itemSummary;
}

@property (retain, nonatomic) NSDictionary *item;
@property (retain, nonatomic) IBOutlet UILabel *itemTitle;
@property (retain, nonatomic) IBOutlet UILabel *itemDate;
@property (retain, nonatomic) IBOutlet UIWebView *itemSummary;

- (id)initWithItem:(NSDictionary *)theItem;

- (IBAction)playPodcast:(id)sender;

@end
