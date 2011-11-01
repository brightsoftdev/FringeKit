//
//  NSDictionary+iOSAddtions.h
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (iOSAddtions)

- (NSDate *) convertToNSDate ;

@end

@interface NSMutableDictionary (iOSAddtions)

- (NSArray *) sortedKeysArray ;

@end
