//
//  CSUtilities.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSUtilities.h"
#import "CSContent.h"
#import "CSCategory.h"
#import "User.h"
#import <NSPersistentStore+MagicalRecord.h>
#import "NSDictionary+NotNull.h"
#import <NSManagedObjectContext+MagicalRecord.h>
#import <SVProgressHUD/SVProgressHUD.h>

#define kHasFirstLoadedDataKey @"has_loaded_static_json"
#define kLastVersionKey @"last_version"
#define kCSContentType @"content"
#define kCSCategoryType @"category"

#define kStructureFilePath @"structure.out"
#define kMessagesFilePath @"messages.out"

@implementation CSUtilities

static NSMutableSet *webRequests;

+(BOOL)hasLoadedJson {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def boolForKey:kHasFirstLoadedDataKey];
}

+(void)setHasLoadedJson:(BOOL)loaded {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:loaded forKey:kHasFirstLoadedDataKey];
    [def synchronize];
}

+(NSInteger)lastVersion {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def integerForKey:kLastVersionKey];
}

+(void)setLastVersion:(NSInteger)version {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setInteger:version forKey:kLastVersionKey];
    [def synchronize];
}

+(void)loadOfflineContent {
    [CSUtilities resetLoad];
    
    // help
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *help = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [CSUtilities parseHelp:help];
    
    // disclaimer
    filePath = [[NSBundle mainBundle] pathForResource:@"disclaimer" ofType:@"json"];
    data = [NSData dataWithContentsOfFile:filePath];
    NSString *disclaimer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [CSUtilities parseDisclaimer:disclaimer];
    
    // about
    filePath = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"json"];
    data = [NSData dataWithContentsOfFile:filePath];
    NSString *psych = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [CSUtilities parsePsychology:psych];
    
    // messages
    filePath = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"json"];
    data = [NSData dataWithContentsOfFile:filePath];
    NSArray *messages = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    [CSUtilities parseMessages:messages inContext:context];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"json"];
    data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *structure = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [CSUtilities parseStructure:structure inContext:context];
}


+(void)loadFromPremadeDatabase {
    if (![CSUtilities hasLoadedJson]) {
        NSURL *defaultStore = [NSPersistentStore MR_defaultLocalStoreUrl];
        [[NSFileManager defaultManager] removeItemAtURL:defaultStore error:nil];
    }
    
    
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    [CSUtilities updateUser];
    
}

// This method is copied from one of MR's categories
+ (void) createPathToStoreFileIfNeccessary:(NSURL *)urlForStore {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *pathToStore = [urlForStore URLByDeletingLastPathComponent];
    
    NSError *error = nil;
    [fileManager createDirectoryAtPath:[pathToStore path] withIntermediateDirectories:YES attributes:nil error:&error];
}

