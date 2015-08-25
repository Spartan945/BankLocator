//
//  MapViewController.h
//  BankLocator
//
//  Created by Karl Kinnard on 8/11/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Bank.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic)NSArray *locations;
@property (strong, nonatomic)IBOutlet MKMapView *map;
@property (strong, nonatomic)CLLocationManager *locationManager;
@property (strong, nonatomic)Bank *passedLocation;

@end
