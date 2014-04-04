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
    self.navigationItem.title = [NSString stringWithFormat:@"Days Sober: %@", user.daysInARow];
    [self.notificationsSwitch setOn:[user.notificationsOn boolValue]];
}

- (void)sendToPsychology {
    UIViewController *psychVC = [self.storyboard instantiateViewControllerWithIdentifier:@"psychology"];
    [self specializedPush:psychVC];
}

- (void)sendToDonate {
    UIViewController *donateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"donate"];
    [self specializedPush:donateVC];
}

-(void)sendToDisclaimer {
    UIViewController *disclaimerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"disclaimer"];
    [self specializedPush:disclaimerVC];
}

- (IBAction)notificationsValueChanged:(id)sender {
    // TODO: toggle notifications on server on/off
    User *user = [User MR_findFirst];
    user.notificationsOn = [NSNumber numberWithBool:self.notificationsSwitch.isOn];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    if (!user.notificationsOn) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }

}

-(void)sendHome {
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
            cell.textLabel.text = @"Psychology Behind App";
            break;
        }
        case 1 : {
            cell.textLabel.text = @"Donate";
            break;
        }
        case 2 : {
            cell.textLabel.text = @"Disclaimer";
            break;
        }
        case 3 : {
            cell.textLabel.text = @"Rewards";
            break;
        }
        case 4 : {
            cell.textLabel.text = @"Home";
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
        case 1 : {
            [self sendToDonate];
            break;
        }
        case 2 : {
            [self sendToDisclaimer];
            break;
        }
        case 3 : {
            [self sendToRewards];
            break;
        }
        case 4 : {
            [self sendHome];
            break;
        }
    }
}

@end
