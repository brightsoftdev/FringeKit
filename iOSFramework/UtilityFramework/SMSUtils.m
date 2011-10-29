//
//  SMSUtils.m
//  OOCLLite
//
//  Created by macadmin on 30/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SMSUtils.h"

@implementation SMSUtils

@synthesize delegate = _delegate;
@synthesize messageContent = _messageContent;
@synthesize requestViewController = _requestViewController;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void) sendSMS
{
	MFMessageComposeViewController *picker = [[[MFMessageComposeViewController alloc] init] autorelease];
	if(picker){
		picker.messageComposeDelegate = self;
		picker.navigationBar.tintColor = [UIColor blackColor];
		picker.body = _messageContent;
		picker.navigationBar.tintColor = [UIColor colorWithRed:(12/255.0f) green:(71/255.0f) blue:(157/255.0f) alpha:1];
		[_requestViewController presentModalViewController:picker animated:YES];
	}	
}

-(void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSString *returnMessage = nil;
    switch (result) {
		case MessageComposeResultCancelled:
			returnMessage = @"SMS sending canceled.";
			break;
		case MessageComposeResultSent:
			returnMessage = @"SMS sent successfully.";
			break;
		case MessageComposeResultFailed:
			returnMessage = @"SMS sending failed.";
			break;
		default:
			returnMessage = @"SMS sending failed.";
			break;
	}
	[_requestViewController dismissModalViewControllerAnimated:YES];
    [delegate didSendSMSFinishedWithResult:returnMessage ];
}

- (void) dealloc{
    [super dealloc];
}

@end
