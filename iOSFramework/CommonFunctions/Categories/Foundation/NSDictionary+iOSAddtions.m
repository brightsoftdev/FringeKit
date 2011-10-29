//
//  NSDictionary+iOSAddtions.m
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+iOSAddtions.h"
#import "NSString+iOSAddtions.h"

@implementation NSDictionary (iOSAddtions)

- (NSDate *) convertToNSDate {
	NSString * cldYear = [[self objectForKey:@"year"] description];
	NSString * cldMonth;
	if ([[self objectForKey:@"month"] intValue] < 10) {
		cldMonth = [NSString stringWithFormat:@"0%d", [[self objectForKey:@"month"] intValue]];
	} else {
		cldMonth = [[self objectForKey:@"month"] description];
	}
	NSString * cldDay;
	if ([[self objectForKey:@"dayOfMonth"] intValue] < 10) {
		cldDay = [NSString stringWithFormat:@"0%d", [[self objectForKey:@"dayOfMonth"] intValue]];
	} else {
		cldDay =  [[self objectForKey:@"dayOfMonth"] description];
	}
	NSString * cldHour;
	if ([[self objectForKey:@"hourOfDay"] intValue] < 10) {
		cldHour = [NSString stringWithFormat:@"0%d", [[self objectForKey:@"hourOfDay"] intValue]];
	} else {
		cldHour =  [[self objectForKey:@"hourOfDay"] description];
	}
	NSString * cldMinute;
	if ([[self objectForKey:@"minute"] intValue] < 10) {
		cldMinute = [NSString stringWithFormat:@"0%d", [[self objectForKey:@"minute"] intValue]];
	} else {
		cldMinute =  [[self objectForKey:@"minute"] description];
	}
	NSString * cldSecond;
	if ([[self objectForKey:@"second"] intValue] < 10) {
		cldSecond = [NSString stringWithFormat:@"0%d", [[self objectForKey:@"second"] intValue]];
	} else {
		cldSecond =  [[self objectForKey:@"second"] description];
	}
	NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@", cldYear, cldMonth, cldDay, cldHour, cldMinute, cldSecond]; 
    
	NSDate * result= [dateStr covertToDate];
    
	return result;
}
@end
