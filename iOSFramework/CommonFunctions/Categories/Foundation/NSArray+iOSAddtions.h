//
//  NSArray+iOSAddtions.h
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (iOSAddtions)

- (NSArray *) groupArrayByField: (NSString *) groupString;

@end

@interface NSMutableArray (iOSAddtions)

- (NSArray *) sortByField: (NSString *) sortFieldString;

@end