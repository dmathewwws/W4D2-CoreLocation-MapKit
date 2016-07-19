//
//  MyLocationManager.h
//  MapKit-Test
//
//  Created by Daniel Mathews on 2016-07-19.
//  Copyright © 2016 Daniel Mathews. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import CoreLocation;

@protocol MyLocationManagerDelegate <NSObject>

-(void) newLocationDetected:(CLLocation*) location;

@end


@interface MyLocationManager : NSObject

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *currentLocation;

@property(nonatomic, weak) id<MyLocationManagerDelegate> delegate;

+ (id)sharedManager;
- (void)startLocationMonitoring;

@end
