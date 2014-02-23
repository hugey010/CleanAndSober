//
//  User.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/22/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * notificationsOn;
@property (nonatomic, retain) NSNumber * emailsOn;
@property (nonatomic, retain) NSString * authtoken;
@property (nonatomic, retain) NSNumber * daysInARow;

@end
