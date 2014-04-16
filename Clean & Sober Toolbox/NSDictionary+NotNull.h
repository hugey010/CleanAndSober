//
//  NSDictionary+NotNull.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 4/15/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NotNull)

-(id)objectForKeyNotNull:(id)aKey;

@end
