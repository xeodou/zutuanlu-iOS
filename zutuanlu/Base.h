//
//  Base.h
//  zutuanlu
//
//  Created by xeodou on 12-10-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "User.h"
#import "Contacts.h"

@interface Base : NSObject
{
    FMDatabase *fmDataBase;
    sqlite3 *db;
}

- (void) createTables;
- (User*)getUser;
- (NSMutableArray*)getContacts;
- (BOOL) insertUser:(User*)user;
- (BOOL) deleteUser;
- (BOOL) updateUser:(User*)user;
- (BOOL) insertContact:(Contacts*)contact;
- (BOOL) deleteAllContact;
- (BOOL) deleteContact:(Contacts*)contact;
- (BOOL) updateContact:(Contacts*)contact;
- (BOOL) isLogin;
@end
