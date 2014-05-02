//
//  User.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 5/2/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * authtoken;
@property (nonatomic, retain) NSDate * dailyNotificationDate;
@property (nonatomic, retain) NSNumber * daysInARow;
@property (nonatomic, retain) NSString * disclaimerMessage;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * emailsOn;
@property (nonatomic, retain) NSString * helpMessage3;
@property (nonatomic, retain) NSString * helpMessageOne;
@property (nonatomic, retain) NSString * helpMessageTwo;
@property (nonatomic, retain) NSDate * lastLoginDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * psychologyMessage;

@end
