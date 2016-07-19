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
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(present)];
    [self.view addGestureRecognizer: tap];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.view.frame = CGRectMake(50, 120, 300, 550);
}

- (void)present
{
    PresentedVC2 *vc2 = [[PresentedVC2 alloc]init];
    
#ifdef TRANSPARENT
    [self.presentingViewController.navigationController presentViewController:vc2 animated:YES completion:nil];
#else
    [self presentViewController:vc2 animated:YES completion:nil];
#endif
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
    NSLog(@"self = %@, self.presentingViewController = %@, self.presentingViewController.navigationController = %@",
          self, self.presentingViewController, self.presentingViewController.navigationController);

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
