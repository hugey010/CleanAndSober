//
//  CSUtilities.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "CSUtilities.h"

#define kHasFirstLoadedData @"has_loaded_static_json"
#define kContentType @"content"
#define kCategoryType @"category"

@implementation CSUtilities

+(BOOL)hasLoadedJson {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def boolForKey:kHasFirstLoadedData];
}

+(void)setHasLoadedJson:(BOOL)loaded {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:loaded forKey:kHasFirstLoadedData];
    [def synchronize];
}

+(void)checkAndLoadInitialJSONFileIntoDatabase {
    if (!CSUtilities.hasLoadedJson) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            NSLog(@"error loading json from file = %@", [error description]);
        }
        
        [CSUtilities parseJSONDictionaryIntoDatabase:result];
    }
}

+(void)parseJSONDictionaryIntoDatabase:(NSDictionary *)json {
    // check to see if database has been initialized with static data or previous downloads
    NSLog(@"result = %@", json);
    
    for (NSDictionary *topLevel in json[@"list"]) {
        if ([topLevel[@"type"] isEqualToString:kContentType]) {
            
        } else if ([topLevel[@"type"] isEqualToString:kCategoryType]) {
            
        }
    }
}

+(void)parseDictionaryIntoDatabase {
    
}

@end
