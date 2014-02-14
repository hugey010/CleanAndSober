//
//  Category.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Content;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSOrderedSet *has_contents;
@property (nonatomic, retain) NSOrderedSet *has_categories;
@property (nonatomic, retain) Category *in_category;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)insertObject:(Content *)value inHas_contentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHas_contentsAtIndex:(NSUInteger)idx;
- (void)insertHas_contents:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHas_contentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHas_contentsAtIndex:(NSUInteger)idx withObject:(Content *)value;
- (void)replaceHas_contentsAtIndexes:(NSIndexSet *)indexes withHas_contents:(NSArray *)values;
- (void)addHas_contentsObject:(Content *)value;
- (void)removeHas_contentsObject:(Content *)value;
- (void)addHas_contents:(NSOrderedSet *)values;
- (void)removeHas_contents:(NSOrderedSet *)values;
- (void)insertObject:(Category *)value inHas_categoriesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHas_categoriesAtIndex:(NSUInteger)idx;
- (void)insertHas_categories:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHas_categoriesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHas_categoriesAtIndex:(NSUInteger)idx withObject:(Category *)value;
- (void)replaceHas_categoriesAtIndexes:(NSIndexSet *)indexes withHas_categories:(NSArray *)values;
- (void)addHas_categoriesObject:(Category *)value;
- (void)removeHas_categoriesObject:(Category *)value;
- (void)addHas_categories:(NSOrderedSet *)values;
- (void)removeHas_categories:(NSOrderedSet *)values;
@end
