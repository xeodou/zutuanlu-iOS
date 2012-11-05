//
//  ContactsViewController.h
//  zutuanlu
//
//  Created by xeodou on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *contacts;
- (IBAction)logoutAction:(id)sender;
@end
