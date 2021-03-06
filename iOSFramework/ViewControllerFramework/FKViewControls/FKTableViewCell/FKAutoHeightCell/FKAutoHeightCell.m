//
//  FKAutoHeightCell.m
//  iOSFramework
//
//  Created by macadmin on 4/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#define DEFAULT_TITLE_FONT 18
#define DEFAULT_DETAIL_FONT 15
#define DEFAULT_NOTE_FONT 15
#define DEFAULT_CELL_WIDTH 320

#import "FKAutoHeightCell.h"

@implementation FKAutoHeightCell

@synthesize titleLabelSize = _titleLabelSize, 
detailLabelSize = _detailLabelSize, 
noteLabelSize = _noteLabelSize;

@synthesize titleLabel=_titleLabel, 
detailLabel=_detailLabel, 
noteLabel=_noteLabel,
height = _height;

@synthesize width = _width;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
		// we need a view to place our labels on.
		UIView *myContentView = self.contentView;
        [myContentView setBackgroundColor:[UIColor clearColor]];
        
		_titleLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] font:_titleLabel.font bold:YES];
		_titleLabel.textAlignment = UITextAlignmentLeft; // default
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        _titleLabel.textColor = [UIColor blackColor];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:DEFAULT_TITLE_FONT]];
		[myContentView addSubview:_titleLabel];
		[_titleLabel release];
        
        _detailLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] font:_detailLabel.font bold:NO];
		_detailLabel.textAlignment = UITextAlignmentLeft; // default
        [_detailLabel setNumberOfLines:0];
        [_detailLabel setBackgroundColor:[UIColor clearColor]];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont systemFontOfSize:DEFAULT_DETAIL_FONT];
		[myContentView addSubview:_detailLabel];
		[_detailLabel release];
        
        _noteLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] font:_noteLabel.font bold:NO];
		_noteLabel.textAlignment = UITextAlignmentLeft; // default
        [_noteLabel setNumberOfLines:0];
        [_noteLabel setBackgroundColor:[UIColor clearColor]];
        _noteLabel.textColor = [UIColor grayColor];
        [_noteLabel setFont:[UIFont italicSystemFontOfSize:15]];
        [myContentView addSubview:_noteLabel];
		[_noteLabel release];
	}
    _width = DEFAULT_CELL_WIDTH;
    
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
    if (_width > DEFAULT_CELL_WIDTH) {
        _width = DEFAULT_CELL_WIDTH;
    }
    
    if (([titleString isEqualToString:@""] || titleString == nil) && ([detailString isEqualToString:@""] || detailString == nil) && ([noteString isEqualToString:@""] || noteString == nil)) {
        _height = 44;
    }
    else{
        _titleLabel.text = titleString;
        _detailLabel.text = detailString;
        _noteLabel.text = noteString;
        
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(_width - 20, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(_width - 20, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _noteLabelSize = [noteString sizeWithFont:_noteLabel.font constrainedToSize:CGSizeMake(_width - 20, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _height = _titleLabelSize.height + _detailLabelSize.height + _noteLabelSize.height + 16;
    }
}

-(void)setDataWithString:(NSString *)titleString setDetailWithString: (NSString *) detailString{
    NSLog(@"_width:%f", _width);
    if (_width > DEFAULT_CELL_WIDTH) {
        _width = DEFAULT_CELL_WIDTH;
    }
    
    if (([titleString isEqualToString:@""] || titleString == nil) && ([detailString isEqualToString:@""] || detailString == nil)) {
        _height = 44;
    }
    else{
        _titleLabel.text = titleString;
        _detailLabel.text = detailString;
        _noteLabel.text = @"";
        
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(_width - 20, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(_width - 20, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _height = _titleLabelSize.height + _detailLabelSize.height + 12; 
    }
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
        CGFloat boundsX = 0;
        boundsX = contentRect.origin.x + 10;
		CGRect frame;
        
        /*
		 Place the title label.
		 place the label whatever the current X is plus 10 pixels from the left
		 place the label 4 pixels from the top
		 make the label 200 pixels wide
		 make the label 20 pixels high
         */
        frame = CGRectMake(boundsX, 4, _width - 20, _titleLabelSize.height);
        [_titleLabel setFrame:frame];
        
        // place the url label
        frame = CGRectMake(boundsX, _titleLabelSize.height + 8, _width - 20, _detailLabelSize.height);
        [_detailLabel setFrame:frame];
        if (!([_noteLabel.text isEqualToString:@""])) {
            frame = CGRectMake(boundsX, _titleLabelSize.height + _detailLabelSize.height + 12, _width - 20, _noteLabelSize.height);
            [_noteLabel setFrame:frame];
        }
	}
}

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor font:(UIFont *)font bold:(BOOL)bold
{
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
    //    [_noteLabel release];
	[super dealloc];
}

@end
