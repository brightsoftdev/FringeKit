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

typedef enum UICRouteAnnotationType {
	UICRouteAnnotationTypeStart,
	UICRouteAnnotationTypeEnd,
	UICRouteAnnotationTypeWayPoint,
} UICRouteAnnotationType;

@interface MapAnnotation : NSObject<MKAnnotation>{  
    CLLocationCoordinate2D  coordinate;
    NSUInteger tag;
    NSString   *title;  
    NSString  *subtitle;
    UICRouteAnnotationType annotationType;
}  
@property (nonatomic, readonly) CLLocationCoordinate2D  coordinate;
@property (nonatomic) NSUInteger tag;
@property (nonatomic, copy) NSString *title;  
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) UICRouteAnnotationType annotationType;

- (id) initWithCoordinate:(CLLocationCoordinate2D) temp_coordinate;

- (id) initWithCoordinate:(CLLocationCoordinate2D)c withTag:(NSUInteger)t withTitle:(NSString *)tl withSubtitle:	(NSString *)s;

- (id) initWithCoordinateAndType:(CLLocationCoordinate2D)c withTag:(NSUInteger)t withTitle:(NSString *)tl withSubtitle:	(NSString *)s annotationType:(UICRouteAnnotationType)type;

@end
