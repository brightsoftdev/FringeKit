//
//  ObjectMapping.m
//  iOSFramework
//
//  Created by macadmin on 21/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectMapping.h"
#import "NSString+iOSAddtions.h"

@implementation ObjectMapping

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)isNullCollection:(id)object {
    if ([object respondsToSelector:@selector(objectForKey:)]) {
        return NO;
    }
    
    if ([object respondsToSelector:@selector(countForObject:)] && [object count] > 0) {        
        if ([object countForObject:[NSNull null]] == [object count]) {
            NSLog(@"Found a collection containing only NSNull values...");
            return YES;
        }
    }
    
    return NO;
}

- (void) makeMappingRules{
}

- (void) dealloc{
    [super dealloc];
}

@end
