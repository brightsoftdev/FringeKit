//
//  FKAlertView.m
//  iOSFramework
//
//  Created by  on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FKAlertView.h"

@implementation FKAlertView

@synthesize didSelectOK;
@synthesize didSelectCancel;

- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message 
            delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
{
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) show{
    
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
