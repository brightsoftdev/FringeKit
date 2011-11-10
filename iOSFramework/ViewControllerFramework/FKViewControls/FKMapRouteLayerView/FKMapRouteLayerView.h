//
//  CSMapRouteLayerView.h
//  mapLines
//
//  Created by Craig on 4/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FKMapRouteLayerView : UIView{
	MKMapView *inMapView;
	NSArray *routes;
	UIColor *lineColor;
}

- (id)initWithMapView:(MKMapView *)mapView;

@property (nonatomic, retain) MKMapView *inMapView;
@property (nonatomic, retain) NSArray *routes;
@property (nonatomic, retain) UIColor *lineColor;

@end

