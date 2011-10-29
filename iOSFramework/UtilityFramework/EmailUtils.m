//
//  EmailUtils.m
//  OOCLLite
//
//  Created by macadmin on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EmailUtils.h"
#import "Category.h"

@implementation EmailUtils

@synthesize delegate = _delegate;
@synthesize toRecipients = _toRecipients;
@synthesize ccRecipients = _ccRecipients;
@synthesize bccRecipients = _bccRecipients;
@synthesize mailContent = _mailContent;
@synthesize mailSubject = _mailSubject;
@synthesize requestViewController = _requestViewController;
@synthesize attachmentPath = _attachmentPath;
@synthesize attachmentFileName = _attachmentFileName;
@synthesize attachmentMIMEType = _attachmentMIMEType;
@synthesize attachmentExtension = _attachmentExtension;
@synthesize isHTML = _isHTML;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _isHTML = NO;
    }
    
    return self;
}

-(void) sendMail{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil){
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]){
			[self displayComposerSheet];
		}
		else{
			[self launchMailAppOnDevice];
		}
	}
	else{
		[self launchMailAppOnDevice];
	}
}

-(void) displayComposerSheet {
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject: _mailSubject];
	
	[picker setToRecipients:_toRecipients];
	[picker setCcRecipients:_ccRecipients];	
	[picker setBccRecipients:_bccRecipients];
	
	// Attach an image to the email
    if (_attachmentPath) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
//        NSData *myData = [NSData dataWithContentsOfFile:path];
//        [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
        NSString *path = [[NSBundle mainBundle] pathForResource:_attachmentPath ofType:_attachmentExtension];
        NSData *myData = [NSData dataWithContentsOfFile:path];
        [picker addAttachmentData:myData mimeType:_attachmentMIMEType fileName:_attachmentFileName];
    }
	
	// Fill out the email body text
	NSString *emailBody = _mailContent;
	[picker setMessageBody:emailBody isHTML:_isHTML];
	
    [_requestViewController presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void) mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
    NSString *returnMessage = nil;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			returnMessage = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			returnMessage = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			returnMessage = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			returnMessage = @"Result: failed";
			break;
		default:
			returnMessage = @"Result: not sent";
			break;
	}
    
    [_requestViewController dismissModalViewControllerAnimated:YES];
    [_delegate didSendEmailFinishedWithResult:returnMessage];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
    NSMutableArray *array = [NSMutableArray array];
    if (_mailSubject != nil) {
        [array addObject:[NSString stringWithFormat:@"&subject=%@", [_mailSubject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    }
    if (_mailContent != nil) {
        [array addObject:[NSString stringWithFormat:@"&body=%@", [_mailContent stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    }
    
    NSString *email = [NSString stringWithFormat:@"%@", _mailContent];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlString = [NSString stringWithFormat:@"mailto:%@?%@",
                           (email != nil ? email : @""),
                           [array componentsJoinedByString:@"&"]];
    
    NSURL *externURL = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:externURL])
        [[UIApplication sharedApplication] openURL:externURL];
}


#pragma mark -
#pragma mark Unload views

- (void) dealloc{
    [_toRecipients release];
    [_ccRecipients release];
    [_bccRecipients release];
    [_mailContent release];
    [_mailSubject release];
    [_attachmentPath release];
    [_attachmentFileName release];
    [_attachmentMIMEType release];
    [_attachmentExtension release];
    [super dealloc];
}

@end
