//
//  CSCategoryListController.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSCategoryListController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "CSCategory.h"
#import "CSContent.h"
#import "CSContentViewController.h"
#import "User.h"

#define kFirstHelpLoad @"first_help_load"

@interface CSCategoryListController () {
    NSArray *categories;
    NSArray *contents;
    BOOL containsContent;

    CSCategory *originCategory;
}

@end

@implementation CSCategoryListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    containsContent = NO;
    self.navigationItem.title = kAppTitle;

    [self.tableView reloadData];
    
    if ([self firstLoad]) {
        [self helpButtonPressed:self.helpButton];
    }
    
    self.searchView.backgroundColor = [UIColor clearColor];
    self.adBackgroundView.backgroundColor = kCOLOR_VIEWS_2;
}

-(BOOL)firstLoad {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    BOOL result = [[def objectForKey:kFirstHelpLoad] boolValue];
    [def setObject:@YES forKey:kFirstHelpLoad];
    [def synchronize];
    
    return !result;
}

-(void)loadInitialContent {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"in_category = nil"];
    categories = [[CSCategory MR_findAllWithPredicate:predicate inContext:context] mutableCopy];
    contents = nil;
    
    [self.tableView reloadData];
}

-(void)loadListAt:(CSCategory*)cat {
    
    self.navigationItem.title = cat.title;
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY in_category.identifier = %d", [cat.identifier integerValue]];
    categories = [[CSCategory MR_findAllWithPredicate:predicate inContext:context] mutableCopy];
    contents = [[CSContent MR_findAllWithPredicate:predicate inContext:context] mutableCopy];
    
    [self.tableView reloadData];
}

- (IBAction)helpButtonPressed:(id)sender {
    
    User *user = [User MR_findFirst];
    
    UIViewController *helpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpVC"];
    UILabel *label = (UILabel*)[helpVC.view viewWithTag:21];
    
    int stacksize = (int)[self.navigationController.viewControllers count];
    if (stacksize == 1) {
        // top level
        if (user.helpMessageOne) {
            label.text = user.helpMessageOne;
        } else {
            label.text = kHelpMessage1;
        }
        
    } else if (stacksize == 2) {
        if (user.helpMessageTwo) {
            label.text = user.helpMessageTwo;
        } else {
            label.text = kHelpMessage2;
        }
        
    } else {
        if (user.helpMessage3) {
            label.text = user.helpMessage3;
        } else {
            label.text = kHelpMessage3;
        }
    }
    
    // show popover
    self.popover = [[FPPopoverController alloc] initWithViewController:helpVC];
    self.popover.tint = FPPopoverBlackTint;
    NSStringDrawingContext *ctx = [NSStringDrawingContext new];
    NSAttributedString *aString = [[NSAttributedString alloc] initWithString:label.text];
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setAttributedText:aString];
    CGSize boxSize = CGSizeMake(self.view.frame.size.width - 10, self.view.frame.size.height - 100);
    CGRect textRect = [calculationView.text boundingRectWithSize:boxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:ctx];
    
    self.popover.contentSize = CGSizeMake(textRect.size.width, textRect.size.height + 80);

    [self.popover presentPopoverFromView:sender];
}

-(void)searchAllContent:(NSString*)search {
    
    
    NSArray *array = [search componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    
    NSMutableSet *newContent = [NSMutableSet set];
    for (NSString *keyword in array) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@ OR message CONTAINS[cd] %@ OR todo CONTAINS[cd] %@", keyword, keyword, keyword];
        
        [newContent addObjectsFromArray:[CSContent MR_findAllWithPredicate:predicate]];
    }
    
    contents = [newContent allObjects];
    
    categories = nil;
    [self.tableView reloadData];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

-(void)navigateToContentWithId:(NSNumber*)identifier {
    [self.slidingViewController resetTopView];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    CSContentViewController *contentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"content"];
    [self.navigationController pushViewController:contentVC animated:NO];
    
    CSContent *content = [CSContent MR_findFirstByAttribute:@"identifier" withValue:identifier];
    [contentVC setupWithContent:content];
}

- (IBAction)rewardsButtonPressed:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rewards"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadPreviousContent {
    if (originCategory) {
        [self loadListAt:originCategory];
    } else {
        [self loadInitialContent];
    }
}

#pragma mark - UITableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionCount = 0;
    if ([categories count] > 0) {
        sectionCount++;
    }
    if ([contents count] > 0) {
        sectionCount++;
    }
    
    return sectionCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && [contents count] > 0) {
        return [contents count];
    }
    return [categories count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"category_cell" forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel*)[cell viewWithTag:21];
    
    if (indexPath.section == 0 && [contents count] > 0) {
        CSContent *content = contents[indexPath.row];
        titleLabel.text = content.title;
        
    } else {
        CSCategory *category = categories[indexPath.row];
        titleLabel.text = category.title;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [contents count] > 0) {
        CSContentViewController *contentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"content"];
        [self.navigationController pushViewController:contentVC animated:YES];
        CSContent *content = contents[indexPath.row];
        [contentVC setupWithContent:content];

    } else {
        CSCategoryListController *listVC = [self.storyboard instantiateViewControllerWithIdentifier:@"category_list"];
        [self.navigationController pushViewController:listVC animated:YES];
        CSCategory *category = categories[indexPath.row];
        [listVC loadListAt:category];
    }
}

#pragma mark - ADBannerViewDelegate methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [banner setHidden:NO];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [banner setHidden:YES];
}

@end
