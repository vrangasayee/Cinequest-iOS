//
//  EventsViewController.h
//  CineQuest
//
//  Created by Luca Severini on 10/1/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

@class CinequestAppDelegate;

@interface EventsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>	
{
	CinequestAppDelegate *delegate;
	NSMutableArray *mySchedule;
    UIFont *titleFont;
	UIFont *timeFont;
	UIFont *venueFont;
	UIFont *sectionFont;
	NSDataDetector *dateDetector;
}

@property (nonatomic, strong) IBOutlet UITableView *eventsTableView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UISegmentedControl *switchTitle;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableDictionary *dateToEventsDictionary;
@property (nonatomic, strong) NSMutableArray *sortedKeysInDateToEventsDictionary;
@property (nonatomic, strong) NSMutableArray *sortedIndexesInDateToEventsDictionary;
@property (nonatomic, strong) NSMutableDictionary *dateToFilmsDictionary;
@property (nonatomic, strong) NSMutableArray *sortedKeysInDateToFilmsDictionary;
@property (nonatomic, strong) NSMutableArray *sortedIndexesInDateToFilmsDictionary;

//combined dictionaries (so all films/events/forums are displayed in schedule.
@property (nonatomic, strong) NSMutableDictionary *dateToCombinedDictionary;
@property (nonatomic, strong) NSMutableArray *sortedKeysInDateToCombinedDictionary;
@property (nonatomic, strong) NSMutableArray *sortedIndexesInDateToCombinedDictionary;

@end
