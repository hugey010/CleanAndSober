//
//  CSMenuViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSMenuViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>

@interface CSMenuViewController ()

@end

@implementation CSMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: use # of days app used in a row.
    self.navigationItem.title = @"Days Sober = 20";
}

- (IBAction)psychologyButtonPressed:(id)sender {
}

- (IBAction)donateButtonPressed:(id)sender {
    UIViewController *donateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"donate"];
    [self specializedPush:donateVC];
}

- (IBAction)disclaimerButtonPressed:(id)sender {
    UIViewController *disclaimerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"disclaimer"];
    [self specializedPush:disclaimerVC];
}

- (IBAction)notificationsValueChanged:(id)sender {
    // TODO: toggle notifications on/off
}

- (IBAction)emailValueChanged:(id)sender {
    // TODO: toggle email on server on/off
}

-(void)specializedPush:(UIViewController*)viewController {
    [self.slidingViewController resetTopView];
    [self.slidingViewController.topViewController.navigationController pushViewController:viewController animated:YES];
}
@end
