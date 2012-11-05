//
//  GenHttpRequest.m
//  zutuanlu
//
//  Created by xeodou on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GenHttpRequest.h"
#import "Contacts.h"
#import "ASIFormDataRequest.h"
#import "Base.h"
//#define login @"/login.do"
#define host @"http://ahpu.cnodejs.net"


@implementation GenHttpRequest
@synthesize delegate;


- (void) login:(NSString*)name pass:(NSString*)pass
{
//    [self loadInfo];
    NSString *csrf = [self getCSRF];
    if(!csrf) return;
    NSError *error;
    NSString *uri = [NSString stringWithFormat:@"%@%@",host, @"/login.do"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:uri]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setUseCookiePersistence:YES];
    
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:pass forKey:@"pass"];
    [request setPostValue:csrf forKey:@"_csrf"];
    [request startSynchronous];
    error = [request error];
    if(!error){
        NSString *respose = [[NSString alloc] initWithData:[request responseData] encoding:[request responseEncoding]];
        NSString *result = [self loginState:respose];
        if(result != nil){
            [delegate loginState:NO result:result];
        } else {
            Base *base = [[Base alloc] init];
            User *user = [[User alloc] init];
            [user setName:name];
            [user setPass:pass];
            [base insertUser:user];
            [delegate loginState:YES result:result];
        }
//        NSLog(@"%@",respose);
    }else {
        NSLog(@"%@", error);
        [delegate loginState:NO result:[NSString stringWithFormat:@"%@",error]];
    }
}

- (NSString*) loginState:(NSString*)string
{
    NSString *reg = @"<h1 style=\"font-weight:400;\">(.*)</h1>";
    NSString *result = [self regMatcher:string regex:reg rangeIndex:1];
    if(result.length > 0 && result)
        return result;
    return nil;
}

- (NSMutableArray*) loadInfo
{
    NSString *reg = @"<td>([\\s\\S\\r\\n\\.]*?)</td>";
//    [self getInfo:[self loadHome]];
    return [self regArrayMatcher:[self loadHome] regex:reg];
}

- (NSString*) loadHome
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:host]];
    [request setUseCookiePersistence:YES];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request startSynchronous];
    NSString *result = [[NSString alloc] initWithData:[request responseData] encoding:[request responseEncoding]];
    return result;
}

- (NSString*)getCSRF
{
    [ASIHTTPRequest setSessionCookies:nil];
    NSString *reg = @"<input type=\"hidden\" name=\"_csrf\" value=\"(.+)\" />";

    NSString *result = [self regMatcher:[self loadHome] regex:reg rangeIndex:1];
    if(!result) return nil;
    return result;
//    NSArray *array = [regex matchesInString:result options:0 range:NSMakeRange(0, [result length])];
//    for(NSTextCheckingResult *match in array){
//        NSLog(@"%@",match);
//        NSRange firstMatch = [match rangeAtIndex:0];
//        NSString *matcher = [result substringWithRange:firstMatch];
//        NSLog(@"%@",matcher);
//    }
}

- (NSString*)regMatcher:(NSString*)string regex:(NSString*)reg rangeIndex:(NSInteger)index
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:reg options:0 error:&error];
    if(error){
        NSLog(@"%@", error);
        return nil;
    }
    NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    NSString *matcher = [string substringWithRange:[match rangeAtIndex:index]];
    return matcher;
}

- (NSMutableArray*)regArrayMatcher:(NSString*)string regex:(NSString*)reg
{
    NSError *error;
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:reg options:0 error:&error];
    if(error){
        NSLog(@"%@", error);
        return nil;
    }
//    NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
//    NSString *matcher = [string substringWithRange:[match rangeAtIndex:1]];
//    return matcher;
    NSArray *array = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    Base *base = [[Base alloc] init];
    for (int i = 0; i < [array count]; i += 5) {
        Contacts *contact = [[Contacts alloc] init];
        NSString *matcher = [string substringWithRange:[[array objectAtIndex:i] rangeAtIndex:1]];
        contact.uid = matcher;
        matcher = [string substringWithRange:[[array objectAtIndex:i + 1] rangeAtIndex:1]];
        contact.name = matcher;
        matcher = [string substringWithRange:[[array objectAtIndex:i + 2] rangeAtIndex:1 ]];
        matcher = [matcher stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        matcher = [matcher stringByReplacingOccurrencesOfString:@" " withString:@""];
        matcher = [self regMatcher:matcher regex:@"(^[0-9]*)" rangeIndex:0];
        contact.phone = matcher;
//        NSLog(@"%@",matcher);
        matcher = [string substringWithRange:[[array objectAtIndex:i + 3] rangeAtIndex:1]];
        matcher = [self regMatcher:matcher regex:@"<[aA]\\s*(href=[^>]+)>(.*?)</[aA]>" rangeIndex:2];
        contact.weibo = matcher;
        matcher = [string substringWithRange:[[array objectAtIndex:i + 4] rangeAtIndex:1]];
        contact.detail = matcher;
        [base insertContact:contact];
        [result addObject:contact];
    }
    return result;
}

@end
