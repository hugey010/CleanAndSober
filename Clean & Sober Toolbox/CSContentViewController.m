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

    // load random background image
    /*
    NSArray *backgroundImagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@"Florida_2014"];
    NSUInteger randomIndex = arc4random() % [backgroundImagePaths count];
    UIImage *image = [UIImage imageWithContentsOfFile:backgroundImagePaths[randomIndex]];
    self.backgroundImage.image = image;
     */
}

-(void)setupWithContent:(CSContent*)content {
    if (!viewLoaded) {
        cscontent = content;
        return;
    }
    self.navigationItem.title = @"Message";//content.title;
    
    [self.webview loadHTMLString:[NSString stringWithFormat:@"%@<br><br>%@", content.message, content.todo] baseURL:nil];
    [self.webview setBackgroundColor:[UIColor clearColor]];
    [self.webview setOpaque:NO];
}

@end
