//
//  UserDefaultHelper.h
//  iOSFramework
//
//  Created by  on 11/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultHelper : NSObject{
    
}

+ (void) SaveObjectToUserDefault: (id) value forKey: (NSString *) keyString;

+ (id) GetValueFromUserDefaultByKey: (NSString *) keyString;

@end
