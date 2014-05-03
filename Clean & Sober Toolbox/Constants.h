//
//  Constants.h
//  Clean & Sober Toolbox
//
//  Created by Hugey on 2/13/14.
//  Copyright (c) 2014 Tyler Hugenberg. All rights reserved.
//

#ifndef Clean___Sober_Toolbox_Constants_h
#define Clean___Sober_Toolbox_Constants_h

#define kAppTitle @"Sober Tool"

#define kUrlBase @"http://www.sobertool.com/"

// colors
#define kCOLOR_RED [UIColor colorWithRed:178.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0]
#define kCOLOR_GREY [UIColor colorWithRed:238.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0]
#define kCOLOR_BLUE [UIColor colorWithRed:176.0/255.0 green:224.0/255.0 blue:255.0/255.0 alpha:1.0]
#define kCOLOR_BLUE_TRANSLUCENT [UIColor colorWithRed:176.0/255.0 green:224.0/255.0 blue:255.0/255.0 alpha:0.3]
#define kCOLOR_GREEN [UIColor colorWithRed:167.0/255.0 green:252.0/0.0 blue:0.0/255.0 alpha:1.0]
#define kCOLOR_GREEN_TRANSLUCENT [UIColor colorWithRed:167.0/255.0 green:252.0/255.0 blue:0.0/255.0 alpha:0.3]


#define kCOLOR_VIKING_BLUE [UIColor colorWithRed:79.0/255.0 green:213.0/255.0 blue:214.0/255.0 alpha:0.3]
#define kCOLOR_HEATH_RED [UIColor colorWithRed:64.0/255.0 green:13.0/255.0 blue:18.0/255.0 alpha:1.0]
#define kCOLOR_HEATH_RED_TRANSLUCENT [UIColor colorWithRed:164.0/255.0 green:13.0/255.0 blue:18.0/255.0 alpha:0.3]
#define kCOLOR_PALE_RED [UIColor colorWithRed:255.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0]

// color locations
#define COLOR_TEXT_CELL [UIColor blackColor]
//kCOLOR_HEATH_RED
#define COLOR_BUTTONS [UIColor blackColor]
//kCOLOR_HEATH_RED
#define COLOR_BACKGROUND kCOLOR_GREY
#define COLOR_CELL kCOLOR_BLUE
#define COLOR_SWITCH kCOLOR_HEATH_RED

#define kCOLOR_VIEWS_1 kCOLOR_PALE_RED
#define kCOLOR_VIEWS_2 kCOLOR_BLUE_TRANSLUCENT

// fonts
#define FONT_LABELS [UIFont fontWithName:@"Helvetica" size:17]
#define FONT_IPAD_LABELS [UIFont fontWithName:@"Helvetica" size:19]

// webview scaling html meta tag
#define kScaleMeta @"<meta name='viewport' content='initial-scale=1.0,maximum-scale=10.0'/>"


// notifications (coins and such)
#define ENTER_APP_MESSAGE @"Tap to enter."
#define DAYS_FOR_COINS @[@6, @29, @59, @89, @182, @273, @364, @364]
#define kCoinNotificationKey @"coin_notification_key"
#define kDailyMessageDefaultsKey @"daily_message_user_defaults_key"
#define kDailyMessageNotificationKey @"daily_message_notification_key"
#define kUnusedContentIdentifiersDefaultsKey @"unused_content_identifiers_key"

// default help messages
#define kHelpMessage1 @"<div style=\"margin: 0px 0px 1.25px; padding: 0px;\">\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\"><span dir=\"ltr\">Two ways to use App:</span></div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\"><span dir=\"ltr\">1.<strong>&nbsp;BEST WAY</strong>:&nbsp;&nbsp;Touch any questions on screens that appear. Then touch message title for your message. Repeat if necessary. </span></div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\"><span dir=\"ltr\"><strong>OR</strong></span></div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\">&nbsp;</div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\"><span dir=\"ltr\">2.&nbsp;&nbsp;Touch menu, search and type <strong>one</strong>&nbsp;word in search engine that describes your current feelings. Examples of such words might be angry, fear, lonely,&nbsp;resentful,&nbsp;craving, urge, stress,&nbsp;<strong>and many more</strong>&hellip;Then&nbsp;touch a message.</span></div>\r\n</div>"
#define kHelpMessage2 @"<p>Touch a question that may apply. Quickly scroll through the list to find one.</p>"
#define kHelpMessage3 @"<p>Touch a title that speaks to you. Quickly scroll through the list to find one. After reading the message that appears, if you need more than one message to change your troubled thinking to healing thinking, touch another title for a new message.</p>"
#define kHelpRewards @"Use the App for 7 days and you will receive a congratulatory badge. Same thing for 1, 2, 3, 6, and 9 months as well as a year. Also, after a year you will receive a congratulatory certificate! You will receive a notification when you receive a reward. After you earn rewards, touch them on this menu any time to see them."

