//
//  HotPicksViewController.m
//  CineQuest
//
//  Converted from NewController by Chris Pollett
//  Copyright (c) 2015 San Jose State University. All rights reserved.
//

#import "CinequestAppDelegate.h"
#import "HotPicksViewController.h"
#import "TrendingDetailViewController.h"
#import "DDXML.h"
#import "DataProvider.h"

static NSString *const kHotPicksCellIdentifier = @"HotPicksCell";

/*
 * Each cell of the table contains a thumbnail image and a short description of what the image is about.
 */

@implementation HotPicksViewController

@synthesize switchTitle;
@synthesize hotPicksTableView;
@synthesize activityIndicator;
@synthesize refreshControl;
@synthesize feed;

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/*
 * Function for loading app screen.
 * The screen is reloaded by a single data which doesn't vary or there is no editing operation
 * performed on data
 * The screen is reloaded by a single data which doesn't vary or there is no editing 
 * @return Nothing
 */
- (void) viewDidLoad
{
    //Sets the view when the screen for News Loads
    [super viewDidLoad];
    
    //Sets the menu bar animation. Enables the user to switch between menu tabs.
	tabBarAnimation = YES;
	
	titleFont = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    
	NSDictionary *attribute = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:16.0f] forKey:NSFontAttributeName];
	[switchTitle setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
	refreshControl = [UIRefreshControl new];
	[refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
	[((UITableViewController*)self.hotPicksTableView.delegate) setRefreshControl:refreshControl];
	[self.hotPicksTableView addSubview:refreshControl];
    
    // Sets the header and footer descriptions for the screen
	hotPicksTableView.tableHeaderView = nil;
	hotPicksTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

/*
 * Function for loading the screen with new data every time
 * @return Nothing
 */

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear: animated];
	
	[self performSelectorOnMainThread:@selector(loadData) withObject:nil waitUntilDone:NO];
    
	if(tabBarAnimation)
	{
		[appDelegate.tabBar.view setHidden:YES];
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:FEED_UPDATED_NOTIFICATION object:nil];
}
/*
 * Function to be called every time this view ceases to be the frontmost view
 * @return Nothing
 */
- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear: animated];
	
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 * Function to be called when the view is actually visible
 * @return Nothing
 */

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear: animated];
    
	if(tabBarAnimation)
	{
		// Don't show an ugly jerk while the bottom tabbar is drawn
		[UIView transitionWithView:appDelegate.tabBar.view duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^
         {
             [appDelegate.tabBar.view setHidden:NO];
         }
                        completion:nil];
		
		tabBarAnimation = NO;
	}
	
	if([[NSUserDefaults standardUserDefaults] boolForKey:@"TrendingUpdated"])
	{   // If the current news is updated, display News Updated message
		[appDelegate showMessage:@"Trending have been updated" onView:self.view hideAfter:3.0];
		
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TrendingUpdated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
	}
}

#pragma mark - Private Methods
/*
 * Function to refresh the view
 * @return Nothing
 */
- (void) refresh
{
	[self loadData];
    
	[refreshControl endRefreshing];
	
	[NSThread sleepForTimeInterval:0.5];
}

/*
 * Function to give notification on news update
 * @return Nothing
 */
- (void) receivedNotification:(NSNotification*) notification
{
    if ([[notification name] isEqualToString:FEED_UPDATED_NOTIFICATION]) // Not really necessary until there is only one notification
	{
 		[self performSelectorOnMainThread:@selector(loadData) withObject:nil waitUntilDone:NO];
        
		[appDelegate showMessage:@"Trending have been updated" onView:self.view hideAfter:3.0];
        // Set User Defaults to persist data across app launches
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TrendingUpdated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
	}
}

/*
 * Function to load the News data
 * @return Nothing
 */
