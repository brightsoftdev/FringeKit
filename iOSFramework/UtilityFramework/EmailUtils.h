//
//  EmailUtils.h
//  OOCLLite
//
//  Created by macadmin on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*
 
 EmailUtils *emailUtils = [[EmailUtils alloc] init];
 emailUtils.requestViewController = self;
 emailUtils.delegate = self;
 [emailUtils sendMail];
 
*/

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@protocol EmailUtilsDelegate<NSObject>

@optional

- (void) didSendEmailFinishedWithResult:(NSString *) result;

@end

@interface EmailUtils : NSObject<MFMailComposeViewControllerDelegate>{
    id<EmailUtilsDelegate> delegate;
    NSArray *toRecipients;
    NSArray *ccRecipients;
    NSArray *bccRecipients;
    NSString *mailSubject;
    NSString *mailContent;
    UIViewController *requestViewController;
    NSString *attachmentPath;
    NSString *attachmentFileName;
    NSString *attachmentMIMEType;
    NSString *attachmentExtension;
    BOOL isHTML;
}

@property (nonatomic, assign) id<EmailUtilsDelegate> delegate;
@property (nonatomic, retain) NSArray *toRecipients;
@property (nonatomic, retain) NSArray *ccRecipients;
@property (nonatomic, retain) NSArray *bccRecipients;
@property (nonatomic, copy) NSString *mailSubject;
@property (nonatomic, copy) NSString *mailContent;
@property (nonatomic, copy) NSString *attachmentPath;
@property (nonatomic, copy) NSString *attachmentFileName;
@property (nonatomic, copy) NSString *attachmentMIMEType;
@property (nonatomic, copy) NSString *attachmentExtension;
@property (nonatomic, retain) UIViewController *requestViewController;
@property (nonatomic, assign) BOOL isHTML;

-(void) sendMail;
-(void) displayComposerSheet;
-(void) launchMailAppOnDevice;

@end
