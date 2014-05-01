//
//  CSRewardsViewController.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 4/7/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FPPopover/FPPopoverController.h>

@interface CSRewardsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FPPopoverController *popover;

- (IBAction)instructionsButtonPressed:(id)sender;

@end
