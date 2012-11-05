//
//  SetViewController.m
//  zutuanlu
//
//  Created by xeodou on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SetViewController.h"
#import "Base.h"
#import "GenHttpRequest.h"
#import "User.h"

@interface SetViewController ()
@property (nonatomic,retain) NSArray *array;
@end

@implementation SetViewController
@synthesize mTableView;
@synthesize array;

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
    self.array = [[NSArray alloc] initWithObjects:@"注销",@"重撸一发", nil];
    [mTableView setDelegate:self];
    [mTableView setDataSource:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        [self showAlertDialog];
    } else if(indexPath.row == 1) {
        [self sycContact];
    }
}

- (void)sycContact
{
    Base *base = [[Base alloc] init];
    User *user = [base getUser];
    if(user != nil && [base deleteAllContact]){
        GenHttpRequest *request = [[GenHttpRequest alloc] init];
        [request setDelegate:self];
        [request login:user.name pass:user.pass];
    }
}


- (void)showResultAlertDialog:(NSString*)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)loginState:(BOOL)state result:(NSString *)result
{
    if(!state){
        [self showResultAlertDialog:@"同步失败！请注销后重新登录!"];
    } else {
        GenHttpRequest *request = [[GenHttpRequest alloc] init];
        [request loadInfo];
        [self showResultAlertDialog:@"同步成功！"];
    }
}

- (void)showAlertDialog
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"哎呀" message:@"@_@ 客官请留步！！" delegate:self cancelButtonTitle:@"继续撸" otherButtonTitles:@"下次再撸", nil];
    [alertView show];
}

 - (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        [self logout];
    }
}

- (void) logout
{
    Base *base = [[Base alloc] init];
    if([base deleteUser] && [base deleteAllContact]){
        [self.navigationController popViewControllerAnimated:NO];
        [self.parentViewController performSegueWithIdentifier:@"Login" sender:self.parentViewController];
    }
}

- (void)viewDidUnload
{
    [self setMTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
