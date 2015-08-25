//
//  BankDelegate.h
//  BankLocator
//
//  Created by Karl Kinnard on 8/10/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BankParseDelegate <NSObject>

-(void)fetchBankData:(NSMutableData *)data;


@end


@interface BankDelegate : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) id <BankParseDelegate> delegate;

-(void)downloadbanks;

@end
