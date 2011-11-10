//
//  UserDefaultHelper.m
//  iOSFramework
//
//  Created by  on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UserDefaultHelper.h"

@implementation UserDefaultHelper

+ (void) SaveObjectToUserDefault: (id) value forKey: (NSString *) keyString{
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    [usrDefault setValue:value forKey:keyString];
    [usrDefault synchronize];
}

+ (void) SaveCustomObjectToUserDefault: (id) customValue forKey: (NSString *) keyString{
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:customValue];
    [usrDefault setValue:data forKey:keyString];
    [usrDefault synchronize];
}

+ (id) GetValueFromUserDefaultByKey: (NSString *) keyString{
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    return [usrDefault objectForKey:keyString];
}

+ (id) GetCustomObjectFromUserDefaultByKey: (NSString *) keyString{
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [usrDefault objectForKey:keyString];
    id object=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}

@end
