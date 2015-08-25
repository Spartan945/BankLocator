//
//  ViewController.m
//  BankLocator
//
//  Created by Karl Kinnard on 8/10/15.
//  Copyright (c) 2015 Karl Kinnard. All rights reserved.
//

#import "BankListViewController.h"
#import "BankDetailViewController.h"
#import "MapViewController.h"
#import "MBProgressHUD.h"

@interface BankListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)MBProgressHUD *hud;

@property(strong, nonatomic)NSMutableArray *banks;

@property (strong, nonatomic)Bank *bank;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BankListViewController

NSString * createdTime;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    BankDelegate *bankDelegate = [[BankDelegate alloc]init];
    [bankDelegate downloadbanks];
    bankDelegate.delegate = self;
    
    
}

-(void)fetchBankData:(NSMutableData *)data
{
    NSError *error = nil;
    //Create a dictinoary for the json document
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSLog(@"%@", jsonObject);
    self.banks = [[NSMutableArray alloc]init];
    NSArray *immutableBanks = jsonObject[@"locations"];
    for(NSDictionary *dict in immutableBanks)
    {
        //if(![Dict isEqual:[NSNull null]])
        //{
        
        NSString *name;
        NSString *addressString;
        NSString *bankNString;
        NSString *dist;
        NSString *state;
        NSString *city;
        NSString *zip;
        NSString *accessString;
        NSString *latitude;
        NSString *longitude;
        
        //sets the strings for the banks information based on the JSON page
        name = dict[@"name"];
        //NSDictionary *atAddressDict = bank[@"address"];
        addressString = dict[@"address"];
        bankNString = dict[@"bank"];
        dist = dict[@"distance"];
        state = dict[@"state"];
        city = dict[@"city"];
        zip = dict[@"zip"];
        //if access specifier does not exist, say so instead of null!, else show the access type
        if(dict[@"access"] == nil || dict[@"access"] == NULL)
        {
            accessString = @"Not Specified";
        }
        else
        {
            accessString = dict[@"access"];
        }
        //gets the coordinates
        latitude = dict[@"lat"];
        longitude = dict[@"lng"];
        
        //sets the info into a Bank object and returns it.
        self.bank = [[Bank alloc]initWithBank:name
                                   andAddress:addressString
                                  andBankName:bankNString
                                  andDistance:dist
                                     andState:state
                                      andCity:city
                                       andZip:zip
                                    andAccess:accessString
                                    andLatitude:latitude
                                 andLongitude:longitude];
        
        [self.banks addObject:self.bank];
            //}
    }
    [self.tableView reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_banks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"BankCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Bank *bank = _banks[indexPath.row];
    
    cell.textLabel.text = bank.name;
    cell.detailTextLabel.text = bank.address;
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if([segue.destinationViewController isKindOfClass:[BankDetailViewController class]])
    {
        BankDetailViewController *bdvc = (BankDetailViewController *)segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Bank *selectedBank = _banks[indexPath.row];
        bdvc.passedBank = selectedBank;
    }
    else if([segue.destinationViewController isKindOfClass:[MapViewController class]])
    {
        MapViewController *mvc = (MapViewController *)segue.destinationViewController;
        mvc.locations = _banks;
        
    }
}

@end
