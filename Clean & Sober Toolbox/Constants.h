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
#define kHelpMessage1 @"<div style=\"margin: 0px 0px 1.25px; padding: 0px;\">\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\"><span dir=\"ltr\">Two ways to use App:<\/span><\/div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\">&nbsp;<\/div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\"><span dir=\"ltr\">1.<strong>&nbsp;BEST WAY<\/strong>:&nbsp;&nbsp;Touch any questions on screens that appear. Then touch message title for your message. Repeat if necessary. <\/span><\/div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\">&nbsp;<\/div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\"><span dir=\"ltr\"><strong>OR<\/strong><\/span><\/div>\r\n\r\n<div style=\"margin: 0px 0px 1.25px; padding: 0px;\">&nbsp;<\/div>\r\n\r\n<div style=\"margin: 0px; padding: 0px;\"><span dir=\"ltr\">2.&nbsp;&nbsp;Touch menu, search and type <strong>one<\/strong>&nbsp;word in search engine that describes your current feelings. Examples of such words might be angry, fear, lonely,&nbsp;resentful,&nbsp;craving, urge, stress,&nbsp;<strong>and many more<\/strong>&hellip;Then&nbsp;touch a message.<\/span><\/div>\r\n<\/div>"
#define kHelpMessage2 @"<p>Touch a question that may apply. Quickly scroll through the list to find one.</p>"
#define kHelpMessage3 @"<p>Touch a title that speaks to you. Quickly scroll through the list to find one. After reading the message that appears, if you need more than one message to change your troubled thinking to healing thinking, touch another title for a new message.<\/p>\r\n2014-04-28 14:59:26.840 Sober Tool[9669:1303] disclaimer: <p>Unless otherwise indicated, the quotes and sayings in this App have no known specific author and are taken from research, the author&#39;s personal experience, training, and 12 step meetings. If anyone believes a quote or saying or any other mark or logo is not in the public domain, please contact the author immediately at the address provided. None of the information herein creates a counselor patient relationship or should substitute for any other forms of therapy. The author is not liable for any misinterpretations or any injuries claimed from the use of this App. This App provides educational information which may or may not benefit the user, and it is offered as one form of advice and not unequivocal instruction. Copyright 2014 by Blitzen, LLC. All rights reserved. No part of this App shall be reproduced, stored in a retrieval system, or transmitted by any means, electronic, mechanical, photocopying, recording, or otherwise, without written permission from the publisher. No patent, trademark, copyright or other liability is assumed with respect to the use of the information contained herein. Although every precaution has been taken in the preparation of this App, the publisher and author assume no responsibility for errors or omissions. Neither is any liability assumed for damages resulting from the use of information contained herein. The author and publisher specifically disclaim any responsibility for any liability, loss, or risk, personal or otherwise, which is incurred as a consequence, directly or indirectly, of the use and application of any of the contents of this App. This App has been registered with the United States Copyright Office.<\/p>"
#define kHelpRewards @"If you use the App tomorrow you will receive a congratulatory badge. If you use the App for 7 days, you will receive a 7 day Congratulatory badge. Similarly, if you use the App 30 days, 60 days, 90 days, 6 months, and one year, you will receive corresponding badges and a one year congratulatory certificate."

// default psychology and disclaimer
#define kPsychologyMessage @"Every addict has two brains: a \"dirty brain\" and a \"clean brain.\" The \"dirty brain\" wants to drink, use, or someway act out which ultimately causes trouble. The \"clean brain\" wants to stay clean and sober and free from trouble. This app causes us to use our \"clean brain\" particularly when our \"dirty brain\" is threatening. It substitutes the threatening thought with a truthful, rescuing thought. It changes our perception of a situation from something distressful to something manageable and even positive. It does this with unprecedented ease and speed. The result of changing messages is feeling better, beating cravings, and staying sober."

#define kDisclaimerMessage @"Unless otherwise indicated, the quotes and sayings in this App have no known specific author and are taken from research, the author's personal experience, training, and 12 step meetings. If anyone believes a quote or saying or any other mark or logo is not in the public domain, please contact the author immediately at the address provided. None of the information herein creates a counselor patient relationship or should substitute for any other forms of therapy. The author is not liable for any misinterpretations or any injuries claimed from the use of this App. This App provides educational information which may or may not benefit the user, and it is offered as one form of advice and not unequivocal instruction. Copyright 2014  by Clean and Sober Toolbox, Inc. All rights reserved. No part of this App shall be reproduced, stored in a retrieval system, or transmitted by any means, electronic, mechanical, photocopying, recording, or otherwise, without written permission from the publisher. No patent, trademark, copyright or other  liability is assumed with respect to the use of the information contained herein. Although every precaution has been taken in the preparation of this App, the publisher and author assume no responsibility for errors or omissions. Neither is any liability assumed for damages resulting from the use of information contained herein. The author and publisher specifically disclaim any responsibility for any liability, loss, or risk, personal or otherwise, which is incurred as a consequence, directly or indirectly, of the use and application of any of the contents of this App. This App has been registered with the United States Copyright Office."

#endif
