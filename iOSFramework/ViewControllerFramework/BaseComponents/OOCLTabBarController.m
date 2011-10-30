//
//  OOCLTabBarController.m
//  iOSFramework
//
//  Created by macadmin on 16/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OOCLTabBarController.h"
#import "OOCLTabBarItem.h"
#import "OOCLNavigationController.h"
#import "AppConfig.h"

@implementation OOCLTabBarController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) buildUITabBarController{
    
    NSDictionary *tabBarDictionary = [[AppConfig sharedInstance] tabBarConfig];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    [tabBarDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //NSLog(@"key: %@", key);
        NSDictionary *indexDictionary = obj;
        NSString *viewControllerClassName = [indexDictionary objectForKey:@"DefaultViewController"];
        //NSLog(@"viewControllerClassName: %@", viewControllerClassName);
        Class viewControllerClass = NSClassFromString(viewControllerClassName);
        UIViewController *indexViewController = [[viewControllerClass alloc] initWithNibName:viewControllerClassName bundle:nil];
                
        indexViewController.title = [indexDictionary objectForKey:@"ViewTitle"];
        UIImage *indexTabImage = [UIImage imageNamed:[indexDictionary objectForKey:@"ImageName"]];
        //NSLog(@"indexTabImage: %@", indexTabImage);

        OOCLTabBarItem *indexItem = [[OOCLTabBarItem alloc] init];
        indexItem.title = [indexDictionary objectForKey:@"BarTitle"];
        //NSLog(@"Title: %@", indexItem.title);
        indexItem.image = indexTabImage;
        indexItem.tag = 0;  
        indexViewController.tabBarItem = indexItem;
        [indexItem release];
        
        OOCLNavigationController *indexNavigationController = [[OOCLNavigationController alloc] initWithRootViewController: indexViewController];
        [controllers addObject:indexNavigationController];
        [indexViewController release];
        [indexNavigationController release];

    }];
    
    [self setViewControllers:controllers];
}

@end
