//
//  NSString+iOSAddtions.h
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (iOSAddtions)

- (BOOL) isNilOrEmpty;
- (BOOL) isValidEmailAddress;
- (BOOL) isValidPhoneNumber;
- (NSString *) reverseString;
- (NSString *) trim;
- (NSString *) firstUpcaseString;
- (NSArray *) split: (NSString *) separatedByString;
- (NSDate *) covertToDate;
- (NSString *) paddingLeftToLength: (NSInteger) newLength withString:(NSString *) padString startingAtIndex:(NSUInteger) padIndex;

@end

@interface NSMutableString (iOSAddtions)

- (BOOL) isNilOrEmpty;

@end

