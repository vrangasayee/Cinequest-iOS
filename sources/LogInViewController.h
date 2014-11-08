//
//  LogInViewController.h
//  CineQuest
//
//  Created by harold lee on 11/11/09.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "MyCinequestViewController.h"


@interface LogInViewController : UIViewController 
<UIActionSheetDelegate>
{
	IBOutlet UITextField *passwordLabel;
	IBOutlet UITextField *usernameLabel;	
	MyCinequestViewController *parentsView;
}
@property (nonatomic,strong) IBOutlet UITextField *passwordLabel;
@property (nonatomic,strong) IBOutlet UITextField *usernameLabel;
@property (nonatomic,strong) MyCinequestViewController *parentsView;

-(IBAction)loginUser:(id)sender;
-(IBAction)signup:(id)sender;
-(IBAction)uploadList:(id)sender;
-(void)setParent:(MyCinequestViewController *)parent;
-(BOOL)checkInputFields;

@end