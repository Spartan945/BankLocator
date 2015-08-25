//
//  Bank.m
//  BankLocator
//
//  Created by Karl Kinnard on 8/10/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//

#import "Bank.h"

@implementation Bank


-(id)initWithBank:(NSString *)name andAddress:(NSString *)address andBankName:(NSString *)bankName andDistance:(NSString *)distance andState:(NSString *)state andCity:(NSString *)city andZip:(NSString *)zip andAccess:(NSString *)access andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    self = [super init];
    
    if(self)
    {
        _name = name;
        _address = address;
        _bankName = bankName;
        _distance = distance;
        _state = state;
        _city = city;
        _zip = zip;
        _access = access;
        _latitude = latitude;
        _longitude = longitude;
        
    }
    
    return self;
}

-(id)init
{
    return [self initWithBank:nil andAddress:nil andBankName:nil andDistance:nil andState:nil andCity:nil andZip:nil andAccess:nil andLatitude:nil andLongitude:nil];
}

@end
