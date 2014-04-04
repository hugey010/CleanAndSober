//
//  CSAppDelegate.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/7/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSAppDelegate.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "CSUtilities.h"
#import "CSCategoryListController.h"
#import "CSMenuViewController.h"
#import "User.h"

@implementation CSAppDelegate

#define MENU_PEEK_AMOUNT 280

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // setup coredata stack
    //[CSUtilities loadFromPremadeDatabase];
    [CSUtilities checkAndLoadInitialJSONFileIntoDatabase];
    
    [CSUtilities updateUser];

    
    // detect iphone or ipad
    UIStoryboard *sb;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        sb = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    }

    // setup ecsliding view controller
    ECSlidingViewController *slidingVC = (ECSlidingViewController*)self.window.rootViewController;
    UINavigationController *categoryNav = [sb instantiateViewControllerWithIdentifier:@"category_nav"];
    CSCategoryListController *catList = categoryNav.viewControllers[0];
    [catList loadInitialContent];
    
    categoryNav.view.layer.shadowOpacity = 0.75;
    categoryNav.view.layer.shadowRadius = 10.0f;
    categoryNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    CSMenuViewController *menuVC = [sb instantiateViewControllerWithIdentifier:@"menu"];
    
    [slidingVC setTopViewController:categoryNav];
    [slidingVC setUnderRightViewController:menuVC];
    [slidingVC setAnchorLeftRevealAmount:MENU_PEEK_AMOUNT];
    [slidingVC setAnchorRightRevealAmount:MENU_PEEK_AMOUNT];
    slidingVC.underRightWidthLayout = ECFixedRevealWidth;
    
    [self style];
    
    UILocalNotification *localNotif = [launchOptions
                                       objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotif) {
        if ([localNotif.userInfo objectForKey:kCoinNotificationKey]) {
            application.applicationIconBadgeNumber = 0;
            // send to coin screen
            [slidingVC anchorTopViewTo:ECLeft];
            [menuVC sendToRewards];
            
        } else if ([localNotif.userInfo objectForKey:kDailyMessageNotificationKey]) {
            [catList navigateToContentWithId:[localNotif.userInfo objectForKey:kDailyMessageNotificationKey]];
            User *user = [User MR_findFirst];
            user.dailyNotificationDate = [CSUtilities dateInFutureAfterDays:1 fromDate:user.dailyNotificationDate];
        }
        
    }

    return YES;
}

-(void)style {
    [[UILabel appearanceWhenContainedIn:[UITableViewCell class], nil] setTextColor:COLOR_TEXT_CELL];
    [[UILabel appearance] setFont:FONT_LABELS];
    [[UIButton appearance] setTitleColor:COLOR_BUTTONS forState:UIControlStateNormal];
    [[UISwitch appearance] setTintColor:COLOR_SWITCH];
    [[UISwitch appearance] setOnTintColor:COLOR_SWITCH];
    
    // special for back button appearance
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                COLOR_BUTTONS ,UITextAttributeTextColor,
                                nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:COLOR_BUTTONS];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [CSUtilities updateUser];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //[MagicalRecord cleanUp];
}

@end
