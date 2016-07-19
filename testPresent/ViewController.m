//
//  ViewController.m
//  testPresent
//
//  Created by Charles on 7/16/16.
//  Copyright © 2016 Charles. All rights reserved.
//

#import "ViewController.h"
#import "PushedVC.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"presentingVC viewDidLoad");
    
    self.title = @"presentingVC";
    self.view.backgroundColor =[UIColor redColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentVC)];
    [self.view addGestureRecognizer: tap];
}

- (void)dealloc
{
    NSLog(@"presentingVC dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"++++++++presentingVC viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"presentingVC viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"presentingVC viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"presentingVC viewDidDisappear");
}

- (void) presentVC
{
    PushedVC *vc = [[PushedVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"self = %@, self.navigationController = %@", self, self.navigationController);
}

@end
