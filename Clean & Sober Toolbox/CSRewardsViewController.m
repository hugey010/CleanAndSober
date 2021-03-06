//
//  CSRewardsViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 4/7/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSRewardsViewController.h"
#import "User.h"
#import "CSUtilities.h"

@interface CSRewardsViewController () {
    User *user;
}

@end

@implementation CSRewardsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    user = [User MR_findFirst];    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = [NSString stringWithFormat:@"App Days: %@", user.daysInARow];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DAYS_FOR_COINS count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rewards_cell" forIndexPath:indexPath];
    
    UIImageView *iv = (UIImageView*)[cell viewWithTag:21];
    UILabel *label = (UILabel*)[cell viewWithTag:22];
    
    NSString *text = @"";
    UIImage *image = nil;
    BOOL enabled = NO;
    
    if ([user.daysInARow integerValue] > [DAYS_FOR_COINS[indexPath.row] integerValue]) {
        enabled = YES;
    }
    
    switch (indexPath.row) {
        case 0 : {
            text = @"Seven Days";
            image = [UIImage imageNamed:@"coin7.png"];
            break;
        }
        case 1 : {
            text = @"Thirty Days";
            image = [UIImage imageNamed:@"coin30.png"];
            break;
        }
        case 2 : {
            text = @"Sixty Days";
            image = [UIImage imageNamed:@"coin60.png"];
            break;
        }
        case 3 : {
            text = @"Ninety Days";
            image = [UIImage imageNamed:@"coin90.png"];
            break;
        }
        case 4 : {
            text = @"Six Months";
            image = [UIImage imageNamed:@"coin6month.png"];
            break;
        }
        case 5 : {
            text = @"Nine Months";
            image = [UIImage imageNamed:@"coin9month.png"];
            break;
        }
        case 6 : {
            text = @"One Year";
            image = [UIImage imageNamed:@"coinyear.png"];
            break;
        }
        case 7 : {
            text = @"One Year Certificate";
            image = [UIImage imageNamed:@"yearcert"];
        }
    }
    
    iv.image = image;
    label.text = text;
    cell.userInteractionEnabled = enabled;
    label.enabled = enabled;
    iv.alpha = enabled ? 1.0 : 0.5;
    
    return cell;
}

/*
- (IBAction)resetButtonPressed:(id)sender {
    [User MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]];
    [CSUtilities updateUser];
    
    user = [User MR_findFirst];
    self.navigationItem.title = [NSString stringWithFormat:@"App Days: %@", user.daysInARow];
    [self.tableView reloadData];
}
 */

- (IBAction)instructionsButtonPressed:(id)sender {
    UIViewController *helpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpVC"];
    UIWebView *webview = (UIWebView*)[helpVC.view viewWithTag:21];
    [webview loadHTMLString:kHelpRewards baseURL:nil];
    
    // show popover
    self.popover = [[FPPopoverController alloc] initWithViewController:helpVC];
    self.popover.tint = FPPopoverBlackTint;
    self.popover.contentSize = CGSizeMake(self.view.frame.size.width - 10, 250);
    [self.popover presentPopoverFromView:sender];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *rewardDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"RewardDetail"];
    [self.navigationController pushViewController:rewardDetail animated:YES];
    UIImageView *imageview = (UIImageView*)[rewardDetail.view viewWithTag:21];
    NSString *text = @"";
    UIImage *image;
    
    switch (indexPath.row) {
        case 0 : {
            text = @"Seven Days";
            image = [UIImage imageNamed:@"coin7.png"];
            break;
        }
        case 1 : {
            text = @"Thirty Days";
            image = [UIImage imageNamed:@"coin30.png"];
            break;
        }
        case 2 : {
            text = @"Sixty Days";
            image = [UIImage imageNamed:@"coin60.png"];
            break;
        }
        case 3 : {
            text = @"Ninety Days";
            image = [UIImage imageNamed:@"coin90.png"];
            break;
        }
        case 4 : {
            text = @"Six Months";
            image = [UIImage imageNamed:@"coin6month.png"];
            break;
        }
        case 5 : {
            text = @"Nine Months";
            image = [UIImage imageNamed:@"coin9month.png"];
            break;
        }
        case 6 : {
            text = @"One Year";
            image = [UIImage imageNamed:@"coinyear.png"];
            break;
        }
        case 7 : {
            text = @"One Year Certificate";
            image = [UIImage imageNamed:@"yearcert"];
        }
    }
    
    [imageview setImage:image];
    rewardDetail.navigationItem.title = text;
    
}
@end
