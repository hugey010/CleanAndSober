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
#import "CSContent.h"
#import "PayPalMobile.h"
#import <iAd/iAd.h>
#import "CSMenuViewController.h"
#import <Crashlytics/Crashlytics.h>

@implementation CSAppDelegate

#define MENU_PEEK_AMOUNT 280

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatedData) name:kUpdatedDataNotification object:nil];
    
    // you could technically use this if you had a json file with the proper format.
    // which you probably dont. so yeah.
    //[CSUtilities checkAndLoadInitialJSONFileIntoDatabase];
    
    // prepackaged a sqlite database with the project. swaps it to the runtime magicalrecord
    // location on first launch. for some static data. Constants.h contains others.
    [CSUtilities loadFromPremadeDatabase];
    [CSUtilities updateUser];

    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AXputRBJLZnwcRnuIXkjgLde3hWk_DeC54PlR2X11TxcWeF0MY6AcA4NP7R6",
                                                           PayPalEnvironmentSandbox : @"AbsS7xCV4p_NtQnEUs07SSxR8sz5g2ad7HT9Sbwi7AQh4UHD4QnqE8yXs3fK"}];


    
    [self resetFirstView];
    [self style];
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    [self checkNotification:notification application:application];
    
//#ifndef DEBUG
    [Crashlytics startWithAPIKey:@"5190a69964a302d074951c8b1c02508a74a9ead9"];
//#endif

    return YES;
}

-(void)resetFirstView {
    // setup ecsliding view controller
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    self.slidingVC = (ECSlidingViewController*)self.window.rootViewController;
    UINavigationController *categoryNav = [sb instantiateViewControllerWithIdentifier:@"category_nav"];
    self.initialCatList = categoryNav.viewControllers[0];
    //[self.initialCatList loadInitialContent];
    
    categoryNav.view.layer.shadowOpacity = 0.75;
    categoryNav.view.layer.shadowRadius = 10.0f;
    categoryNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.menuNav = [sb instantiateViewControllerWithIdentifier:@"menu"];
    
    [self.slidingVC setTopViewController:categoryNav];
    [self.slidingVC setUnderRightViewController:self.menuNav];
    [self.slidingVC setAnchorLeftRevealAmount:MENU_PEEK_AMOUNT];
    [self.slidingVC setAnchorRightRevealAmount:MENU_PEEK_AMOUNT];
    self.slidingVC.underRightWidthLayout = ECFixedRevealWidth;

}

-(void)updatedData {
    
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resetFirstView];
    });
     */
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.slidingVC resetTopViewWithAnimations:nil onComplete:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self resetFirstView];
            });
        }];
    });
     */

     
        /*
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.slidingVC resetTopViewWithAnimations:nil onComplete:^{
                [self resetFirstView];
            }];

        });
    });
*/
}

-(void)style {
    [[UILabel appearanceWhenContainedIn:[UITableViewCell class], nil] setTextColor:COLOR_TEXT_CELL];
    
    // detect iphone or ipad
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[UILabel appearance] setFont:FONT_LABELS];
    } else {
        [[UILabel appearance] setFont:FONT_IPAD_LABELS];
    }

    [[UITextView appearance] setFont:FONT_LABELS];
    [[UIButton appearance] setTitleColor:COLOR_BUTTONS forState:UIControlStateNormal];
    [[UISwitch appearance] setTintColor:COLOR_SWITCH];
    [[UISwitch appearance] setOnTintColor:COLOR_SWITCH];
    
    // special for back button appearance
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                COLOR_BUTTONS ,NSForegroundColorAttributeName,
                                nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:COLOR_BUTTONS];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor blackColor]];
    
    [[UITableView appearance] setBackgroundColor:kCOLOR_BLUE_TRANSLUCENT];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    
    [[ADBannerView appearance] setBackgroundColor:[UIColor clearColor]];
    
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor blackColor]];
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    
    [[UILabel appearanceWhenContainedIn:[UINavigationBar class], nil] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [self checkNotification:notification application:application];    
}

-(void)checkNotification:(UILocalNotification*)notification application:(UIApplication*)application {
    application.applicationIconBadgeNumber = 0;

    if (notification) {
        if ([notification.userInfo objectForKey:kCoinNotificationKey]) {
            // send to coin screen
            [self.slidingVC anchorTopViewTo:ECRight];
            [(CSMenuViewController*)self.menuNav.viewControllers[0] sendToRewards];
        
        } else if ([notification.userInfo objectForKey:kDailyMessageNotificationKey]) {
            CSContent *content = [CSUtilities randomContent];
            [self.initialCatList navigateToContentWithId:content.identifier];
        }
    }
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
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL), ^(void) {
        [CSUtilities checkVersionAndDownload];
    });
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
