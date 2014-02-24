//
//  CSUtilities.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//



#import <Foundation/Foundation.h>

/**
 * Static class - don't instantiate it, jerk.
 */
@interface CSUtilities : NSObject

+(void)parseJSONDictionaryIntoDatabase:(NSDictionary*)json;
+(void)checkAndLoadInitialJSONFileIntoDatabase;

@end
