//
//  TrendingViewController.h
//  CineQuest
//
//  Converted from by Chris Pollett NewsViewController
//  Copyright (c) 2015 San Jose State University. All rights reserved.
//

@interface TrendingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
{
	UIFont *titleFont;
	BOOL tabBarAnimation;
}

@property (nonatomic, strong) IBOutlet UITableView *trendingTableView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UISegmentedControl *switchTitle;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *feed;

@end
