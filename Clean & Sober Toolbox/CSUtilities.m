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
    
    if (!CSUtilities.hasLoadedJson) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"result" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            NSLog(@"error loading json from file = %@", [error description]);
        }
        
        [CSUtilities parseJSONDictionaryIntoDatabase:result];
        [CSUtilities setHasLoadedJson:YES];
    }
    
    // perform version check and update data if necessary
    
}

+(void)parseJSONDictionaryIntoDatabase:(NSDictionary *)json {
    // check to see if database has been initialized with static data or previous downloads
    
    for (NSDictionary *topLevel in json[@"list"]) {
        
        [CSUtilities parseToplevelCSCategoryOrCSContentDictionaryIntoDatabase:topLevel];
    }
    
    // save
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    // TODO: send notification data has updated?
}

+(CSCategory*)parseCSCategoryFromDictionaryIntoDatabase:(NSDictionary*)cc inCategory:(CSCategory*)incat {
    CSCategory *category = [CSCategory MR_createEntity];
    category.identifier = cc[@"identifier"];
    category.type = cc[@"type"];
    category.title = cc[@"title"];
    category.in_category = incat;
    
    for (NSDictionary *subcat in cc[@"list"]) {
        if ([subcat[@"type"] isEqualToString:kCSContentType]) {
            [category addHas_contentsObject:[CSUtilities parseCSContentFromDictionaryIntoDatabase:subcat inCategory:category]];
            
        } else if ([subcat[@"type"] isEqualToString:kCSCategoryType]) {
            [category addHas_categoriesObject:[CSUtilities parseCSCategoryFromDictionaryIntoDatabase:subcat inCategory:category]];
        }
    }
    
    return category;
}

+(CSContent*)parseCSContentFromDictionaryIntoDatabase:(NSDictionary*)cc inCategory:(CSCategory*)incat {
    
    CSContent *content = [CSContent MR_createEntity];
    content.identifier = cc[@"identifier"];
    content.type = cc[@"type"];
    content.title = cc[@"title"];
    content.message = cc[@"message"];
    
    content.in_category = incat;
    
    return content;
}

+(void)parseToplevelCSCategoryOrCSContentDictionaryIntoDatabase:(NSDictionary*)cc {
    
    if ([cc[@"type"] isEqualToString:kCSContentType]) {
        [CSUtilities parseCSContentFromDictionaryIntoDatabase:cc inCategory:nil];
        
    } else if ([cc[@"type"] isEqualToString:kCSCategoryType]) {
        [CSUtilities parseCSCategoryFromDictionaryIntoDatabase:cc inCategory:nil];
        
    }

    
}

@end
