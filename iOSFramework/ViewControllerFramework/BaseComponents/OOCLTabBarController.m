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

@synthesize disableString = _disableString;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_disableString) {
        NSLog(@"disable String: %@", _disableString);
        [self setSelectedIndex: [_disableString firstIndexForString:@"1"]];
    }
}

- (void) buildUITabBarController{
    
    NSDictionary *tabBarDictionary = [[AppConfig sharedInstance] tabBarConfig];
    NSMutableDictionary *controllersDic = [[NSMutableDictionary alloc] initWithCapacity:[tabBarDictionary count]];
    NSMutableArray *controllersArray = [[NSMutableArray alloc] initWithCapacity:[tabBarDictionary count]];
    if (!_disableString) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setPaddingCharacter:@"1"];
        [numberFormatter setFormatWidth:[tabBarDictionary count]];
        _disableString = [[numberFormatter stringFromNumber:[NSNumber numberWithInt:1]] retain];
        [numberFormatter release];
    }

    [tabBarDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSDictionary *indexDictionary = obj;
        //the order should be start at 0 in config file
        int order = [[indexDictionary valueForKey:@"Order"] intValue];
        unichar hiddenChar = [_disableString characterAtIndex:order];
        
        NSString *viewControllerClassName = [indexDictionary objectForKey:@"DefaultViewController"];
        Class viewControllerClass = NSClassFromString(viewControllerClassName);
        UIViewController *indexViewController = [[viewControllerClass alloc] initWithNibName:viewControllerClassName bundle:nil];
                
        indexViewController.title = [indexDictionary objectForKey:@"ViewTitle"];
        UIImage *indexTabImage = [UIImage imageNamed:[indexDictionary objectForKey:@"ImageName"]];

        OOCLTabBarItem *indexItem = [[OOCLTabBarItem alloc] init];
        indexItem.title = [indexDictionary objectForKey:@"BarTitle"];
        indexItem.image = indexTabImage;
        indexItem.tag = order;
        indexViewController.tabBarItem = indexItem;
        if (hiddenChar == '0') {
            indexItem.enabled = NO;
        }
        [indexItem release];
        
        OOCLNavigationController *indexNavigationController = [[OOCLNavigationController alloc] initWithRootViewController: indexViewController];
        [controllersDic setValue:indexNavigationController forKey:[NSString stringWithFormat:@"%d", order]];
        [indexViewController release];
        [indexNavigationController release];
    }];

    for (NSString* key in [controllersDic sortedKeysArray]){
        [controllersArray addObject:[controllersDic objectForKey:key]];
    }

    [self setViewControllers:controllersArray];
    [controllersDic release];
    [controllersArray release];
}

- (void) dealloc{
    //[_disableString release];
    [super dealloc];
}

@end
