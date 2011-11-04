//
//  AppConfig.m
//  iOSFramework
//
//  Created by macadmin on 16/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

static AppConfig *sharedInstance;

@synthesize applicationConfig = _applicationConfig;
@synthesize interfaceConfig = _interfaceConfig;
@synthesize uiLayoutConfig = _uiLayoutConfig;
@synthesize alertMessageConfig = _alertMessageConfig;
@synthesize tabBarConfig = _tabBarConfig;

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (AppConfig *)initConfig{
	self = [super init];
    if (self) {
        _applicationConfig = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppConfig"];
        _interfaceConfig =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"InterfaceConfig"];
        _uiLayoutConfig =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UILayerConfig"];
        _alertMessageConfig =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AlertMessageConfig"];
        _tabBarConfig =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"TabBarConfig"];
    }
	return self;
}

- (id) getObjectForKey: (NSString *) keyString{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:keyString];
}

- (NSString *) getValueForKey: (NSString *) keyString withConfig: (NSString *) configName{
    if ([configName isEqualToString:@"AppConfig"]) {
        return [_applicationConfig objectForKey:keyString];
    }
    if ([configName isEqualToString:@"InterfaceConfig"]) {
        return [_interfaceConfig objectForKey:keyString];
    }
    if ([configName isEqualToString:@"UILayerConfig"]) {
        return [_uiLayoutConfig objectForKey:keyString];
    }
    if ([configName isEqualToString:@"AlertMessageConfig"]) {
        return [_alertMessageConfig objectForKey:keyString];
    }
    if ([configName isEqualToString:@"TabBarConfig"]) {
        return [_tabBarConfig objectForKey:keyString];
    }
    return @"";
}

+ (AppConfig *)sharedInstance{
    @synchronized(self){
        if (sharedInstance == nil)
			sharedInstance = [[AppConfig alloc] initConfig];
    }
    return sharedInstance;
}

- (void) dealloc{
    [super dealloc];
}

@end
