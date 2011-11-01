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
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithCapacity:[tabBarDictionary count]];
    if (!_disableString) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setPaddingCharacter:@"1"];
        [numberFormatter setFormatWidth:[tabBarDictionary count]];
        _disableString = [[numberFormatter stringFromNumber:[NSNumber numberWithInt:1]] retain];
        [numberFormatter release];
    }

    __block int index = [tabBarDictionary count] - 1;
    [tabBarDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        unichar hiddenChar = [_disableString characterAtIndex:index];
        
        NSDictionary *indexDictionary = obj;
        NSString *viewControllerClassName = [indexDictionary objectForKey:@"DefaultViewController"];
        Class viewControllerClass = NSClassFromString(viewControllerClassName);
        UIViewController *indexViewController = [[viewControllerClass alloc] initWithNibName:viewControllerClassName bundle:nil];
                
        indexViewController.title = [indexDictionary objectForKey:@"ViewTitle"];
        UIImage *indexTabImage = [UIImage imageNamed:[indexDictionary objectForKey:@"ImageName"]];

        OOCLTabBarItem *indexItem = [[OOCLTabBarItem alloc] init];
        indexItem.title = [indexDictionary objectForKey:@"BarTitle"];
        indexItem.image = indexTabImage;
        indexItem.tag = index;
        indexViewController.tabBarItem = indexItem;
        if (hiddenChar == '0') {
            indexItem.enabled = NO;
        }
        [indexItem release];
        
        OOCLNavigationController *indexNavigationController = [[OOCLNavigationController alloc] initWithRootViewController: indexViewController];
        [controllers insertObject:indexNavigationController atIndex:0];
        [indexViewController release];
        [indexNavigationController release];
        index-- ;        
    }];
    
    //[self setSelectedIndex: [_hiddenString firstIndexForString:@"1"]];
    [self setViewControllers:controllers];
    [controllers release];
}

- (void) dealloc{
    //[_disableString release];
    [super dealloc];
}

@end
