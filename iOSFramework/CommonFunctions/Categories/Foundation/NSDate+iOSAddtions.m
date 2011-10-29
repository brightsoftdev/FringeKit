//
//  NSDate+iOSAddtions.m
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDate+iOSAddtions.h"

@implementation NSDate (iOSAddtions)

- (NSDate *) formatAsLongDateString{
    return nil;
}

- (NSString *) formatDateToUTCString:(NSString *) format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateString = [dateFormat stringFromDate:self];
    [dateFormat release];
    return dateString;
}

@end
