//
//  LocationFinderViewController.h
//  LocationFinder
//
//  Created by TheAppGuruz-iOS-103 on 15/05/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationFinderViewController : UIViewController<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtLatitude, *txtLongitude, *txtState, *txtCountry;

@property (nonatomic, retain) CLLocationManager *locationManager;
@end
