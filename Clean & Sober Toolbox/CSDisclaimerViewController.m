//
//  CSDisclaimerViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/23/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSDisclaimerViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "User.h"

@interface CSDisclaimerViewController ()

@end

@implementation CSDisclaimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Disclaimer";
    
    User *user = [User MR_findFirst];
    if (user.disclaimerMessage) {
        self.textview.text = user.disclaimerMessage;
    } else {
        self.textview.text = kDisclaimerMessage;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.slidingViewController anchorTopViewTo:ECLeft];
    [super viewWillDisappear:animated];
}

@end
