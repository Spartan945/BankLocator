//
//  BankDetailViewController.m
//  BankLocator
//
//  Created by Karl Kinnard on 8/10/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//

#import "BankDetailViewController.h"

@interface BankDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
//-(id)initWithBank:(NSString *)name andAddress:(NSString *)address andBankName:(NSString *)bankName andDistance:(NSString *)distance andState:(NSString *)state andCity:(NSString *)city andZip:(NSString *)zip andAccess:(NSString *)access;

@implementation BankDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _passedBank.name;
    _bankNameLabel.text = _passedBank.bankName;
    NSString *formatedString = [NSString stringWithFormat:@"Distance: %@ miles \n\n Address: %@ , %@ , %@ , %@ \n\n Access type: %@ \n", _passedBank.distance, _passedBank.address, _passedBank.city, _passedBank.state, _passedBank.zip, _passedBank.access ];
    _textView.text = formatedString;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
