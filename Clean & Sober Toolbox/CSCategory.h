//
//  CSCategory.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 5/2/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CSCategory, CSContent;

@interface CSCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *has_categories;
@property (nonatomic, retain) NSSet *has_contents;
@property (nonatomic, retain) CSCategory *in_category;
@end

@interface CSCategory (CoreDataGeneratedAccessors)

- (void)addHas_categoriesObject:(CSCategory *)value;
- (void)removeHas_categoriesObject:(CSCategory *)value;
- (void)addHas_categories:(NSSet *)values;
- (void)removeHas_categories:(NSSet *)values;

- (void)addHas_contentsObject:(CSContent *)value;
- (void)removeHas_contentsObject:(CSContent *)value;
- (void)addHas_contents:(NSSet *)values;
- (void)removeHas_contents:(NSSet *)values;

@end