+(void)updateUser {
    
    User *user = [User MR_findFirst];
    BOOL firstUser = NO;
    if (!user) {
        firstUser = YES;
        user = [User MR_createEntity];
        user.daysInARow = [NSNumber numberWithInt:1];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        user.lastLoginDate = [NSDate date];
        
        user.helpMessageOne = kHelpMessage1;
        user.helpMessageTwo = kHelpMessage2;
        user.helpMessage3 = kHelpMessage3;
    }
    if ([CSUtilities date:user.lastLoginDate isDifferentDay:[NSDate date]]) {
        user.daysInARow = [NSNumber numberWithInt:[user.daysInARow integerValue] + 1.0];
        
        // schedule local notification if necessary.
        
        if ([DAYS_FOR_COINS containsObject:user.daysInARow]) {
            UILocalNotification *not = [[UILocalNotification alloc] init];
            not.timeZone = [NSTimeZone defaultTimeZone];
            not.alertBody = [CSUtilities coinMessage:[user.daysInARow intValue]];
            not.fireDate = [CSUtilities dateInFutureAfterDays:1 fromDate:[NSDate date]];
            not.userInfo = @{kCoinNotificationKey : @1};
            [[UIApplication sharedApplication] scheduleLocalNotification:not];
        }
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    if (firstUser) {
        user.dailyNotificationDate = [NSDate date];
        [CSUtilities scheduleDailyMessageNotification:YES];
        
    } else if ([user.dailyNotificationDate compare:[NSDate dateWithTimeIntervalSince1970:0]] != NSOrderedSame) {
        [CSUtilities scheduleDailyMessageNotification:YES];
    }
}

+(NSString*)coinMessage:(int)days {
    
    switch (days) {
        case 6: {
            return [NSString stringWithFormat:@"You have earned a coin for 7 days of sobriety! %@", ENTER_APP_MESSAGE];
        }
        case 29 : {
            return [NSString stringWithFormat:@"You have earned a coin for 30 days of sobriety! %@", ENTER_APP_MESSAGE];
        }
        case 59 : {
            return [NSString stringWithFormat:@"You have earned a coin for 60 days of sobriety! %@", ENTER_APP_MESSAGE];
        }
        case 89 : {
            return [NSString stringWithFormat:@"You have earned a coin for 90 days of sobriety! %@", ENTER_APP_MESSAGE];
        }
        case 182 : {
            return [NSString stringWithFormat:@"You have earned a coin for 6 months of sobriety! %@", ENTER_APP_MESSAGE];
        }
        case 273 : {
            return [NSString stringWithFormat:@"You have earned a coin for 9 months of sobriety! %@", ENTER_APP_MESSAGE];
        }
        case 364 : {
            return [NSString stringWithFormat:@"You have earned a coin for 1 year of sobriety! %@", ENTER_APP_MESSAGE];
        }
    }
    
    return @"";
}

+(BOOL)date:(NSDate*)date1 isDifferentDay:(NSDate*)date2 {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps1 = [cal components:(NSMonthCalendarUnit| NSYearCalendarUnit | NSDayCalendarUnit)
                                      fromDate:date1];
    NSDateComponents *comps2 = [cal components:(NSMonthCalendarUnit| NSYearCalendarUnit | NSDayCalendarUnit)
                                      fromDate:date2];
    
    
    return  [comps1 day] != [comps2 day]
            || [comps1 month] != [comps2 month]
            || [comps1 year] != [comps2 year];
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}


+(NSDate*)dateInFutureAfterDays:(int)days fromDate:(NSDate*)date {
    return [date dateByAddingTimeInterval:60*60*24*days];
}

// this gets called a lot
+(void)scheduleDailyMessageNotification:(BOOL)on {
    User *user = [User MR_findFirst];
    
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    if (!on) {
        user.dailyNotificationDate = [NSDate dateWithTimeIntervalSince1970:0];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
    } else {
        NSTimeInterval oldstamp = [user.dailyNotificationDate timeIntervalSince1970];
        while (oldstamp < [[NSDate date] timeIntervalSince1970]) {
            user.dailyNotificationDate = [CSUtilities dateInFutureAfterDays:1 fromDate:user.dailyNotificationDate];
            oldstamp = [user.dailyNotificationDate timeIntervalSince1970];
        }
        
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        notif.fireDate = user.dailyNotificationDate;
        notif.repeatInterval = NSCalendarUnitDay;
        notif.alertBody = [NSString stringWithFormat:@"View your daily message. %@", ENTER_APP_MESSAGE];
        notif.userInfo = @{kDailyMessageNotificationKey : @1};
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
}

+(void)resetRandomContent {
    NSSet *emptySet = [NSSet set];
    NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:emptySet];

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:setData forKey:kUnusedContentIdentifiersDefaultsKey];
    [def synchronize];
}

+(NSSet*)setOfUnusedContentIdentifiers {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSData *setData = [def objectForKey:kUnusedContentIdentifiersDefaultsKey];
    NSSet *set = [NSKeyedUnarchiver unarchiveObjectWithData:setData];
    if (set && [set count] > 0) {
        return set;
    } else {
        NSMutableSet *mutSet = [[NSMutableSet alloc] init];
        NSArray *allContent = [CSContent MR_findAll];
        [mutSet addObjectsFromArray:[allContent valueForKey:@"identifier"]];
        return mutSet;
    }
    [def synchronize];
}

+(CSContent*)randomContent {
    NSSet *identifiers = [CSUtilities setOfUnusedContentIdentifiers];
    
    int randomIndex = arc4random() % [identifiers count];
    NSMutableArray *idArray = [[identifiers allObjects] mutableCopy];
    NSNumber *resultNumber = idArray[randomIndex];
    [idArray removeObject:resultNumber];
    
    // reset setofususedcontentidentifiers
    NSSet *newSet = [NSSet setWithArray:idArray];
    NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:newSet];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:setData forKey:kUnusedContentIdentifiersDefaultsKey];
    [def synchronize];
    
    CSContent *content = [CSContent MR_findFirstByAttribute:@"identifier" withValue:resultNumber];
    return content;
}

