//
//  CSCategory.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 4/19/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CSCategory, CSContent;

@interface CSCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSOrderedSet *has_categories;
@property (nonatomic, retain) NSOrderedSet *has_contents;
@property (nonatomic, retain) CSCategory *in_category;
@end

@interface CSCategory (CoreDataGeneratedAccessors)

- (void)insertObject:(CSCategory *)value inHas_categoriesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHas_categoriesAtIndex:(NSUInteger)idx;
- (void)insertHas_categories:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHas_categoriesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHas_categoriesAtIndex:(NSUInteger)idx withObject:(CSCategory *)value;
- (void)replaceHas_categoriesAtIndexes:(NSIndexSet *)indexes withHas_categories:(NSArray *)values;
- (void)addHas_categoriesObject:(CSCategory *)value;
- (void)removeHas_categoriesObject:(CSCategory *)value;
- (void)addHas_categories:(NSOrderedSet *)values;
- (void)removeHas_categories:(NSOrderedSet *)values;
- (void)insertObject:(CSContent *)value inHas_contentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHas_contentsAtIndex:(NSUInteger)idx;
- (void)insertHas_contents:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHas_contentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHas_contentsAtIndex:(NSUInteger)idx withObject:(CSContent *)value;
- (void)replaceHas_contentsAtIndexes:(NSIndexSet *)indexes withHas_contents:(NSArray *)values;
- (void)addHas_contentsObject:(CSContent *)value;
- (void)removeHas_contentsObject:(CSContent *)value;
- (void)addHas_contents:(NSOrderedSet *)values;
- (void)removeHas_contents:(NSOrderedSet *)values;
@end
