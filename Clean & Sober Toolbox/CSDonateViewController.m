//
//  CSDonateViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/22/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSDonateViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>

@interface CSDonateViewController ()

@end

@implementation CSDonateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Donate";
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.slidingViewController anchorTopViewTo:ECLeft];
    [super viewWillDisappear:animated];
}

@end
