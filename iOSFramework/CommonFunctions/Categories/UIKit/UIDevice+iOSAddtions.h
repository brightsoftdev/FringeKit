//
//  UIDevice+iOSAddtions.h
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (iOSAddtions)

- (BOOL)isSimulator;

/**
 Returns `YES` if the device is an iPod touch, iPhone, iPhone 3G, or an iPhone 3GS.
 
 @return `YES` if the device is crappy and `NO` if it is not.
 */
- (BOOL)isCrappy;

@end
