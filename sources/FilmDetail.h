//
//  FilmDetail.h
//  CineQuest
//
//  Created by Loc Phan on 10/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

@class CinequestAppDelegate;
@class Schedule;
@class FBSession;

@interface FilmDetail : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
{
	NSString *filmId;
	Schedule *myFilmData;
	FBSession *_session;
	UIButton *postThisButton;
	CinequestAppDelegate *delegate;
	NSMutableArray *mySchedule;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;

- (id) initWithTitle:(NSString*)name andId:(NSString *)Id;

@end
