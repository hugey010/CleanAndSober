//
//  CSAppDelegate.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/7/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "CSCategoryListController.h"

@interface CSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) ECSlidingViewController *slidingVC;
@property (nonatomic, strong) UINavigationController *menuNav;
@property (nonatomic, strong) CSCategoryListController *initialCatList;
@end
