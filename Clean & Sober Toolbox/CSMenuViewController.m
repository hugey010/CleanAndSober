//
//  CSMenuViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSMenuViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "User.h"

@interface CSMenuViewController ()

@end

@implementation CSMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:COLOR_BACKGROUND];
    
    User *user = [User MR_findFirst];
    self.navigationItem.title = [NSString stringWithFormat:@"Days Sober = %@", user.daysInARow];
    [self.emailSwitch setOn:[user.emailsOn boolValue]];
    [self.notificationsSwitch setOn:[user.notificationsOn boolValue]];
}

- (IBAction)psychologyButtonPressed:(id)sender {
    UIViewController *psychVC = [self.storyboard instantiateViewControllerWithIdentifier:@"psychology"];
    [self specializedPush:psychVC];
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
    // TODO: toggle notifications on server on/off
    User *user = [User MR_findFirst];
    user.notificationsOn = [NSNumber numberWithBool:self.notificationsSwitch.isOn];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)emailValueChanged:(id)sender {
    // TODO: toggle email on server on/off
    User *user = [User MR_findFirst];
    user.emailsOn = [NSNumber numberWithBool:self.emailSwitch.isOn];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    if (user.emailsOn && user.email.length <= 0) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter Email" message:@"To receive emails, please enter your email address." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        });
        
        [self.emailSwitch setOn:NO];
    }
}

- (IBAction)homeButtonPressed:(id)sender {
    [self.slidingViewController resetTopView];
}

- (IBAction)psycologyButtonPressed:(id)sender {
    UIViewController *psychVC = [self.storyboard instantiateViewControllerWithIdentifier:@"psychology"];
    [self specializedPush:psychVC];
}

-(void)specializedPush:(UIViewController*)viewController {
    [self.slidingViewController resetTopView];
    [(UINavigationController*)self.slidingViewController.topViewController pushViewController:viewController animated:YES];
}

#pragma mark - UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length > 3) {
        User *user = [User MR_findFirst];
        user.email = textField.text;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

        // TODO: upload new email to server
    }
}

@end
