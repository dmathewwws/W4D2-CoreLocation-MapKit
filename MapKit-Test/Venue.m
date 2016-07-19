//
//  Venue.m
//  MapKit-Test
//
//  Created by Daniel Mathews on 2016-07-19.
//  Copyright © 2016 Daniel Mathews. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString * _Nullable)aTitle andSubtitle:(NSString * _Nullable)aSubtitle
{
    self = [super init];
    if (self) {
        _coordinate = aCoordinate;
        _title = aTitle;
        _subtitle = aSubtitle;
    }
    return self;
}


@end
