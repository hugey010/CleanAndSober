//
//  CSPsychologyViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/23/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSPsychologyViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>

@interface CSPsychologyViewController ()

@end

@implementation CSPsychologyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Psychology";
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.slidingViewController anchorTopViewTo:ECLeft];
    [super viewWillDisappear:animated];
}

@end
