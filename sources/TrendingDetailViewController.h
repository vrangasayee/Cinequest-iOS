//
//  TrendingDetailViewController.h
//  CineQuest
//
//  Modified by Chris Pollett from NewsDetailViewController (Luca Severini)
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//


@class Special;
@class Schedule;
@class CinequestAppDelegate;

@interface TrendingDetailViewController : UIViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIAlertViewDelegate, GPPSignInDelegate, GPPShareDelegate>
{
	CinequestAppDelegate *delegate;
	NSString *trendingName;
	NSString *infoLink;
	UIFont *actionFont;
	UIFont *sectionFont;
	NSInteger googlePlusConnectionDone;
	BOOL viewWillDisappear;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSDictionary *trending;

- (id) initWithNews:(NSDictionary*)trendingData;

@end
