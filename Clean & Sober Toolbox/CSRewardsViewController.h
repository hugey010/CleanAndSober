//
//  CSRewardsViewController.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 4/7/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSRewardsViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)resetButtonPressed:(id)sender;

@end
