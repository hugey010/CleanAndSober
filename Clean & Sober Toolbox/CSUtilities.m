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

#define kHasFirstLoadedDataKey @"has_loaded_static_json"
#define kLastVersionKey @"last_version"
#define kCSContentType @"content"
#define kCSCategoryType @"category"

@implementation CSUtilities

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

+(void)checkAndLoadInitialJSONFileIntoDatabase {
    [MagicalRecord setupAutoMigratingCoreDataStack];

    if (!CSUtilities.hasLoadedJson) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"newest_cleaned_data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            NSLog(@"error loading json from file = %@", [error description]);
        }
        
        [CSUtilities createInitialUser];
        
        [CSUtilities parseJSONDictionaryIntoDatabase:result];
        [CSUtilities setHasLoadedJson:YES];
    }
    
    // perform version check and update data if necessary
    
}

+(void)parseJSONDictionaryIntoDatabase:(NSDictionary *)json {
    // TODO: delete old database entries
    
    for (NSDictionary *message in json[@"messages"]) {
        CSContent *content = [CSContent MR_createEntity];
        content.identifier = message[@"identifier"];
        content.message = message[@"message"];
        content.todo = message[@"todo"];
        content.title = message[@"title"];
        content.type = @"content";
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    for (NSDictionary *topLevel in json[@"structure"][@"list"]) {
       
        [CSUtilities parseCSCategoryFromDictionaryIntoDatabase:topLevel inCategory:nil];
    }
    
    // save
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    // TODO: post notification data has updated?
}

+(CSCategory*)parseCSCategoryFromDictionaryIntoDatabase:(NSDictionary*)cc inCategory:(CSCategory*)incat {
    CSCategory *category = [CSCategory MR_createEntity];
    category.identifier = cc[@"identifier"];
    category.type = cc[@"type"];
    category.title = cc[@"title"];
    category.in_category = incat;
    
    for (NSDictionary *subcat in cc[@"list"]) {
        if ([subcat[@"type"] isEqualToString:kCSContentType]) {
            // fetch content with id and link relationship
            CSContent *content = [CSContent MR_findFirstByAttribute:@"identifier" withValue:subcat[@"identifier"]];
            [content addIn_categoryObject:category];
            NSMutableOrderedSet *oset = [category.has_contents mutableCopy];
            [oset addObject:content];
            category.has_contents = oset;
            
        } else if ([subcat[@"type"] isEqualToString:kCSCategoryType]) {
            NSMutableOrderedSet *oset = [category.has_categories mutableCopy];
            [oset addObject:[CSUtilities parseCSCategoryFromDictionaryIntoDatabase:subcat inCategory:category]];
            category.has_categories = oset;
        }
    }
    
    return category;
}

+(void)createInitialUser {
    User *user = [User MR_createEntity];
    user.notificationsOn = [NSNumber numberWithBool:YES];
    user.emailsOn = [NSNumber numberWithBool:NO];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+(void)loadFromPremadeDatabase {
    
    // Get the default store path, then add the name that MR uses for the store
    NSURL *defaultStorePath = [NSPersistentStore MR_defaultLocalStoreUrl];
    defaultStorePath = [[defaultStorePath URLByDeletingLastPathComponent] URLByAppendingPathComponent:[MagicalRecord defaultStoreName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[defaultStorePath path]]) {
        NSURL *seedPath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Clean & Sober Toolbox" ofType:@"sqlite"]];


        NSLog(@"Core data store does not yet exist at: %@. Attempting to copy from seed db %@.", [defaultStorePath path], [seedPath path]);
        
        // We must create the path first, or the copy will fail
        [self createPathToStoreFileIfNeccessary:defaultStorePath];
        
        NSError* err = nil;
        if (![fileManager copyItemAtURL:seedPath toURL:defaultStorePath error:&err]) {
            NSLog(@"Could not copy seed data 0. error: %@", err);
        }
        
        NSURL *seedPath1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Clean & Sober Toolbox" ofType:@"sqlite-wal"]];
        NSURL *destPathWAL = [[defaultStorePath URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Clean & Sober Toolbox.sqlite-wal"];
        err = nil;
        if (![fileManager copyItemAtURL:seedPath1 toURL:destPathWAL error:&err]) {
            NSLog(@"Could not copy seed data 1. error: %@", err);
        }
        
        NSURL *seedPath2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Clean & Sober Toolbox" ofType:@"sqlite-shm"]];
        NSURL *destPathSHM = [[defaultStorePath URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Clean & Sober Toolbox.sqlite-shm"];
        err = nil;
        if (![fileManager copyItemAtURL:seedPath2 toURL:destPathSHM error:&err]) {
            NSLog(@"Could not copy seed data 2. error: %@", err);
        }
        err = nil;
        
    }
    
    [MagicalRecord setupAutoMigratingCoreDataStack];
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
    if (!user) {
        user = [User MR_createEntity];
        user.streakStartDate = [NSDate date];
    } else if ([CSUtilities daysBetweenDate:user.streakStartDate andDate:[NSDate date]] >= DAYS_BEFORE_RESET) {
        user.streakStartDate = [NSDate date];
    }
    user.lastLoginDate = [NSDate date];
    user.daysInARow = [NSNumber numberWithInt:[CSUtilities daysBetweenDate:user.streakStartDate andDate:user.lastLoginDate] + 1];
    
    
    // TODO: need to alert or something so we can show an image
    switch ([user.daysInARow intValue]) {
        case 7:

            break;
            
        default:
            break;
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
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

@end
