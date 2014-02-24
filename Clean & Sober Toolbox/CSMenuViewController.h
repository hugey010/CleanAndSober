//
//  CSMenuViewController.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSMenuViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *emailSwitch;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)psychologyButtonPressed:(id)sender;
- (IBAction)donateButtonPressed:(id)sender;
- (IBAction)disclaimerButtonPressed:(id)sender;
- (IBAction)notificationsValueChanged:(id)sender;
- (IBAction)emailValueChanged:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)psycologyButtonPressed:(id)sender;

@end
