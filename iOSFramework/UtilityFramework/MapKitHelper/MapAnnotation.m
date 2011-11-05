//
//  MapAnnotation.m
//  iOSFramework
//
//  Created by macadmin on 4/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate = _coordinate;  
@synthesize title = _title;  
@synthesize subtitle = _subtitle;  

- (id) initWithCoordinate:(CLLocationCoordinate2D) temp_coordinate  
{  
    if ([super init]){  
        coordinate = temp_coordinate;  
    }    
    return self;
}

- (void) dealloc{
    [_title release];
    [_subtitle release];
    [super dealloc];  
}

@end
