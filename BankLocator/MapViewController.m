//
//  MapViewController.m
//  BankLocator
//
//  Created by Karl Kinnard on 8/11/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import "MapViewController.h"
#import "Bank.h"
#import <MapKit/MapKit.h>



@interface MapViewController ()

@property (strong, nonatomic)NSString *destinationText;
@property (nonatomic, strong)CLLocation *loc;
@property (strong, nonatomic)CLLocation *pointBLocation;
@property (strong, nonatomic)CLLocation *location;
@property (assign, nonatomic)CLLocationCoordinate2D there;
@property (assign, nonatomic)float lat;
@property (assign, nonatomic)float longl;
@property (assign, nonatomic)float distanceMeters;
@property (assign, nonatomic)float distanceInMiles;
@property (nonatomic)NSUInteger index;



@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.map.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    CLLocationCoordinate2D polCoordinates;
    //Plot pins
    for(int i = 0; i < [_locations count];i++)
    {
        NSLog(@"%@", _locations);
        Bank *loc = _locations[i];
        //Create coordinates from locatino lat/long
        polCoordinates.latitude = [loc.latitude doubleValue];
        polCoordinates.longitude = [loc.longitude doubleValue];
        loc.coordinate = polCoordinates;
        [self.map addAnnotation:loc];
        
    }
    
    //Instantiate a location object
    self.locationManager = [[CLLocationManager alloc]init];
    //Make this controller the delegate for the locatino manager.
    [self.locationManager setDelegate:self];
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER)
    {
        [self.locationManager requestAlwaysAuthorization];
        
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    //INitialize a MKMapRect variable to null.
    MKMapRect zoomRect = MKMapRectNull;
    
    for(id <MKAnnotation> annotation in _map.annotations)
    {
        //For each MKAnnotation in the mapview's annotions array, create an annotation point
        //for the annotation's coordinate.
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        
        //Then create a rectangle based on he annotationPoint's size and osition.
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        
        //Join the annotatino point's rectangle and the zoom rectangle.
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
        
    }
    
    //Set the visible rectangle of the map.
    [_map setVisibleMapRect:zoomRect animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    Bank *location = view.annotation;
    self.index = [mapView.annotations indexOfObject:location];
    NSLog(@"Index is %ld", (long)self.index);
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Directions" message:@"Would you like directions to this destination?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alertView show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        Bank *loc = self.map.annotations[_index];
        [self routeMapWithLocation:loc];
    }
    
    else
    {
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        
    }
}

-(void)routeMapWithLocation:(Bank *)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    NSString *destinationText = [NSString stringWithFormat:@"%@ %@, %@ %@", location.address, location.city, location.state, location.zip];
    NSLog(@"%@", destinationText);
    
    [geocoder geocodeAddressString:destinationText completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if([placemarks count] > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            _location = placemark.location;
            _there = _location.coordinate;
            MKPlacemark *destPlace = [[MKPlacemark alloc]initWithCoordinate:_there addressDictionary:nil];
            MKMapItem *destMapItem = [[MKMapItem alloc]initWithPlacemark:destPlace];
            destMapItem.name = _destinationText;
            _pointBLocation = [[CLLocation alloc]initWithLatitude:_location.coordinate.latitude longitude:_location.coordinate.longitude];
            NSArray *mapItems = [[NSArray alloc]initWithObjects:destMapItem, nil];
            NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsDirectionsModeKey, nil];
            [MKMapItem openMapsWithItems:mapItems launchOptions:options];
                                                                                                           
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
