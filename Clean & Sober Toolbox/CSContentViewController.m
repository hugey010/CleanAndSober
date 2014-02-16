//
//  CSContentViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/14/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSContentViewController.h"
#import "CSContent.h"

@interface CSContentViewController () {
    BOOL viewLoaded;
    CSContent *cscontent;
}

@end

@implementation CSContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (cscontent) {
        viewLoaded = YES;
        [self setupWithContent:cscontent];
    }
}

-(void)setupWithContent:(CSContent*)content {
    if (!viewLoaded) {
        cscontent = content;
        return;
    }
    
    self.navigationItem.title = content.title;
    
   [self.webview loadHTMLString:content.message baseURL:nil];
}

@end
