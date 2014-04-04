//
//  CSMenuViewController.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;

- (IBAction)psychologyButtonPressed:(id)sender;
- (IBAction)donateButtonPressed:(id)sender;
- (IBAction)disclaimerButtonPressed:(id)sender;
- (IBAction)notificationsValueChanged:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)psycologyButtonPressed:(id)sender;

@end
