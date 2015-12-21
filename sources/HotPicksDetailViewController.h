//
//  HotPicksDetailViewController.h
//  CineQuest
//
//  Modified by Chris Pollett from NewsDetailViewController (Luca Severini)
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//


@class Special;
@class Schedule;
@class CinequestAppDelegate;

@interface HotPicksDetailViewController : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIAlertViewDelegate, GPPSignInDelegate, GPPShareDelegate>
{
	CinequestAppDelegate *delegate;
	NSString *hotPicksName;
	NSString *infoLink;
	UIFont *actionFont;
	UIFont *sectionFont;
	NSInteger googlePlusConnectionDone;
	BOOL viewWillDisappear;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSDictionary *hotPicks;

- (id) initWithData:(NSDictionary*)hotPicksData;

@end
