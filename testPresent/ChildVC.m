//
//  ChildVC.m
//  testPresent
//
//  Created by Charles on 7/19/16.
//  Copyright © 2016 Charles. All rights reserved.
//

#import "ChildVC.h"
#import "PresentedVC1.h"

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ChildVC viewDidLoad");

    self.view.backgroundColor =[UIColor yellowColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentVC)];
    [self.view addGestureRecognizer: tap];
}

- (void)dealloc
{
    NSLog(@"ChildVC dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"++++++++ChildVC viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"ChildVC viewDidAppear");
    NSLog(@"self = %@, self.navigationController = %@", self, self.navigationController);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"ChildVC viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"ChildVC viewDidDisappear");
}

- (void) presentVC
{
    PresentedVC1 *vc = [[PresentedVC1 alloc]init];
    
#ifdef TRANSPARENT
    self.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
#endif
    
    [self presentViewController:vc animated:YES completion:nil];

}

@end
