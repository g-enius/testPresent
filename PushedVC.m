//
//  PushedVC.m
//  testPresent
//
//  Created by Charles on 7/19/16.
//  Copyright © 2016 Charles. All rights reserved.
//

#import "PushedVC.h"
#import "PresentedVC1.h"

@implementation PushedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"PushedVC viewDidLoad");
    
    self.view.backgroundColor =[UIColor redColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentVC)];
    [self.view addGestureRecognizer: tap];
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
    PresentedVC1 *vc = [[PresentedVC1 alloc]init];
    self.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.providesPresentationContextTransitionStyle = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
