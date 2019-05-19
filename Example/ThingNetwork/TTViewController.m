//
//  TTViewController.m
//  ThingNetwork
//
//  Created by hungnv038 on 05/11/2019.
//  Copyright (c) 2019 hungnv038. All rights reserved.
//

#import "TTViewController.h"
#import "TTExampleNetwork.h"

@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnClick:(id)sender {
    TTExampleNetwork *network = [[TTExampleNetwork alloc] init];
    [network getExampleData:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSString * _Nonnull failureReason, NSInteger statusCode) {
        NSLog(@"%@", failureReason);
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
