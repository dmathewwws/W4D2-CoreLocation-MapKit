//
//  FoursquareManager.m
//  MapKit-Test
//
//  Created by Daniel Mathews on 2016-07-19.
//  Copyright © 2016 Daniel Mathews. All rights reserved.
//

#import "FoursquareManager.h"
#import "Venue.h"

@implementation FoursquareManager

+ (void)responseFrom4sq:(CLLocation*)currentLocation categoryId:(NSString*)categoryId limit:(NSString*)limit block:(void (^)(NSArray *locationsArray, NSError *error))completionBlock{
    
    NSString *apiString4aq= @"https://api.foursquare.com/v2/venues/search?ll=";
    NSString *clientID = @"&client_id=OBPKCY1L3L1PYYTV3B3IFDJUINUF3DNW5K5ZNPODRZOOPEJZ&client_secret=TOWRESTHGUKBQB0EOC2KFPTAJ3UBSA2Z5ADXNFERZVWR3M0R";
    NSString *version = @"&v=20121219";
    
    NSMutableURLRequest *foursqRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%1.6f,%1.6f&categoryId=%@%@%@&limit=%@",apiString4aq,currentLocation.coordinate.latitude,currentLocation.coordinate.longitude,categoryId,clientID,version,limit]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:foursqRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSError *myJSONSerializationError = nil;
            
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&myJSONSerializationError];
            
            NSDictionary *responseDict = JSON[@"response"];
            NSArray *locationsArray = responseDict[@"venues"];
            
            NSMutableArray *venues = [NSMutableArray array];
            
            for (NSDictionary *eachLocation in locationsArray){
                NSString *name = eachLocation[@"name"];
                NSDictionary *locationDetailsInVenue = eachLocation[@"location"];
                NSString *address = locationDetailsInVenue[@"address"];
                NSNumber *lat = locationDetailsInVenue[@"lat"];
                NSNumber *lng = locationDetailsInVenue[@"lng"];
                
                Venue *venue = [[Venue alloc] initWithCoordinate:CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]) andTitle:name andSubtitle:address];
                
                [venues addObject:venue];
                
            }
            
            completionBlock(venues, nil);
            
        }else {
            completionBlock(nil, error);
        }
        
    }];
    
    [task resume];
}


@end
