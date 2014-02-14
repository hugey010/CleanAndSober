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

@interface CSCategoryListController () {
    NSArray *categories;
    NSArray *contents;
    BOOL containsContent;
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
    categories = [CSCategory MR_findAllSortedBy:@"title" ascending:NO withPredicate:predicate inContext:context];
    contents = nil;
    
    [self.tableView reloadData];
}

-(void)loadAtContentAt:(NSInteger)identifier {
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"in_category = %d", identifier];
    categories = [CSCategory MR_findAllSortedBy:@"title" ascending:NO withPredicate:predicate inContext:context];
    contents = [CSContent MR_findAllSortedBy:@"title" ascending:NO withPredicate:predicate inContext:context];
    
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


@end
