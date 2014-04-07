//
//  Constants.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#ifndef Clean___Sober_Toolbox_Constants_h
#define Clean___Sober_Toolbox_Constants_h


#define kAppTitle @"Clean & Sober Toolbox"

// colors
#define kCOLOR_RED [UIColor colorWithRed:178.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0]
#define kCOLOR_GREY [UIColor colorWithRed:238.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0]

// color locations
#define COLOR_TEXT_CELL kCOLOR_RED
#define COLOR_BUTTONS kCOLOR_RED
#define COLOR_BACKGROUND kCOLOR_GREY
#define COLOR_CELL kCOLOR_GREY
#define COLOR_SWITCH kCOLOR_RED

// fonts
#define FONT_LABELS [UIFont fontWithName:@"Helvetica" size:17]


// notifications (coins and such)
#define ENTER_APP_MESSAGE @"Tap to enter."
#define DAYS_FOR_COINS @[@6, @29, @59, @89, @182, @273, @364]
#define kCoinNotificationKey @"coin_notification_key"
#define kDailyMessageDefaultsKey @"daily_message_user_defaults_key"
#define kDailyMessageNotificationKey @"daily_message_notification_key"
#define kUnusedContentIdentifiersDefaultsKey @"unused_content_identifiers_key"

// default help messages
#define kHelpMessage1 @"There are two ways to use this App. 1. You can enter a phrase or key words in the search engine. For example, if you are feeling like you are going to relapse because you are angry, simply type that phrase or something similar in the search engine. You can also enter the key words, relapse or anger, etc. A choice of  helpful message titles will appear. Touch a title of a message and read it. If that message doesn't help, go back to the list of titles and try another. Usually, the first message will change your thinking from addictive thinking to recovery thinking. You are encouraged to repeat to yourself the slogans found at the top of each message periodically for the rest of the day. . These slogan are commonly heard at 12 step meetings and other therapy sessions. OR 2. Touch one of the 8  questions that generally applies to your situation.  Then, on the screen that appears, touch another specific question. Finally, touch the title of a message you feel may be relevant. If that message doesn't help, go back and try another. Usually the first message will be enough to put you on the right track.You are encouraged to repeat the slogans found at the top of each message periodically for the rest of the day. Note: Sometimes you will notice that messages apply to everything in the category or they are repetitive but for a few changes which apply to a specific issue. This is intentional. Recovery depends upon constant reminders. We need to hear how a principle applies to more than one issue to stay clean and sober."
#define kHelpMessage2 @"Touch a question that may apply. Quickly scroll through the list to find one."
#define kHelpMessage3 @"Touch a title that speaks to you. Quickly scroll through the list to find one. After reading the message that appears, if you need more than one message to change your troubled thinking to healing thinking, touch another title for a new message."

#endif
