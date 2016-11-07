//
//  CSDonateViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/22/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

@import ECSlidingViewController;
#import "Constants.h"
#import "CSDonateViewController.h"

@interface CSDonateViewController ()

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;


@end

@implementation CSDonateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Donate";
    
    self.textfield.inputAccessoryView = self.toolbar;
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = NO;
    _payPalConfig.languageOrLocale = @"en";
    _payPalConfig.merchantName = @"Clean and Sober Toolbox";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    self.environment = PayPalEnvironmentProduction;
    //self.environment = PayPalEnvironmentSandbox;
    
    [self.backgroundView setBackgroundColor:kCOLOR_VIEWS_2];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [PayPalMobile preconnectWithEnvironment:self.environment];
}

-(void)viewWillDisappear:(BOOL)animated {
    // TODO: fix this
//    [self.slidingViewController anchorTopViewTo:ECLeft];
    [super viewWillDisappear:animated];
}

#pragma mark PayPalPaymentDelegate methods

-(void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you for your donation!" message:completedPayment.shortDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)payButtonPressed:(id)sender {
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:self.textfield.text];
    payment.currencyCode = @"USD";
    payment.shortDescription = [NSString stringWithFormat:@"%@ Donation", kAppTitle];
    
    if (!payment.processable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Payment Amount" message:@"Please enter a valid payment amount." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        
    } else {
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc]
                                                              initWithPayment:payment
                                                              configuration:self.payPalConfig
                                                              delegate:self];
        [self.navigationController presentViewController:paymentViewController animated:YES completion:nil];
        // TODO: fix this
//        [self.slidingViewController resetTopView];
    }
}

- (IBAction)doneButtonPressed:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