// default psychology and disclaimer
#define kPsychologyMessage @"<p><strong>For</strong> <strong>Alcoholics</strong> <strong>and Addicts: <em>Free</em>, Immediate Help at Your Fingertips...</strong>Cravings attack unexpectedly. Sometimes you cannot reach anyone. But you can always&nbsp;touch your smart phone, tablet or click on this website, www.sobertool.com. <strong>If you get an urge to relapse, just&nbsp;touch this App and see a message to stop your craving.</strong> It will change your addictive thinking to recovery thinking. It also is a daily addition to your long term program with a rewards system to help you stay sober. This App could save your life!&nbsp;</p>\r\n\r\n\r\n\r\n<p><strong>This App is for you if you:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></p>\r\n\r\n\r\n\r\n<p>- think you may be an ALCOHOLIC or you may be ADDICTED to anything. Examples: alcohol, opiates, cocaine, methamphetamine, marijuana, sex, spending, gambling, food, nicotine, internet, etc.&nbsp;</p>\r\n\r\n\r\n\r\n<p>- are new to sobriety and need a fast and easy tool to beat cravings and frightening, out of control thoughts and feelings.</p>\r\n\r\n\r\n\r\n<p>- have been clean and sober for awhile but you still feel stress, want to change self defeating behaviors, and want to enjoy sobriety.</p>\r\n\r\n\r\n\r\n<p>- just completed inpatient or intensive outpatient treatment and want to stay sober.</p>\r\n\r\n\r\n\r\n<p>- want to stay sober for your family or friends or YOURSELF.</p>\r\n\r\n\r\n\r\n<p>- have struggled staying sober before.</p>\r\n\r\n\r\n\r\n<p>- want a tool to help you when you can&#39;t&nbsp;reach your&nbsp;Sponsor, support person, therapist, or get to a meeting.</p>\r\n\r\n\r\n\r\n<p>- want help keeping a strong, daily recovery program.</p>\r\n\r\n\r\n\r\n<p>- have experienced legal or any kind of trouble as a result of alcohol, drugs, or other addictive behaviors.</p>\r\n\r\n\r\n\r\n<p>- are being required to stay sober by an Employee Assistance Program, court system, professional assistance program, employer, school, licensing bureau, etc.</p>\r\n\r\n\r\n\r\n<p>-feel stuck or stressed in your recovery and you want to have fun while staying clean and sober.</p>\r\n\r\n\r\n\r\n<p>- keep making the same mistakes over and over again even though you are holding onto your sobriety and want to change these self defeating behaviors.</p>\r\n\r\n\r\n\r\n<p>- need help in making successful decisions that don&#39;t jeopardize your sobriety.</p>\r\n\r\n\r\n\r\n<p><strong>This App is also extremely useful for treatment centers, hospitals, addiction counselors, psychologists, social workers, chemical dependency counselors, psychiatrists, 12 step sponsors and other therapists who need a resource for finding answers to common issues experienced by their patients.</strong></p>\r\n\r\n\r\n\r\n<p>This free App is based on proven techniques and authored by a Harvard educated, licensed chemical dependency counselor and internationally certified alcohol and drug counselor who personally has over 26 years of uninterrupted sobriety. Some of the materials in this App contain theories related to cognitive behavioral therapy, mindfulness training, 12 step practice, stress reduction techniques, and motivational enhancement therapy. It also contains slogans commonly heard at 12 step meetings and during other therapy sessions. This App is not a substitute for treatment but it is an important addition to it!</p>\r\n\r\n\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This app respects your privacy, does not require you to give any personal information, and has minimal app permissions! It will not invade your contact list.</p>\r\n\r\n\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This app is easy, fun and fast.&nbsp; It leads you to specific answers to specific problems you are currently experiencing and all you have to do is touch its prompts.&nbsp; It even has a reward system! You can also choose to receive a daily recovery message.&nbsp; It also has a Search Engine you can choose to find helpful answers to sobriety threatening issues.</p>\r\n\r\n\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;DISCLAIMER:&nbsp; None of the information in this App creates a counselor patient relationship or should substitute for any other forms of therapy. The User waives the right to make any claims against Author, Developer or any other party for any misinterpretations or any injuries claimed from the use of this App.</p>\r\n\r\n\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Remember, every addict has two brains: a &quot;dirty brain&quot; and a &quot;clean brain&quot;. The &quot;dirty brain&quot; wants to drink, use, or someway act out which ultimately causes trouble. The &quot;clean brain&quot; wants to stay clean and sober and free from trouble. This app causes us to use our &quot;clean brain&quot; particularly when &quot;feel good&quot; message. It substitutes the threatening thought with a truthful, rescuing thought. It changes our perception of a situation from something distressful to something manageable and even positive. It does this with unprecedented ease and speed. The result of changing messages is feeling better, beating cravings, and staying sober.</p>\r\n"

#define kDisclaimerMessage @"<p>Unless otherwise indicated, the quotes and sayings in this App have no known specific author and are taken from research, the author&#39;s personal experience, training, and 12 step meetings. If anyone believes a quote or saying or any other mark or logo is not in the public domain, please contact the author immediately at the address provided. None of the information herein creates a counselor patient relationship or should substitute for any other forms of therapy. The author is not liable for any misinterpretations or any injuries claimed from the use of this App. This App provides educational information which may or may not benefit the user, and it is offered as one form of advice and not unequivocal instruction. Copyright 2014 by Blitzen, LLC. All rights reserved. No part of this App shall be reproduced, stored in a retrieval system, or transmitted by any means, electronic, mechanical, photocopying, recording, or otherwise, without written permission from the publisher. No patent, trademark, copyright or other liability is assumed with respect to the use of the information contained herein. Although every precaution has been taken in the preparation of this App, the publisher and author assume no responsibility for errors or omissions. Neither is any liability assumed for damages resulting from the use of information contained herein. The author and publisher specifically disclaim any responsibility for any liability, loss, or risk, personal or otherwise, which is incurred as a consequence, directly or indirectly, of the use and application of any of the contents of this App. This App has been registered with the United States Copyright Office.</p>\r\n"

#endif
