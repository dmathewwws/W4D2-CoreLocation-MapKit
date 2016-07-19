//
//  FoursquareManager.h
//  MapKit-Test
//
//  Created by Daniel Mathews on 2016-07-19.
//  Copyright © 2016 Daniel Mathews. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface FoursquareManager : NSObject

+ (void)responseFrom4sq:(CLLocation*)currentLocation categoryId:(NSString*)categoryId limit:(NSString*)limit block:(void (^)(NSArray *locationsArray, NSError *error))completionBlock;

@end
