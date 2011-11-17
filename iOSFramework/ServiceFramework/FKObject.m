//
//  FKObject.m
//  iOSFramework
//
//  Created by  on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FKObject.h"

@implementation FKObject

@synthesize responseHeader = _responseHeader;
@synthesize responseValue = _responseValue;

- (id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) dealloc{
    [_responseHeader release];
    [_responseValue release];
    [super dealloc];
}

@end
