//
//  GenHttpRequest.h
//  zutuanlu
//
//  Created by xeodou on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
@protocol ZuTuanLuDelagte <NSObject>

- (void)loginState:(BOOL)state result:(NSString*)result;
- (void)getContacts:(NSMutableArray*)contacts;

@end
#import <Foundation/Foundation.h>

@interface GenHttpRequest : NSObject
{
    id<ZuTuanLuDelagte> delegate;
}
@property (nonatomic, retain) id<ZuTuanLuDelagte> delegate;
- (void) login:(NSString*)name pass:(NSString*)pass;
- (NSMutableArray*)loadInfo;
@end
