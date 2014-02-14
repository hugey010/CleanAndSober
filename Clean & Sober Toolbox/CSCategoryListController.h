//
//  CSCategoryListController.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSCategory;

@interface CSCategoryListController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (IBAction)menuButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void)loadInitialContent;
-(void)loadListAt:(CSCategory*)cat;

@end
