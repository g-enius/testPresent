//
//  PushedVC.m
//  testPresent
//
//  Created by Charles on 7/19/16.
//  Copyright © 2016 Charles. All rights reserved.
//

#import "PushedVC.h"
#import "ChildVC.h"

@implementation PushedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"PushedVC viewDidLoad");

    self.title = @"PushedVC";
    self.view.backgroundColor = [UIColor blueColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentVC)];
    [self.view addGestureRecognizer:tap];
}

- (void)dealloc
{
    NSLog(@"PushedVC dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"++++++++PushedVC viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"PushedVC viewDidAppear");
    NSLog(@"self = %@, self.navigationController = %@", self, self.navigationController);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"PushedVC viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"PushedVC viewDidDisappear");
}

- (void) presentVC
{
    ChildVC *vc = [[ChildVC alloc]init];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(30, 100, 350, 600);
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

@end
