//
//  ViewController.m
//  MapKit-Test
//
//  Created by Daniel Mathews on 2016-07-19.
//  Copyright © 2016 Daniel Mathews. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MyLocationManager.h"
@import MapKit;
#import "FoursquareManager.h"

#define zoominMapArea 2100

@interface ViewController () <MKMapViewDelegate, MyLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) MyLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initiateMap];

}

-(void) initiateMap {
    self.locationManager = [MyLocationManager sharedManager];
    [self.locationManager startLocationMonitoring];
    self.locationManager.delegate = self;

}

-(void)newLocationDetected:(CLLocation *)location{
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    
    [FoursquareManager responseFrom4sq:location categoryId:@"4d4b7105d754a06377d81259" limit:@"20" block:^(NSArray *locationsArray, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView addAnnotations:locationsArray];
        });
        
        
        
    }];

}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
