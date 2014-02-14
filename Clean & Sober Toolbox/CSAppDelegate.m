//
//  CSAppDelegate.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/7/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSAppDelegate.h"
#import <ECSlidingViewController/ECSlidingViewController.h>

@implementation CSAppDelegate

#define MENU_PEEK_AMOUNT 280

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // setup coredata stack
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];

    // setup ecsliding view controller
    ECSlidingViewController *slidingVC = (ECSlidingViewController*)self.window.rootViewController;
    UINavigationController *categoryNav = [sb instantiateViewControllerWithIdentifier:@"category_list"];
    UIViewController *menuVC = [sb instantiateViewControllerWithIdentifier:@"menu"];
    menuVC.view.layer.shadowOpacity = 0.75;
    menuVC.view.layer.shadowRadius = 10.0f;
    menuVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [slidingVC setTopViewController:categoryNav];
    [slidingVC setUnderRightViewController:menuVC];
    [slidingVC setAnchorLeftRevealAmount:MENU_PEEK_AMOUNT];
    [slidingVC setAnchorRightRevealAmount:MENU_PEEK_AMOUNT];
    slidingVC.underRightWidthLayout = ECFixedRevealWidth;
    
    return YES;
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
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
