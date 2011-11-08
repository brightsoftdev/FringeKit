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
@synthesize tag = _tag;  
@synthesize title = _title;  
@synthesize subtitle = _subtitle;
@synthesize annotationType = _annotationType;

- (id) initWithCoordinate:(CLLocationCoordinate2D) temp_coordinate  
{  
    if ([super init]){  
        coordinate = temp_coordinate;  
    }    
    return self;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c withTag:(NSUInteger)t withTitle:(NSString *)tl withSubtitle:	(NSString *)s	
{
	if(self = [super init]){
		_coordinate = c;
		_tag = t;
		_title = tl;
		_subtitle = s;
	}
	return self;
}

- (id) initWithCoordinateAndType:(CLLocationCoordinate2D)c withTag:(NSUInteger)t withTitle:(NSString *)tl withSubtitle:	(NSString *)s annotationType:(UICRouteAnnotationType)type{
    if(self = [super init]){
		_coordinate = c;
		_tag = t;
		_title = tl;
		_subtitle = s;
        _annotationType = type;
	}
	return self;
}

- (void) dealloc{
    [_title release];
    [_subtitle release];
    [super dealloc];  
}

@end