+(void)checkVersionAndDownload {
    // check version
    NSNumber *version = [NSNumber numberWithInteger:[CSUtilities lastVersion]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@version", kUrlBase];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    requestError = nil;
    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *result = [f numberFromString:responseString];
    
    NSLog(@"Version Check. Local: %@, Server: %@.", version, result);
    
    if ([result integerValue] != [version integerValue]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CSUtilities forceUpdateEverything];
            [CSUtilities setLastVersion:[result integerValue]];
        });
    } else {
        [CSUtilities forceUpdateEverything];
    }
}

+(void)forceUpdateEverything {
    
    if ([CSUtilities isNetworkAvailable]) {
        
        [CSUtilities resetLoad];
        
        NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];

        [CSContent MR_truncateAllInContext:context];
        [CSCategory MR_truncateAllInContext:context];
        
        [CSContent MR_deleteAllMatchingPredicate:TRUE_PREDICATE];
        [CSCategory MR_deleteAllMatchingPredicate:TRUE_PREDICATE];
        
        // update everything
        [CSUtilities updateHelp];
        [CSUtilities updateDisclaimer];
        [CSUtilities updatePsychology];
        
        [CSUtilities updateMessages:context];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedDataNotification object:nil];

    }
}

+(void)updateHelp {
    NSString *urlString = [NSString stringWithFormat:@"%@help.json", kUrlBase];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    if (!requestError) {
        requestError = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&requestError];
        
        [CSUtilities parseHelp:result];
        //NSLog(@"help 1: %@", user.helpMessageOne);
        //NSLog(@"help 2: %@", user.helpMessageTwo);
        //NSLog(@"help 3: %@", user.helpMessage3);
        

    } else {
        NSLog(@"Update help error: %@", [requestError description]);
        
        helpUpdated = YES;
        [CSUtilities notifiyIfDoneLoading];
    }

}

+(void)parseHelp:(NSDictionary*)result {
    User *user = [User MR_findFirst];
    user.helpMessageOne = [NSString stringWithFormat:@"%@", [result objectForKeyNotNull:@"help1"]];
    user.helpMessageTwo = [NSString stringWithFormat:@"%@", [result objectForKeyNotNull:@"help2"]];
    user.helpMessage3 = [NSString stringWithFormat:@"%@", [result objectForKeyNotNull:@"help3"]];
    helpUpdated = YES;
    [CSUtilities notifiyIfDoneLoading];
}

+(void)updateMessages:(NSManagedObjectContext*)context {
    NSString *urlString = [NSString stringWithFormat:@"%@messages.json", kUrlBase];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    if (!requestError) {
        requestError = nil;
        NSArray *result = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&requestError];
        
        [CSUtilities parseMessages:result inContext:context];
        [CSUtilities updateStructure:context];
        
    } else {
        NSLog(@"Update messages error: %@", [requestError description]);
        
        messagesUpdated = YES;
        [CSUtilities notifiyIfDoneLoading];
    }
}

+(void)parseMessages:(NSArray*)result inContext:(NSManagedObjectContext*)context {
    for (NSDictionary *m in result) {
        CSContent *content = [CSContent MR_findFirstByAttribute:@"identifier" withValue:[m objectForKeyNotNull:@"id"] inContext:context];
        if (!content) {
            content = [CSContent MR_createInContext:context];
        }
        content.identifier = [m objectForKeyNotNull:@"id"];
        content.title = [m objectForKeyNotNull:@"title"];
        content.todo = [m objectForKeyNotNull:@"todo"];
        content.message = [m objectForKeyNotNull:@"content"];
        content.rank = [m objectForKeyNotNull:@"rank"];
    }
    
    messagesUpdated = YES;
    [CSUtilities notifiyIfDoneLoading];
}

+(void)updateStructure:(NSManagedObjectContext*)context {
    NSString *urlString = [NSString stringWithFormat:@"%@categories.json", kUrlBase];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    if (!requestError) {
        requestError = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&requestError];

        [CSUtilities parseStructure:result inContext:context];

    } else {
        NSLog(@"Update structure error: %@", [requestError description]);
        structureUpdated = YES;
        [CSUtilities notifiyIfDoneLoading];
    }
}

