//
//  CSWebViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 5/21/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSWebViewController.h"

@interface CSWebViewController ()

@end

@implementation CSWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://sobertool.com/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];

}

@end
