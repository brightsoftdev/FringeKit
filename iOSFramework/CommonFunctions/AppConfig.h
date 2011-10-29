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
}

@property(nonatomic, retain) NSDictionary *applicationConfig;
@property(nonatomic, retain) NSDictionary *interfaceConfig;
@property(nonatomic, retain) NSDictionary *uiLayoutConfig;
@property(nonatomic, retain) NSDictionary *alertMessageConfig;

+ (AppConfig *) sharedInstance;

- (NSString *) getValueForKey: (NSString *) keyString withConfig: (NSString *) configName;

@end
