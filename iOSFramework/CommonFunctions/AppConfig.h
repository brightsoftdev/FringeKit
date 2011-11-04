//
//  AppConfig.h
//  iOSFramework
//
//  Created by macadmin on 16/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject{
    NSDictionary *applicationConfig;
    NSDictionary *interfaceConfig;
    NSDictionary *uiLayoutConfig;
    NSDictionary *alertMessageConfig;
    NSDictionary *tabBarConfig;
}

@property(nonatomic, assign) NSDictionary *applicationConfig;
@property(nonatomic, assign) NSDictionary *interfaceConfig;
@property(nonatomic, assign) NSDictionary *uiLayoutConfig;
@property(nonatomic, assign) NSDictionary *alertMessageConfig;
@property(nonatomic, assign) NSDictionary *tabBarConfig;

+ (AppConfig *) sharedInstance;

- (NSString *) getValueForKey: (NSString *) keyString withConfig: (NSString *) configName;

- (id) getObjectForKey: (NSString *) keyString;

@end
