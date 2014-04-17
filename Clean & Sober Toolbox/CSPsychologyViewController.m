//
//  CSPsychologyViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/23/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSPsychologyViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "User.h"

@interface CSPsychologyViewController ()

@end

@implementation CSPsychologyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"About";
    
    User *user = [User MR_findFirst];
    NSMutableString *html = [kScaleMeta mutableCopy];
    if (user.psychologyMessage) {
        [html appendString:user.psychologyMessage];
    } else {
        [html appendString:kPsychologyMessage];
    }

    [self.webview loadHTMLString:html baseURL:nil];
    [self.webview setScalesPageToFit:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.slidingViewController anchorTopViewTo:ECLeft];
    [super viewWillDisappear:animated];
}

@end
