//
//  Content.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Content : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Category *in_category;

@end
