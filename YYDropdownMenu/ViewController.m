//
//  ViewController.m
//  YYDropdownMenu
//
//  Created by iosdev on 16/1/15.
//  Copyright © 2016年 iosdev. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

#import "Test3ViewController.h"

@interface ViewController (){
    
}

- (IBAction)clicked1:(id)sender;
- (IBAction)clicked2:(id)sender;
- (IBAction)clicked3:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clicked1:(id)sender {
    [self.navigationController pushViewController:[[TestViewController alloc] init] animated:YES];
}

- (IBAction)clicked2:(id)sender {
    
}

- (IBAction)clicked3:(id)sender {
    [self.navigationController pushViewController:[[Test3ViewController alloc] init] animated:YES];
}
@end
