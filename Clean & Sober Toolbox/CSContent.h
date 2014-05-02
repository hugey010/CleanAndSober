//
//  CSContent.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 5/2/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CSCategory;

@interface CSContent : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * todo;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *in_category;
@end

@interface CSContent (CoreDataGeneratedAccessors)

- (void)addIn_categoryObject:(CSCategory *)value;
- (void)removeIn_categoryObject:(CSCategory *)value;
- (void)addIn_category:(NSSet *)values;
- (void)removeIn_category:(NSSet *)values;

@end
