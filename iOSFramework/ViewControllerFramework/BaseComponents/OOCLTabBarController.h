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
    //disable string sample: @"1101"
    NSString *disableString;
}

@property (nonatomic, assign) NSString *disableString;

- (void) buildUITabBarController;

//-(void)activateController:(int)index;
//-(void)activateTabItem:(int)index;

@end
