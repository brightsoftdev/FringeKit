//
//  FKTableViewCell.h
//  iOSFramework
//
//  Created by macadmin on 31/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKTableViewCell : UITableViewCell{
    UILabel *titleLabel;
	UILabel *urlLabel;
}

// these are the functions we will create in the .m file

// gets the data from another class
-(void)setData:(NSDictionary *)dict;

// internal function to ease setting up label text
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

// you should know what this is for by know
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *urlLabel;

@end