+(void)parseStructure:(NSDictionary*)result inContext:(NSManagedObjectContext*)context {
    NSArray *toplevel = result[@"subcategories"];
    for (NSDictionary *c in toplevel) {
        [CSUtilities parseCSCategoryFromWebDictionaryIntoDatabase:c inCategory:nil withContext:context];
    }
    structureUpdated = YES;
    [CSUtilities notifiyIfDoneLoading];
}

+(CSCategory*)parseCSCategoryFromWebDictionaryIntoDatabase:(NSDictionary*)cc inCategory:(CSCategory*)incat withContext:(NSManagedObjectContext*)context {
    CSCategory *category = [CSCategory MR_findFirstByAttribute:@"identifier" withValue:[cc objectForKeyNotNull:@"id"] inContext:context];
    if (!category) {
        category = [CSCategory MR_createInContext:context];
    }
    category.identifier = [cc objectForKeyNotNull:@"id"];
    category.type = @"category";
    category.title = [cc objectForKeyNotNull:@"title"];
    category.rank = [cc objectForKeyNotNull:@"rank"];
    category.in_category = incat;
    
    // recursively add subcategories
    for (NSDictionary *subcat in [cc objectForKeyNotNull:@"subcategories"]) {
        [category addHas_categoriesObject:[CSUtilities parseCSCategoryFromWebDictionaryIntoDatabase:subcat inCategory:category withContext:context]];
    }
    
    // iteratively add messages
    for (NSNumber *messageId in [cc objectForKeyNotNull:@"messages"]) {
        CSContent *content = [CSContent MR_findFirstByAttribute:@"identifier" withValue:messageId inContext:context];
        [content addIn_categoryObject:category];
        [category addHas_contentsObject:content];
    }
    
    return category;
}

+(void)updateDisclaimer {
    NSString *urlString = [NSString stringWithFormat:@"%@disclaimer.json", kUrlBase];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    if (!requestError) {
        NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        
        [CSUtilities parseDisclaimer:responseString];
        
    } else {
        NSLog(@"Update disclaimer error: %@", [requestError description]);
        
        disclaimerUpdated = YES;
        [CSUtilities notifiyIfDoneLoading];
    }
}

+(void)parseDisclaimer:(NSString*)disclaimer {
    User *user = [User MR_findFirst];
    user.disclaimerMessage = disclaimer;
    
    disclaimerUpdated = YES;
    [CSUtilities notifiyIfDoneLoading];
}

+(void)updatePsychology {
    NSString *urlString = [NSString stringWithFormat:@"%@about.json", kUrlBase];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    if (!requestError) {
        NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        [CSUtilities parsePsychology:responseString];

    } else {
        NSLog(@"Update psychology error: %@", [requestError description]);
        psychologyUpdated = YES;
        [CSUtilities notifiyIfDoneLoading];
    }
}

+(void)parsePsychology:(NSString*)psychology {
    User *user = [User MR_findFirst];
    user.psychologyMessage = psychology;
    psychologyUpdated = YES;
    [CSUtilities notifiyIfDoneLoading];
}

// help, disclaimer, psychology, messages, structure
static BOOL helpUpdated = NO;
static BOOL disclaimerUpdated = NO;
static BOOL psychologyUpdated = NO;
static BOOL messagesUpdated = NO;
static BOOL structureUpdated = NO;

+(void)resetLoad {
    helpUpdated = NO;
    disclaimerUpdated = NO;
    psychologyUpdated = NO;
    messagesUpdated = NO;
    structureUpdated = NO;
}

+(void)notifiyIfDoneLoading {
    if (helpUpdated && disclaimerUpdated && psychologyUpdated && messagesUpdated && structureUpdated) {
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedDataNotification object:nil];
    }
}

+ (BOOL)isNetworkAvailable
{
    CFNetDiagnosticRef dReference;
    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);
    
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
    
    CFRelease (dReference);
    
    if ( status == kCFNetDiagnosticConnectionUp )
    {
        NSLog (@"Connection is Available");
        return YES;
    }
    else
    {
        NSLog (@"Connection is down");
        return NO;
    }
}

@end
