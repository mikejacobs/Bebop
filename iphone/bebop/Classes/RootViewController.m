//
//  RootViewController.m
//  RssReader
//
//  Created by Oscar Del Ben on 6/11/10.
//  Copyright DibiStore 2010. All rights reserved.
//

#import "RootViewController.h"
#import "Parser.h"
#import "DetailController.h"

@interface RootViewController (PrivateMethods)
- (void)loadData;
@end

@implementation RootViewController

@synthesize activityIndicator, items;

- (void)viewDidLoad {
    [super viewDidLoad];
	
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	indicator.hidesWhenStopped = YES;
	[indicator stopAnimating];
	self.activityIndicator = indicator;
	[indicator release];
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:indicator];
	self.navigationItem.rightBarButtonItem = rightButton;
	[rightButton release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
	[self loadData];
    [super viewDidAppear:animated];
}

- (void)loadData {
	if (items == nil) {
		[activityIndicator startAnimating];
		
		Parser *rssParser = [[Parser alloc] init];
		[rssParser parseRssFeed:@"http://thefmly.com/feed" withDelegate:self];
		
		[rssParser release];
		
	} else {
		[self.tableView reloadData];
	}
	
}

- (void)receivedItems:(NSArray *)theItems {
	items = theItems;
	[self.tableView reloadData];
	[activityIndicator stopAnimating];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	
	cell.textLabel.text = [[items objectAtIndex:indexPath.row] objectForKey:@"title"];
	
	// Format date
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];	
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	cell.detailTextLabel.text = [dateFormatter stringFromDate:[[items objectAtIndex:indexPath.row] objectForKey:@"date"]];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}




// Override to support row selection in the table view.
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	 NSDictionary *theItem = [items objectAtIndex:indexPath.row];
	 DetailController *nextController = [[DetailController alloc] initWithItem:theItem];
	 [self.navigationController pushViewController:nextController animated:YES];
	 [nextController release];
 }


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[activityIndicator release];
	[items release];
    [super dealloc];
}


@end

