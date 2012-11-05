//
//  Base.m
//  zutuanlu
//
//  Created by xeodou on 12-10-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Base.h"

@implementation Base

- (id) init
{
    self = [super init];
    if(self != nil){
        fmDataBase = [[FMDatabase alloc] initWithPath:[self getDataBasePath]];
    }
    return self;
}

- (NSString*) getDataBasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"zutuanlu.db"];
    return dbPath;
}

- (void)createTables
{
    fmDataBase = [FMDatabase databaseWithPath:[self getDataBasePath]];
    if(![fmDataBase open]){
        NSLog(@"db not open");
        return ;
    }
    NSString *strUserTable = @"CREATE TABLE IF NOT EXISTS User(name text,pass text)";
    NSString *strContactTable = @"CREATE TABLE IF NOT EXISTS Contact (id text,name text,phone text,weibo text,detail text)";
    [fmDataBase executeUpdate:strUserTable];
    [fmDataBase executeUpdate:strContactTable];
    [fmDataBase close];
}

- (User*)getUser
{
//    fmDataBase = [[FMDatabase alloc] initWithPath:[self getDataBasePath]];
    if(![fmDataBase open])
        return nil;
    NSString *sql = @"select * from User";
    User *user = [[User alloc] init];
    FMResultSet *res = [fmDataBase executeQuery:sql];
//    if([res columnIndexIsNull:0]){
//        return nil;
//    }
    if([res next]) {
        user.name = [res stringForColumn:@"name"];
        user.pass = [res stringForColumn:@"pass"];
        [res close];
        [fmDataBase close];
        return user;
    }
    [res close];
    [fmDataBase close];
    return nil;
}

- (BOOL)insertUser:(User *)user
{
//    fmDataBase = [[FMDatabase alloc] initWithPath:[self getDataBasePath]];
//    [fmDataBase beginTransaction];
    if(![fmDataBase open])
        return NO;
    NSString *sql = @"insert into User (name, pass) values (?,?)";
    return  [fmDataBase executeUpdate:sql,user.name, user.pass];;
}

- (BOOL)updateUser:(User *)user
{
    NSString *sql = @"update User set pass = ? where name = ?";
    return [fmDataBase executeUpdate:sql, user.pass, user.name];
}

- (BOOL)deleteUser
{
    if(![fmDataBase open])
        return NO;
    NSString *sql = @"delete from User Where name != 0";
    return [fmDataBase executeUpdate:sql];
}

- (NSMutableArray*)getContacts
{
    if(![fmDataBase open])
        return nil;
    NSString *sql = @"select * from Contact";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    FMResultSet *res = [fmDataBase executeQuery:sql];
    while ([res next]) {
        Contacts *contact = [[Contacts alloc] init];
        contact.uid = [res stringForColumn:@"id"];
        contact.name = [res stringForColumn:@"name"];
        contact.phone = [res stringForColumn:@"phone"];
        contact.weibo = [res stringForColumn:@"weibo"];
        contact.detail = [res stringForColumn:@"detail"];
        [array addObject:contact];
    }
    [res close];
    [fmDataBase close];
    return array;
}

- (BOOL)insertContact:(Contacts *)contact
{
    if(![fmDataBase open]){
        return NO;
    }
    NSString *sql = @"insert into Contact (id, name, phone, weibo, detail) values (?,?,?,?,?)";
    return [fmDataBase executeUpdate:sql,contact.uid,contact.name, contact.phone, contact.weibo, contact.detail];
}

- (BOOL)updateContact:(Contacts *)contact
{
    if(![fmDataBase open])
        return NO;
    NSString *sql = @"update Contact set name = ? , phone = ?, weibo = ? , detail = ? where id = ?";
    return [fmDataBase executeUpdate:sql, contact.name, contact.phone, contact.weibo, contact.detail, contact.uid];
}

- (BOOL)deleteAllContact
{
    if(![fmDataBase open])
        return NO;
    NSString *sql = @"delete from Contact where id != 0";
    return [fmDataBase executeUpdate:sql];
}

- (BOOL)deleteContact:(Contacts *)contact
{
    if(![fmDataBase open])
        return NO;
    NSString *sql = @"delete from Contact where id = ?";
    return [fmDataBase executeUpdate:sql, contact.uid];
}

- (void)dealloc
{
    [fmDataBase close];
}

- (BOOL)isLogin
{
    if([self getUser] != nil)
        return YES;
    else 
        return NO;
}

@end
