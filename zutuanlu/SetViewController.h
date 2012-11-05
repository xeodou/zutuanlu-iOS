//
//  SetViewController.h
//  zutuanlu
//
//  Created by xeodou on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenHttpRequest.h"
@interface SetViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, ZuTuanLuDelagte>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
