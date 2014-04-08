//
//  CSDonateViewController.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/22/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@interface CSDonateViewController : UIViewController <PayPalPaymentDelegate, UITextFieldDelegate>

@property(nonatomic, strong, readwrite) NSString *environment;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

- (IBAction)payButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end
