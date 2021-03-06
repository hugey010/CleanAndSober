//
//  CSContentViewController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/14/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSContentViewController.h"
#import "CSContent.h"

@interface CSContentViewController () {
    BOOL viewLoaded;
    CSContent *cscontent;
}

@end

@implementation CSContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (cscontent) {
        viewLoaded = YES;
        [self setupWithContent:cscontent];
    }
    
    UIBarButtonItem *bbutton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(shareButtonPressed)];
    [bbutton setWidth:bbutton.width + 10];
    self.navigationItem.rightBarButtonItem = bbutton;
}

-(void)setupWithContent:(CSContent*)content {
    if (!viewLoaded) {
        cscontent = content;
        return;
    }
    self.navigationItem.title = @"Message";//content.title;
    [self.webview loadHTMLString:[NSString stringWithFormat:@"%@%@<br><br>%@", kScaleMeta, content.message, content.todo] baseURL:nil];
    [self.webview setBackgroundColor:[UIColor clearColor]];
    [self.webview setOpaque:NO];
    self.webview.scalesPageToFit = YES;
}

-(void)shareButtonPressed {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = self;
        [mailVC setSubject:cscontent.title];
        NSMutableString *message = [cscontent.message mutableCopy];
        if (cscontent.todo) {
            [message appendFormat:@"<br><br>%@", cscontent.todo];
        }
        [message appendFormat:@"<br><br>Sent from %@ mobile app.", kAppTitle];
        [mailVC setMessageBody:message isHTML:YES];
        [self presentViewController:mailVC animated:YES completion:nil];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable To Share" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate methods

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
