//
//  NSDate+iOSAddtions.h
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (iOSAddtions)

- (NSDate *) formatAsLongDateString;

- (NSString *) formatDateToUTCString:(NSString *) format;

@end
