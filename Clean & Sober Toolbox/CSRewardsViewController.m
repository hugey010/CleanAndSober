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
    
    [self.rewardsButton setBackgroundColor:kCOLOR_VIEWS_2];
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
            text = @"7 days of sobreity";
            image = [UIImage imageNamed:@"coin7.png"];
            break;
        }
        case 1 : {
            text = @"30 days of sobreity";
            image = [UIImage imageNamed:@"coin30.png"];
            break;
        }
        case 2 : {
            text = @"60 days of sobreity";
            image = [UIImage imageNamed:@"coin60.png"];
            break;
        }
        case 3 : {
            text = @"90 days of sobreity";
            image = [UIImage imageNamed:@"coin90.png"];
            break;
        }
        case 4 : {
            text = @"6 months of sobreity";
            image = [UIImage imageNamed:@"coin6month.png"];
            break;
        }
        case 5 : {
            text = @"9 months of sobreity";
            image = [UIImage imageNamed:@"coin9month.png"];
            break;
        }
        case 6 : {
            text = @"1 year of sobreity";
            image = [UIImage imageNamed:@"coinyear.png"];
            break;
        }
        case 7 : {
            text = @"1 year cerfiticate";
            image = [UIImage imageNamed:@"yearcert"];
        }
    }
    
    iv.image = image;
    label.text = text;
    cell.userInteractionEnabled = NO;
    label.enabled = enabled;
    iv.alpha = enabled ? 1.0 : 0.5;
    
    return cell;
}

- (IBAction)resetButtonPressed:(id)sender {
    [User MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]];
    [CSUtilities updateUser];
    
    user = [User MR_findFirst];
    self.navigationItem.title = [NSString stringWithFormat:@"App Days: %@", user.daysInARow];
    [self.tableView reloadData];
}
@end
