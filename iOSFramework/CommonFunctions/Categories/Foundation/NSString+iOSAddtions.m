//
//  NSString+iOSAddtions.m
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#define DEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm:ss")

#import "NSString+iOSAddtions.h"

@implementation NSString (iOSAddtions)

- (BOOL) isNilOrEmpty{
    if (!self) {
        return YES;
    }
    if (self.length == 0 || [self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (BOOL) isValidEmailAddress{
    NSString *regex = @"^[\\w-]+(\\.[\\w-]+)*@([\\w-]+\\.)+[\\w]{2,6}$";
	NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	return [regextest evaluateWithObject:self];
}

- (BOOL) isValidPhoneNumber{
    return YES;
}

- (NSString *) trim{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (NSString *) reverseString{
    NSMutableString *reverseStr;
    int len = [self length];
    reverseStr = [NSMutableString stringWithCapacity:len];
    while (len > 0) {
        [reverseStr appendString:[NSString stringWithFormat:@"%C", [self characterAtIndex:--len]]];
    }
    return reverseStr;
}

- (NSString *) firstUpcaseString{
    NSString *first = [[self capitalizedString]substringToIndex:1];
	NSString *result = [[[NSString alloc]initWithFormat:@"%@%@",first,[self substringFromIndex:1]]autorelease];
	return result;
}

- (NSArray *) split: (NSString *) separatedByString{
    return [self componentsSeparatedByString:separatedByString];
}

- (NSDate *) covertToDate{  
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:DEFAULT_DATE_TIME_FORMAT];
    NSDate *date = [formatter dateFromString:self];
    [formatter release];
    return date;
}

- (NSString *) paddingLeftToLength: (NSInteger) newLength withString:(NSString *) padString startingAtIndex:(NSUInteger) padIndex{
    if ([self length] <= newLength) {
        return [[@"" stringByPaddingToLength:newLength - [self length] withString:padString startingAtIndex:padIndex] stringByAppendingString:self];
    }
    else{
        return self;
    }
}

@end

@implementation NSMutableString (iOSAddtions)

- (BOOL) isNilOrEmpty{
    if (!self) {
        return YES;
    }
    if (self.length == 0 || [self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

@end
