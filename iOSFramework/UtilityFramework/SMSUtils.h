//
//  SMSUtils.h
//  OOCLLite
//
//  Created by macadmin on 30/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*
 
 SMSUtils *smsUtils = [[SMSUtils alloc] init];
 smsUtils.requestViewController = self;
 smsUtils.delegate = self;
 smsUtils.messageContent = ...;
 [smsUtils sendMessage];
 
 
*/
#import <MessageUI/MessageUI.h>

@protocol SMSUtilsDelegate<NSObject>

@optional

- (void) didSendSMSFinishedWithResult:(NSString *) result;

@end

@interface SMSUtils : NSObject<MFMessageComposeViewControllerDelegate>{
    id<SMSUtilsDelegate> delegate;
    NSString *messageContent;
    UIViewController *requestViewController;
}

@property (nonatomic, retain) UIViewController *requestViewController;
@property (nonatomic, copy) NSString *messageContent;
@property (nonatomic, assign) id<SMSUtilsDelegate> delegate;

- (void) sendSMS;

@end
