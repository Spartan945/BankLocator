//
//  BankDelegate.m
//  BankLocator
//
//  Created by Karl Kinnard on 8/10/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//

#import "BankDelegate.h"
#import <UIKit/UIKit.h>


@interface BankDelegate ()

@property (strong, nonatomic)NSMutableData * bankData;

@end
@implementation BankDelegate

-(void)downloadbanks
{
    //Create a string varialbe to hold the url.
    NSString *bankURLString = @"https://m.chase.com/PSRWeb/location/list.action?lat=33.748995&lng=-84.387982";
    //Create an object of type NSURL and wrap the url string.
    NSURL *bankURL = [NSURL URLWithString:bankURLString];
    //Create an NSURLRequest based on the url.
    NSURLRequest *bankRequest = [NSURLRequest requestWithURL:bankURL];
    //Create an NSURLConnection with the request.
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:bankRequest delegate:self];
    
    [connection start];
    
}



#pragma mark - NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _bankData = [[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_bankData appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //This is where we will parse JSON
    [self.delegate fetchBankData:_bankData];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
    
}



@end
