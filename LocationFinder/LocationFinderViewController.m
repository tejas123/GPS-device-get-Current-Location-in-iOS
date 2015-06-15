//
//  LocationFinderViewController.m
//  LocationFinder
//
//  Created by TheAppGuruz-iOS-103 on 15/05/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

#import "LocationFinderViewController.h"

@interface LocationFinderViewController ()
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@end

@implementation LocationFinderViewController
@synthesize locationManager;
@synthesize txtState, txtLatitude, txtLongitude, txtCountry;

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    geocoder = [[CLGeocoder alloc] init];
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Turn off the location manager to save power.
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManager delegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    CLLocation *newLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            txtLatitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            txtLongitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            txtState.text = placemark.administrativeArea;
            txtCountry.text = placemark.country;
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}


@end
