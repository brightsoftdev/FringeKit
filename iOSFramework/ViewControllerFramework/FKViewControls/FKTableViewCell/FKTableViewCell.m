//
//  FKTableViewCell.m
//  iOSFramework
//
//  Created by macadmin on 31/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FKTableViewCell.h"

@implementation FKTableViewCell

// we need to synthesize the two labels
@synthesize titleLabel=_titleLabel, 
            detailLabel=_detailLabel, 
            noteLabel=_noteLabel,
            height = _height;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
		// we need a view to place our labels on.
		UIView *myContentView = self.contentView;
        
		_titleLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:14.0 bold:YES];
		_titleLabel.textAlignment = UITextAlignmentLeft; // default
		[myContentView addSubview:_titleLabel];
		[_titleLabel release];
        
        _detailLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		_detailLabel.textAlignment = UITextAlignmentLeft; // default
		[myContentView addSubview:_detailLabel];
		[_detailLabel release];
        
        _noteLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		_noteLabel.textAlignment = UITextAlignmentLeft; // default
		[myContentView addSubview:_noteLabel];
		[_noteLabel release];
        
        //[myContentView bringSubviewToFront:_titleLabel];
	}
    
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
	[super setSelected:selected animated:animated];
    
	// Configure the view for the selected state
}

/*
 this function gets in data from another area in the code
 you can see it takes a NSDictionary object
 it then will set the label text
 */
-(void)setDataWithArray:(NSArray *)titleArray setDetailWithArray: (NSArray *) detailArray setNoteWithArray: (NSArray *) noteArray {
    //get the max length array to calculate the height
    _height = 80;
	_titleLabel.text = [titleArray objectAtIndex:0];
	_detailLabel.text = [detailArray objectAtIndex:0];
    _noteLabel.text = [noteArray objectAtIndex:0];
}

-(void)setDataWithString:(NSString *)titleString setDetailWithString: (NSString *) detailString setNoteWithString: (NSString *) noteString {
    //get the max length string to calculate the height
    _height = 80;
	_titleLabel.text = titleString;
	_detailLabel.text = detailString;
    _noteLabel.text = noteString;
}

/*
 this function will layout the subviews for the cell
 if the cell is not in editing mode we want to position them
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
	// getting the cell size
    CGRect contentRect = self.contentView.bounds;
    
	// In this example we will never be editing, but this illustrates the appropriate pattern
    if (!self.editing) {
        
		// get the X pixel spot
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
        
        /*
		 Place the title label.
		 place the label whatever the current X is plus 10 pixels from the left
		 place the label 4 pixels from the top
		 make the label 200 pixels wide
		 make the label 20 pixels high
         */
		frame = CGRectMake(boundsX + 10, 4, 200, 20);
		[_titleLabel setFrame:frame];
        
		// place the url label
		frame = CGRectMake(boundsX + 10, 28, 200, 14);
		[_detailLabel setFrame:frame];
        
        frame = CGRectMake(boundsX + 10, 48, 200, 14);
		[_noteLabel setFrame:frame];
	}
}

/*
 this function was taken from an XML example
 provided by Apple
 
 I can take no credit in this
 */
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	/*
	 Create and configure a label.
	 */
    
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    /*
	 Views are drawn most efficiently when they are opaque and do not have a clear background, so set these defaults.  To show selection properly, however, the views need to be transparent (so that the selection color shows through).  This is handled in setSelected:animated:.
	 */
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
    
	return newLabel;
}

- (void)dealloc {
	// make sure you free the memory
//	[_titleLabel release];
//	[_detailLabel release];
//  [_noteLabel release];
	[super dealloc];
}

@end
