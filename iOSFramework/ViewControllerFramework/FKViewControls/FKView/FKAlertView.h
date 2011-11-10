//
//  FKAlertView.h
//  iOSFramework
//
//  Created by  on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKAlertView : UIAlertView{
    SEL didSelectOK;
    SEL didSelectCancel;
}

@property (nonatomic, assign) SEL didSelectOK;
@property (nonatomic, assign) SEL didSelectCancel;

- (void) show;

- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message 
           delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle;

@end