- (void) loadData
{
	feed = [NSMutableArray new];
	
	NSData *xmlData = [appDelegate.dataProvider mainFeed];
	
	NSString* myString = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
	myString = [myString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	myString = [myString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	xmlData = [myString dataUsingEncoding:NSUTF8StringEncoding];
	// News is represented as an XML Document
	DDXMLDocument *newsXMLDoc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
	DDXMLElement *rootElement = [newsXMLDoc rootElement];
    
	NSInteger nodeCount = [rootElement childCount];
    // Loop through the news array
	for (NSInteger nodeIdx = 0; nodeIdx < nodeCount; nodeIdx++)
	{
		DDXMLElement *child = (DDXMLElement*)[rootElement childAtIndex:nodeIdx];
		NSString *childName = [child name];
		
		if ([childName isEqualToString:@"ArrayOfShows"])
		{
			NSInteger subNodeCount = [child childCount];
			for (NSInteger subNodeIdx = 0; subNodeIdx < subNodeCount; subNodeIdx++)
			{
				DDXMLElement *newsNode = (DDXMLElement*)[child childAtIndex:subNodeIdx];
				// Get the name, desciption, event image, info and image
				NSString *name = @"";
				NSString *description = @"";
				NSString *eventImageUrl = @"";
				NSString *info = @"";
				NSString *thumbImageUrl = @"";
                
				NSInteger subNode2Count = [newsNode childCount];
				if(subNode2Count != 0)
				{
					for (NSInteger subNode2Idx = 0; subNode2Idx < subNode2Count; subNode2Idx++)
					{
						DDXMLElement *newsSubNode = (DDXMLElement*)[newsNode childAtIndex:subNode2Idx];
						NSString *subNodename = [newsSubNode name];
						//Set each heading as follows
						if ([subNodename isEqualToString:@"Name"])
						{
							name = [newsSubNode stringValue];
                            NSLog(@"Item %ld named %@", (long)subNodeIdx, name);
						}
						else if ([subNodename isEqualToString:@"ShortDescription"])
						{
							description = [newsSubNode stringValue];
						}
						else if ([subNodename isEqualToString:@"EventImage"])
						{
							eventImageUrl = [newsSubNode stringValue];
						}
						else if ([subNodename isEqualToString:@"InfoLink"])
						{
							info = [newsSubNode stringValue];
						}
						else if ([subNodename isEqualToString:@"ThumbImage"])
						{
							thumbImageUrl = [newsSubNode stringValue];
						}
					}
                    // Add these to a NSMutableDictionary of items
					NSMutableDictionary *newsItem = [NSMutableDictionary new];
					[newsItem setObject:name forKey:@"name"];
					[newsItem setObject:description forKey:@"description"];
					[newsItem setObject:eventImageUrl forKey:@"eventImage"];
					[newsItem setObject:info forKey:@"info"];
					[newsItem setObject:thumbImageUrl forKey:@"thumbImage"];
					
					[feed addObject:newsItem];
				}
			}
		}
	}
    
	[self.hotPicksTableView reloadData];
}

#pragma mark - UITableView Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/*
 * Function to draw the table view
 * @return Returns the number of news items available
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [feed count];
}
/*
 * Function to place each news item in each cell of the table
 * @return Returns each table cell
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = [indexPath row];
	NSMutableDictionary *newsData = [feed objectAtIndex:row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotPicksCellIdentifier];
    if(cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHotPicksCellIdentifier];
	}
	else
	{
		[[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	}
	
	CGSize imgSize = CGSizeMake(0.0, 0.0);
    //Sets the thumbnail image
	NSString *imageUrl = [newsData objectForKey:@"thumbImage"];
	if(imageUrl.length != 0)
	{
		imageUrl = [appDelegate.dataProvider cacheImage:imageUrl];
		if(imageUrl.length != 0)
		{
			UIImage *image = [UIImage imageWithContentsOfFile:[[NSURL URLWithString:imageUrl] path]];
			imgSize = [image size];
			
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0, 6.0, imgSize.width, imgSize.height)];
			imageView.tag = CELL_IMAGE_TAG;
			imageView.image = image;
			[cell.contentView addSubview:imageView];
		}
	}
	// Sets the title for each cell
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 4.0 + imgSize.height, 305.0, 48.0)];
	titleLabel.tag = CELL_TITLE_LABEL_TAG;
	titleLabel.font = titleFont;
	titleLabel.numberOfLines = 2;
	titleLabel.text = [newsData objectForKey:@"name"];
    
	CGSize size = [titleLabel.text sizeWithAttributes:@{ NSFontAttributeName : titleFont }];
	if(size.width < 285.0)
	{
        // The dimensions of the cell that holds the news
		[titleLabel setFrame:CGRectMake(15.0, 4.0 + imgSize.height, 305.0, 26.0)];
		titleLabel.numberOfLines = 1;
	}
	
	[cell.contentView addSubview:titleLabel];
    
	// cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
    return cell;
}

#pragma mark - UITableView Delegate
/*
 * Function to perform some action when the user taps on a cell
 * @return Nothing
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = [indexPath row];
	NSDictionary *newsData = [feed objectAtIndex:row];
    
	TrendingDetailViewController *trendingDetail = [[TrendingDetailViewController alloc] initWithData:newsData];
	[self.navigationController pushViewController:trendingDetail animated:YES];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
 * Function to set the cell's height accordingly
 */

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Creates a news array
	NSMutableDictionary *newsData = [feed objectAtIndex:[indexPath row]];
    
	CGFloat height = 54.0;
    // After setting cell height, display title and image
	NSString *text = [newsData objectForKey:@"name"];
	CGSize size = [text sizeWithAttributes:@{ NSFontAttributeName : titleFont }];
	if(size.width < 285.0)
	{
		height = 34.0;
	}
    
	NSString *imageUrl = [newsData objectForKey:@"thumbImage"];
	if(imageUrl.length != 0)
	{
		imageUrl = [appDelegate.dataProvider cacheImage:imageUrl];
		if(imageUrl.length != 0)
		{
			UIImage *image = [UIImage imageWithContentsOfFile:[[NSURL URLWithString:imageUrl] path]];
			if(imageUrl != nil)
			{
				height += [image size].height;
			}
		}
	}
    
	return height;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0.01;		// This creates a "invisible" footer
}

@end



