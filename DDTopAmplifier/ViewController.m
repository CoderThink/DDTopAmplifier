//
//  ViewController.m
//  DDTopAmplifier
//
//  Created by Think on 2017/9/4.
//  Copyright © 2017年 Think. All rights reserved.
//

#import "ViewController.h"
#import "DDHeaderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickButton:(id)sender {
    DDHeaderViewController *headerVc = [[DDHeaderViewController alloc] init];
    [self.navigationController pushViewController:headerVc animated:YES];
}


@end
