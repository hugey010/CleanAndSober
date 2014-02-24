//
//  CSContentViewController.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/14/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSContent;

@interface CSContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

-(void)setupWithContent:(CSContent*)content;

@end
