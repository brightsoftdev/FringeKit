//
//  OOCLTabBarController.h
//  iOSFramework
//
//  Created by macadmin on 16/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OOCLTabBarController : UITabBarController{
    NSString *hiddenString;
}

@property (nonatomic, assign) NSString *hiddenString;

- (void) buildUITabBarController;

@end
