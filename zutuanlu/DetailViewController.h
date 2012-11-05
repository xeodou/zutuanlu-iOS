//
//  DetailViewController.h
//  zutuanlu
//
//  Created by xeodou on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts.h"

@interface DetailViewController : UIViewController
{
    Contacts *contact;
}
@property (nonatomic, retain) Contacts *contact;
@property (weak, nonatomic) IBOutlet UILabel *mtfPhone;
@property (weak, nonatomic) IBOutlet UILabel *mtfWeibo;
@property (weak, nonatomic) IBOutlet UILabel *mtfDetail;
- (IBAction)smsAction:(id)sender;
- (IBAction)callAction:(id)sender;
@end
