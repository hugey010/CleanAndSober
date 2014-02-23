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

@interface CSCategoryListController () {
    NSMutableArray *categories;
    NSMutableArray *contents;
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
}

-(void)loadInitialContent {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"in_category = nil"];
    categories = [[CSCategory MR_findAllSortedBy:@"title" ascending:NO withPredicate:predicate inContext:context] mutableCopy];
    contents = nil;
    
    [self.tableView reloadData];
    

}

-(void)loadListAt:(CSCategory*)cat {
    
    self.navigationItem.title = cat.title;
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"in_category.identifier = %d", [cat.identifier integerValue]];
    categories = [[CSCategory MR_findAllSortedBy:@"title" ascending:NO withPredicate:predicate inContext:context] mutableCopy];
    contents = [[CSContent MR_findAllSortedBy:@"title" ascending:NO withPredicate:predicate inContext:context] mutableCopy];
    
    [self.tableView reloadData];
}

-(void)searchAllContent:(NSString*)search {
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@ OR message CONTAINS[c] %@", search, search];
    NSArray *unfilteredContents = [CSContent MR_findAllSortedBy:@"title" ascending:NO withPredicate:predicate inContext:context];
    predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@", search];
    NSArray *unfilteredCategories = [CSCategory MR_findAllSortedBy:@"title" ascending:NO withPredicate:predicate inContext:context];
    
    categories = [NSMutableArray array];
    contents = [NSMutableArray array];
    
    // remove duplicates
    NSMutableSet *cTitles = [NSMutableSet set];
    for (CSCategory *c in unfilteredCategories) {
        if (![cTitles containsObject:c.title]) {
            [cTitles addObject:c.title];
            [categories addObject:c];
        }
    }
    cTitles = [NSMutableSet set];
    for (CSContent *c in unfilteredContents) {
        if (![cTitles containsObject:c.title]) {
            [cTitles addObject:c.title];
            [contents addObject:c];
        }
    }
    
    [self.tableView reloadData];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
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

#pragma mark - UISearchBar methods

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchAllContent:searchBar.text];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //NSLog(@"search text = %@", searchText);
    [self searchAllContent:searchText];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (originCategory) {
        [self loadListAt:originCategory];
    } else {
        [self loadInitialContent];
    }
}

@end
