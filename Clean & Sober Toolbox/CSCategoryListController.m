//
//  CSCategoryListController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSCategoryListController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>

@interface CSCategoryListController ()

@end

@implementation CSCategoryListController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = kAppTitle;
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}
@end
