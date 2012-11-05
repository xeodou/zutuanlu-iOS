//
//  Relation.h
//  zutuanlu
//
//  Created by xeodou on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Relation : NSObject{
    long long ll_uid;
    NSString *str_name;
    NSString *str_phone;
    NSString *str_weibo;
    NSString *str_detail;
}
@property long long ll_uid;
@property (strong) NSString *str_name;
@property (strong) NSString *str_phone;
@property (strong) NSString *str_weibo;
@property (strong) NSString *str_detail;
@end
