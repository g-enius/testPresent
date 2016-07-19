//
//  presentVC.m
//  testPresent
//
//  Created by Charles on 7/16/16.
//  Copyright © 2016 Charles. All rights reserved.
//

#import "PresentedVC1.h"
#import "PresentedVC2.h"

@implementation PresentedVC1

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"presentedVC  1 viewDidLoad");

    self.view.backgroundColor = [UIColor clearColor];
    self.view.opaque = NO;

    UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 300, 400)];
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:maskView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(present)];
    [maskView addGestureRecognizer: tap];
}

- (void)present
{
    PresentedVC2 *vc2 = [[PresentedVC2 alloc]init];
    [self.presentingViewController.navigationController presentViewController:vc2 animated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"presentedVC  1 dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"presentedVC  1 viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"presentedVC  1 viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"presentedVC  1 viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"presentedVC  1 viewDidDisappear");
}

@end
