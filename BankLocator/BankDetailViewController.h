//
//  BankDetailViewController.h
//  BankLocator
//
//  Created by Karl Kinnard on 8/10/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bank.h"
#import "BankDelegate.h"

@interface BankDetailViewController : UIViewController

@property (strong, nonatomic)Bank *passedBank;

@end
