//
//  DetailViewController.m
//  zutuanlu
//
//  Created by xeodou on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize contact;
@synthesize mtfPhone;
@synthesize mtfWeibo;
@synthesize mtfDetail;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = contact.name;
    self.mtfPhone.text = contact.phone;
    self.mtfWeibo.text = contact.weibo;
    self.mtfDetail.text = contact.detail;
}

- (void)viewDidUnload
{
    [self setMtfPhone:nil];
    [self setMtfWeibo:nil];
    [self setMtfDetail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)smsAction:(id)sender {
    NSString *prefix = ([NSString stringWithFormat:@"sms://%@",contact.phone]);
    UIApplication *app = [UIApplication sharedApplication];
    NSString *dialThis = [NSString stringWithFormat:@"%@", prefix];
    NSURL *url = [NSURL URLWithString:dialThis];
    [app openURL:url]; 
}

- (IBAction)callAction:(id)sender {
    NSString *prefix = ([NSString stringWithFormat:@"tel://%@",contact.phone]);
    UIApplication *app = [UIApplication sharedApplication];
    NSString *dialThis = [NSString stringWithFormat:@"%@", prefix];
    NSURL *url = [NSURL URLWithString:dialThis];
    [app openURL:url];
}
@end
