//
//  UIColor+iOSAddtions.h
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (iOSAddtions)

// Create a new UIColor instance using the following long value (see
// UIColor#colorWithHex for an example) and desired alpha value.
// 1.0 for opaque, 0.0 for transparent.
// Example: Light gray color of EFEFEF [UIColor colorWithHex:0xefefef alpha:1.0]
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
