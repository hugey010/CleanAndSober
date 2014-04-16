//
//  NSDictionary+NotNull.m
//  Clean & Sober Toolbox
//
//  Created by Hugey on 4/15/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import "NSDictionary+NotNull.h"

@implementation NSDictionary (NotNull)

-(id)objectForKeyNotNull:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    return object;
}

@end
