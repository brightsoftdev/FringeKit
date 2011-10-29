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
    NSMutableString *requestUrl;
    NSString *requestUrlKeyNameInConfig;
    NSMutableDictionary *requestUrlParams;
    NSMutableDictionary *requestHeader;
    int timeOutValue;
}

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *requestMethod;
@property (nonatomic, retain) NSMutableString *requestUrl;
@property (nonatomic, copy) NSString *requestUrlKeyNameInConfig;
@property (nonatomic, retain) NSMutableDictionary *requestUrlParams;
@property (nonatomic, retain) NSMutableDictionary *requestHeader;
@property (nonatomic, assign) int timeOutValue;


@end
