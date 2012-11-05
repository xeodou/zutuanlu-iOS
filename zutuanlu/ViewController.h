//
//  ViewController.h
//  zutuanlu
//
//  Created by xeodou on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenHttpRequest.h"
@interface ViewController : UIViewController <UITextFieldDelegate, ZuTuanLuDelagte>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)login:(id)sender;
@end
