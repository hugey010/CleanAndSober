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
#import "CSUtilities.h"
#import "CSCategoryListController.h"
#import "CSContentViewController.h"

@interface CSMenuViewController () {
    NSDateFormatter *df;
}

@end

@implementation CSMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:COLOR_BACKGROUND];
    
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"hh:mm aa"];
    
    User *user = [User MR_findFirst];
    

    self.notificationsDateField.inputView = self.datePicker;
    self.notificationsDateField.inputAccessoryView = self.toolbar;
    if ([user.dailyNotificationDate compare:[NSDate dateWithTimeIntervalSince1970:0]] != NSOrderedSame) {
        self.notificationsDateField.text = [df stringFromDate:user.dailyNotificationDate];
        [self.notificationsSwitch setOn:YES];
    } else {
        [self.notificationsSwitch setOn:NO];
    }
    
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.notificationView.backgroundColor = kCOLOR_VIEWS_2;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    User *user = [User MR_findFirst];
    self.navigationItem.title = [NSString stringWithFormat:@"App Days: %@", user.daysInARow];
}

-(void)dateChanged:(UIDatePicker*)dp {
    User *user = [User MR_findFirst];
    [self.notificationsSwitch setOn:YES animated:YES];
    user.dailyNotificationDate = dp.date;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [CSUtilities scheduleDailyMessageNotification:YES];

    self.notificationsDateField.text = [df stringFromDate:dp.date];
}

- (void)sendToPsychology {
    UIViewController *psychVC = [self.storyboard instantiateViewControllerWithIdentifier:@"psychology"];
    [self specializedPush:psychVC];
}

- (void)sendToDonate {
    // had to remove paypal donate, I left in the project because I just don't care. Still in storyboard too.
    //UIViewController *donateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"donate"];
    UIViewController *donateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"donate_stupid"];
    [self specializedPush:donateVC];
}

-(void)sendToDisclaimer {
    UIViewController *disclaimerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"disclaimer"];
    [self specializedPush:disclaimerVC];
}

- (IBAction)notificationsValueChanged:(id)sender {
    if (!self.notificationsSwitch.isOn) {
        [CSUtilities scheduleDailyMessageNotification:NO];
    } else {
        [self.notificationsDateField becomeFirstResponder];
    }
}

- (IBAction)doneButtonPressed:(id)sender {
    [self.view endEditing:YES];
    [CSUtilities scheduleDailyMessageNotification:YES];
}

-(void)sendHome {
    UINavigationController *nav = (UINavigationController*)self.slidingViewController.topViewController;
    [nav popToRootViewControllerAnimated:NO];
    CSCategoryListController *listvc = (CSCategoryListController*)nav.viewControllers[0];
    [listvc loadInitialContent];
    [self.slidingViewController resetTopView];
}

-(void)sendtoPsychology {
    UIViewController *psychVC = [self.storyboard instantiateViewControllerWithIdentifier:@"psychology"];
    [self specializedPush:psychVC];
}

-(void)specializedPush:(UIViewController*)viewController {
    [self.slidingViewController resetTopView];
    [(UINavigationController*)self.slidingViewController.topViewController pushViewController:viewController animated:YES];
}

-(void)sendToRewards {
    UIViewController *rewards = [self.storyboard instantiateViewControllerWithIdentifier:@"rewards"];
    [self specializedPush:rewards];
}

-(void)sendToRandomMessage {
    CSContentViewController *content = [self.storyboard instantiateViewControllerWithIdentifier:@"content"];
    [self specializedPush:content];
    [content setupWithContent:[CSUtilities randomContent]];    
}

#pragma mark - UITableView methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_identifier = @"Menu_Cell_Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0 : {
            cell.textLabel.text = @"About";
            break;
        }
        /*
        case 1 : {
            cell.textLabel.text = @"Donate";
            break;
        }
         */
        case 1 : {
            cell.textLabel.text = @"Disclaimer";
            break;
        }
        case 2 : {
            cell.textLabel.text = @"Rewards";
            break;
        }
        case 3 : {
            cell.textLabel.text = @"Home";
            break;
        }
        case 4 : {
            cell.textLabel.text = @"Random Message";
            break;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0 : {
            [self sendToPsychology];
            break;
        }
        /*
        case 1 : {
            [self sendToDonate];
            break;
        }
        */
        case 1 : {
            [self sendToDisclaimer];
            break;
        }
        case 2 : {
            [self sendToRewards];
            break;
        }
        case 3 : {
            [self sendHome];
            break;
        }
        case 4 : {
            [self sendToRandomMessage];
            break;
        }
    }
}

#pragma mark - UISearchBar methods

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    UINavigationController *nav = (UINavigationController*)self.slidingViewController.topViewController;
    CSCategoryListController *listvc = (CSCategoryListController*)nav.viewControllers[0];
    [listvc searchAllContent:searchBar.text];
    [self.slidingViewController resetTopView];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    UINavigationController *nav = (UINavigationController*)self.slidingViewController.topViewController;
    [nav popToRootViewControllerAnimated:NO];
    [self.slidingViewController resetTopView];
}

@end
