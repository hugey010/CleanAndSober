//
//  CSUtilities.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//



#import <Foundation/Foundation.h>

#define kUpdatedDataNotification @"updated_data_notification"

@class CSContent;

/**
 * Static class - don't instantiate it, jerk.
 */
@interface CSUtilities : NSObject

//+(void)parseJSONDictionaryIntoDatabase:(NSDictionary*)json;
//+(void)checkAndLoadInitialJSONFileIntoDatabase;
+(void)loadFromPremadeDatabase;

+(void)updateUser;
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
+(NSDate*)dateInFutureAfterDays:(int)days fromDate:(NSDate*)date;
+(void)scheduleDailyMessageNotification:(BOOL)on;
+(CSContent*)randomContent;

/**
 * Checks version against current and downloads new data if necessary.
 *
 * This method is synchronous, so call it off the main thread.
 */
+(void)checkVersionAndDownload;

@end
