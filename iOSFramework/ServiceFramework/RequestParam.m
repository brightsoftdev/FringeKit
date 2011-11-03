//
//  RequestParam.m
//  iOSFramework
//
//  Created by macadmin on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#define DefaultTimeOut 60
#define DEFAULT_POST_KEY @"params"

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
@synthesize postConditionKeyName = _postConditionKeyName;

- (id)init
{
    self = [super init];
    if (self) {
        _userID = [[AppConfig sharedInstance] getValueForKey:@"ServiceRequestUserName" withConfig:@"AppConfig"];
        _password = [[AppConfig sharedInstance] getValueForKey:@"ServiceRequestPassword" withConfig:@"AppConfig"];
        if (!_requestMethod) {
            _requestMethod = @"POST";
        }
        _postConditionKeyName = DEFAULT_POST_KEY;
        if (!_requestUrl) {
            _requestUrl = [[NSMutableString alloc] initWithString:@""];
        }
        if (!_requestUrlParams) {
            _requestUrlParams = [NSMutableDictionary new];
        }
        
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
    //[_requestUrl release];
    [_requestUrlParams release];
    [super dealloc];
}

@end


