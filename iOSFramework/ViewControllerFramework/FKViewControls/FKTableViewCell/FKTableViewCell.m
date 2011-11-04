//
//  FKTableViewCell.m
//  iOSFramework
//
//  Created by macadmin on 31/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#define DEFAULT_TITLE_FONT 14
#define DEFAULT_DETAIL_FONT 10
#define DEFAULT_NOTE_FONT 10
#define DEFAULT_CELL_WIDTH 320

#import "FKTableViewCell.h"

@implementation FKTableViewCell
@synthesize titleLabelSize = _titleLabelSize, detailLabelSize = _detailLabelSize, noteLabelSize = _noteLabelSize;
@synthesize width;


// we need to synthesize the two labels
@synthesize titleLabel=_titleLabel, 
detailLabel=_detailLabel, 
noteLabel=_noteLabel,
height = _height;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
		// we need a view to place our labels on.
		UIView *myContentView = self.contentView;
        [myContentView setBackgroundColor:[UIColor clearColor]];
        
        
        
        
        _titleLabel.font = [UIFont systemFontOfSize:DEFAULT_TITLE_FONT];
        _detailLabel.font = [UIFont systemFontOfSize:DEFAULT_DETAIL_FONT];
        _noteLabel.font = [UIFont systemFontOfSize:DEFAULT_NOTE_FONT];
        
		_titleLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] font:_titleLabel.font bold:YES];
		_titleLabel.textAlignment = UITextAlignmentLeft; // default
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
		[myContentView addSubview:_titleLabel];
		[_titleLabel release];
        
        _detailLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] font:_detailLabel.font bold:NO];
		_detailLabel.textAlignment = UITextAlignmentLeft; // default
        [_detailLabel setNumberOfLines:0];
        [_detailLabel setBackgroundColor:[UIColor clearColor]];
		[myContentView addSubview:_detailLabel];
		[_detailLabel release];
        
        _noteLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] font:_noteLabel.font bold:NO];
		_noteLabel.textAlignment = UITextAlignmentLeft; // default
		[myContentView addSubview:_noteLabel];
        [_noteLabel setNumberOfLines:0];
        [_noteLabel setBackgroundColor:[UIColor clearColor]];
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

-(void)setDataWithString:(NSString *)titleString setDetailWithString: (NSString *) detailString setNoteWithString: (NSString *) noteString setCellWidth: (CGFloat)cellWidth{
    //get the max length string to calculate the height
    //    _height = 80;
    width = cellWidth;
    
	_titleLabel.text = titleString;
	_detailLabel.text = detailString;
    _noteLabel.text = noteString;
    //    UIFont *font = [noteString getFileSystemRep]
    if (width == DEFAULT_CELL_WIDTH) {
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(width - 20, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width - 20, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
        _noteLabelSize = [noteString sizeWithFont:_noteLabel.font constrainedToSize:CGSizeMake(width - 20, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    }
    else{
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(width - 10, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width - 10, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
        _noteLabelSize = [noteString sizeWithFont:_noteLabel.font constrainedToSize:CGSizeMake(width - 10, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    }
    _height = _titleLabelSize.height + _detailLabelSize.height + _noteLabelSize.height + 16;
}

-(void)setDataWithString:(NSString *)titleString setDetailWithString: (NSString *) detailString setCellWidth: (CGFloat)cellWidth{
    width = cellWidth;
    
	_titleLabel.text = titleString;
	_detailLabel.text = detailString;
    _noteLabel.text = @"";
    if (width == DEFAULT_CELL_WIDTH) {
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(width - 20, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width - 20, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    }
    else{
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(width - 10, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width - 10, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    }
    _height = _titleLabelSize.height + _detailLabelSize.height + 12;
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
        if (width < DEFAULT_CELL_WIDTH) {
            boundsX = contentRect.origin.x + 10;
        }
        else{
            boundsX = contentRect.origin.x + (DEFAULT_CELL_WIDTH - width)/2 + 10;
        }
		CGRect frame;
        
        /*
		 Place the title label.
		 place the label whatever the current X is plus 10 pixels from the left
		 place the label 4 pixels from the top
		 make the label 200 pixels wide
		 make the label 20 pixels high
         */
        if (width == DEFAULT_CELL_WIDTH) {
            frame = CGRectMake(boundsX, 4, width - 20, _titleLabelSize.height);
            [_titleLabel setFrame:frame];
            
            // place the url label
            frame = CGRectMake(boundsX, _titleLabelSize.height + 8, width - 20, _detailLabelSize.height);
            [_detailLabel setFrame:frame];
            if (!([_noteLabel.text isEqualToString:@""])) {
                frame = CGRectMake(boundsX, _titleLabelSize.height + _detailLabelSize.height + 12, width - 20, _noteLabelSize.height);
                [_noteLabel setFrame:frame];
            }
        }
		else{
            frame = CGRectMake(boundsX, 4, width - 10, _titleLabelSize.height);
            [_titleLabel setFrame:frame];
            
            // place the url label
            frame = CGRectMake(boundsX, _titleLabelSize.height + 8, width - 10, _detailLabelSize.height);
            [_detailLabel setFrame:frame];
            if (!([_noteLabel.text isEqualToString:@""])) {
                frame = CGRectMake(boundsX, _titleLabelSize.height + _detailLabelSize.height + 12, width - 10, _noteLabelSize.height);
                [_noteLabel setFrame:frame];
            }
        }
	}
}

/*
 this function was taken from an XML example
 provided by Apple
 
 I can take no credit in this
 */
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor font:(UIFont *)font bold:(BOOL)bold
{
	/*
	 Create and configure a label.
	 */
    
    //    UIFont *font;
    //    if (bold) {
    //        font = [UIFont boldSystemFontOfSize:fontSize];
    //    } else {
    //        font = [UIFont systemFontOfSize:fontSize];
    //    }
    
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
	[_titleLabel release];
	[_detailLabel release];
    [_noteLabel release];
	[super dealloc];
}

@end
