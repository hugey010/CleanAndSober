//
//  CSContentViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/14/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSContentViewController.h"
#import "CSContent.h"

@interface CSContentViewController ()

@end

@implementation CSContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


}

-(void)setupWithContent:(CSContent*)content {
    self.navigationItem.title = content.title;
    
}

@end
