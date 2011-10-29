//
//  RequestParam.m
//  iOSFramework
//
//  Created by macadmin on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#define DefaultTimeOut 60

#import "RequestParam.h"
#import "AppConfig.h"

@implementation RequestParam

@synthesize userID = _userID;
@synthesize password = _password;
@synthesize requestMethod = _requestMethod;
@synthesize requestUrl = _requestUrl;
@synthesize requestUrlParams = _requestUrlParams;
@synthesize timeOutValue = _timeOutValue;
@synthesize requestUrlKeyNameInConfig = _requestUrlKeyNameInConfig;
@synthesize requestHeader = _requestHeader;

- (id)init
{
    self = [super init];
    if (self) {
        _userID = [[AppConfig sharedInstance] getValueForKey:@"ServiceRequestUserName" withConfig:@"AppConfig"];
        _password = [[AppConfig sharedInstance] getValueForKey:@"ServiceRequestPassword" withConfig:@"AppConfig"];
        _requestMethod = @"POST";
        _requestUrl = [[NSMutableString alloc] initWithString:@""];
        _requestUrlParams = [NSMutableDictionary new];
        _requestUrlKeyNameInConfig = @"";
        if ([[AppConfig sharedInstance] getValueForKey:@"ServiceTimeOut" withConfig:@"AppConfig"] == nil) {
            _timeOutValue = DefaultTimeOut;
        }
        else{
            _timeOutValue = [[[AppConfig sharedInstance] getValueForKey:@"ServiceTimeOut" withConfig:@"AppConfig"] intValue];
        }
    }
    return self;
}

- (void) dealloc{
    [_requestUrl release];
    [_requestUrlParams release];
    [super dealloc];
}

@end


