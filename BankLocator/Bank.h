//
//  Bank.h
//  BankLocator
//
//  Created by Karl Kinnard on 8/10/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Bank : NSObject<MKAnnotation>

@property (strong, nonatomic)NSString * name;
@property (strong, nonatomic)NSString * address;
@property (strong, nonatomic)NSString * bankName;
@property (strong, nonatomic)NSString * distance;
@property (strong, nonatomic)NSString * state;
@property (strong, nonatomic)NSString * city;
@property (strong, nonatomic)NSString * zip;
@property (strong, nonatomic)NSString * access;
@property (strong, nonatomic)NSString *latitude;
@property (strong, nonatomic)NSString *longitude;
@property (nonatomic)CLLocationCoordinate2D coordinate;


-(id)initWithBank:(NSString *)name andAddress:(NSString *)address andBankName:(NSString *)bankName andDistance:(NSString *)distance andState:(NSString *)state andCity:(NSString *)city andZip:(NSString *)zip andAccess:(NSString *)access andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;

-(id)init;

@end
