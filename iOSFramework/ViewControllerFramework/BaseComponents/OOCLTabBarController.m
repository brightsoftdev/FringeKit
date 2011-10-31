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
#import "Category.h"

@implementation OOCLTabBarController

@synthesize hiddenString = _hiddenString;

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
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithCapacity:[tabBarDictionary count]];
    if (!_hiddenString) {
        _hiddenString = @"1";
        _hiddenString = [_hiddenString paddingLeftToLength:[tabBarDictionary count] withString:@"1" startingAtIndex:0];
        NSLog(@"hidden String: %@", _hiddenString);
    }

    __block int index = [tabBarDictionary count] - 1;
    [tabBarDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        unichar hiddenChar = [_hiddenString characterAtIndex:index];
        
        NSDictionary *indexDictionary = obj;
        NSString *viewControllerClassName = [indexDictionary objectForKey:@"DefaultViewController"];
        Class viewControllerClass = NSClassFromString(viewControllerClassName);
        UIViewController *indexViewController = [[viewControllerClass alloc] initWithNibName:viewControllerClassName bundle:nil];
                
        indexViewController.title = [indexDictionary objectForKey:@"ViewTitle"];
        UIImage *indexTabImage = [UIImage imageNamed:[indexDictionary objectForKey:@"ImageName"]];

        OOCLTabBarItem *indexItem = [[OOCLTabBarItem alloc] init];
        indexItem.title = [indexDictionary objectForKey:@"BarTitle"];
        indexItem.image = indexTabImage;
        indexItem.tag = 0;  
        indexViewController.tabBarItem = indexItem;
        [indexItem release];
        
        OOCLNavigationController *indexNavigationController = [[OOCLNavigationController alloc] initWithRootViewController: indexViewController];
        if (hiddenChar == '1') {
            [controllers insertObject:indexNavigationController atIndex:0];
        }
        [indexViewController release];
        [indexNavigationController release];
        index-- ;        
    }];
    
    [self setViewControllers:controllers];
    [controllers release];
}

- (void) dealloc{
    [super dealloc];
}

@end
