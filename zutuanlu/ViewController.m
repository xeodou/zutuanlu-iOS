//
//  ViewController.m
//  zutuanlu
//
//  Created by xeodou on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ContactsViewController.h"

@implementation ViewController
@synthesize nameTF;
@synthesize passTF;
@synthesize loginBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initData];
}

- (void)initData
{
    [self setTextFieldPlaceHolderColor];
    [nameTF setDelegate:self];
    [passTF setDelegate:self];
    [nameTF becomeFirstResponder];
}

- (void) setTextFieldPlaceHolderColor
{
    NSString *keyPath = @"_placeholderLabel.textColor";
    [self.nameTF setValue:[UIColor whiteColor] forKeyPath:keyPath];
    [self.passTF setValue:[UIColor whiteColor] forKeyPath:keyPath];
}

- (void)viewDidUnload
{
    [self setNameTF:nil];
    [self setPassTF:nil];
    [self setLoginBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([passTF isFirstResponder]) {
        [passTF resignFirstResponder];
    }
    if([nameTF isFirstResponder]){
        [passTF becomeFirstResponder];
    }
    return YES;
}

- (BOOL) checkTextField
{
    if([[nameTF text] length] <= 0 || [[passTF text] length] <= 0)
        return false;
    return true;
}

- (IBAction)login:(id)sender {
    if(![self checkTextField]){
        
    }
    GenHttpRequest *request = [[GenHttpRequest alloc] init];
    [request setDelegate:self];
    [request login:[nameTF text] pass:[passTF text]];
}

- (void)loginState:(BOOL)state result:(NSString *)result
{
    if(!state){
        return;
    }
    GenHttpRequest *request = [[GenHttpRequest alloc] init];
    [request loadInfo];
    [self dismissModalViewControllerAnimated:YES];
}
@end
