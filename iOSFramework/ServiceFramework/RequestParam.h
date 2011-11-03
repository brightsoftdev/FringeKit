//
//  RequestParam.h
//  iOSFramework
//
//  Created by macadmin on 10/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestParam : NSObject{
    NSString *userID;
    NSString *password;
    NSString *requestMethod;
    NSString *postConditionKeyName;
    NSMutableString *requestUrl;
    NSString *requestUrlKeyNameInConfig;
    NSMutableDictionary *requestUrlParams;
    NSMutableDictionary *requestHeader;
    int timeOutValue;
}

@property (nonatomic, assign) NSString *userID;
@property (nonatomic, assign) NSString *password;
@property (nonatomic, assign) NSString *requestMethod;
@property (nonatomic, assign) NSString *postConditionKeyName;
@property (nonatomic, assign) NSMutableString *requestUrl;
@property (nonatomic, assign) NSString *requestUrlKeyNameInConfig;
@property (nonatomic, assign) NSMutableDictionary *requestUrlParams;
@property (nonatomic, assign) NSMutableDictionary *requestHeader;
@property (nonatomic, assign) int timeOutValue;


@end
