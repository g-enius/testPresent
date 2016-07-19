//
//  PresentedVC2.m
//  testPresent
//
//  Created by Charles on 7/18/16.
//  Copyright © 2016 Charles. All rights reserved.
//

#import "PresentedVC2.h"

@implementation PresentedVC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"PresentedVC  2 viewDidLoad");
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
}

- (void)dealloc
{
    NSLog(@"PresentedVC  2 dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"PresentedVC  2 viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"PresentedVC  2 viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"PresentedVC  2 viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"PresentedVC  2 viewDidDisappear");
}

- (void)dismiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
