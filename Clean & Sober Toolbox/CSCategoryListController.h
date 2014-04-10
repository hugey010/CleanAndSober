//
//  CSCategoryListController.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#imp

@class CSCategory;

@interface CSCategoryListController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)helpButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (nonatomic, strong) FPPopoverController *popover;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

-(void)loadInitialContent;
-(void)loadListAt:(CSCategory*)cat;
-(void)navigateToContentWithId:(NSNumber*)identifier;

@end
