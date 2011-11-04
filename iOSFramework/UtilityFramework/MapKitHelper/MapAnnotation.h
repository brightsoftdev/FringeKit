//
//  MapAnnotation.h
//  iOSFramework
//
//  Created by macadmin on 4/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface MapAnnotation : NSObject<MKAnnotation>{  
    CLLocationCoordinate2D  coordinate;  
    NSString   *title;  
    NSString  *subtitle;
}  
@property (nonatomic, readonly) CLLocationCoordinate2D  coordinate;  
@property (nonatomic, copy) NSString *title;  
@property (nonatomic, copy) NSString *subtitle;

@end 
