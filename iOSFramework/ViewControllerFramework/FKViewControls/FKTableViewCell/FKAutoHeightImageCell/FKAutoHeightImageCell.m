//
//  FKAutoHeightImageCell.m
//  iOSFramework
//
//  Created by  on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FKAutoHeightImageCell.h"

#define DEFAULT_TITLE_FONT 18
#define DEFAULT_DETAIL_FONT 15
#define DEFAULT_NOTE_FONT 15
#define DEFAULT_CELL_WIDTH 320
#define DEFAULT_IMAGE_WIDTH 30
#define DEFAULT_IMAGE_HEIGHT 30
#define DEFAULT_IMAGE_MAX_WIDTH 120
#define DEFAULT_IMAGE_MAX_HEIGHT 120

@implementation FKAutoHeightImageCell

// we need to synthesize the two labels
@synthesize titleLabelSize = _titleLabelSize, 
detailLabelSize = _detailLabelSize, 
noteLabelSize = _noteLabelSize;

@synthesize imageView = _cellImageView;

@synthesize titleLabel=_titleLabel, 
detailLabel=_detailLabel, 
noteLabel=_noteLabel,
height = _height,
imageViewSize = _imageViewSize,
imageViewPosition = _imageViewPosition;

@synthesize width;

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
        
        _imageViewSize = CGSizeMake(DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT);
        _cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _imageViewSize.width, _imageViewSize.height)];
        _cellImageView.backgroundColor = [UIColor clearColor];
        [myContentView addSubview:_cellImageView];
        [_cellImageView release];
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
//-(void)setDataWithArray:(NSArray *)titleArray setDetailWithArray: (NSArray *) detailArray setNoteWithArray: (NSArray *) noteArray {
//    //get the max length array to calculate the height
//    _height = 80;
//	_titleLabel.text = [titleArray objectAtIndex:0];
//	_detailLabel.text = [detailArray objectAtIndex:0];
//    _noteLabel.text = [noteArray objectAtIndex:0];
//}

-(void)setDataWithString:(NSString *)titleString setDetailWithString: (NSString *) detailString setNoteWithString: (NSString *) noteString setCellWidth: (CGFloat)cellWidth{
    //get the max length string to calculate the height
    width = cellWidth;
    if (width > DEFAULT_CELL_WIDTH) {
        width = DEFAULT_CELL_WIDTH;
    }
    
    _titleLabel.text = titleString;
	_detailLabel.text = detailString;
    _noteLabel.text = noteString;
    
    if (_cellImageView.frame.size.width > DEFAULT_IMAGE_MAX_WIDTH) {
        _imageViewSize.width = DEFAULT_IMAGE_MAX_WIDTH;
    }
    else{
        _imageViewSize.width = _cellImageView.frame.size.width;
    }
    
    if (_imageViewPosition == UIImageViewPositionLeft || _imageViewPosition == UIImageViewPositionRight) {
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(width - 10 - _imageViewSize.width, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width - 10 - _imageViewSize.width, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _noteLabelSize = [noteString sizeWithFont:_noteLabel.font constrainedToSize:CGSizeMake(width - 10 - _imageViewSize.width, 2000) lineBreakMode:UILineBreakModeWordWrap];
        
        _height = _titleLabelSize.height + _detailLabelSize.height + _noteLabelSize.height + 16;
        
        if (_cellImageView.frame.size.height > _height) {
            _imageViewSize.height = _height;
        }
        else{
            _imageViewSize.height = _cellImageView.frame.size.height;
        }
    }
    else if(_imageViewPosition == UIImageViewPositionLeftTop || _imageViewPosition == UIImageViewPositionRightTop){
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(width - 10 - _imageViewSize.width, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width - 20, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _noteLabelSize = [noteString sizeWithFont:_noteLabel.font constrainedToSize:CGSizeMake(width - 20, 2000) lineBreakMode:UILineBreakModeWordWrap];
        if (_cellImageView.frame.size.height > DEFAULT_IMAGE_MAX_HEIGHT) {
            _imageViewSize.height = DEFAULT_IMAGE_MAX_HEIGHT;
        }
        else{
            _imageViewSize.height = _cellImageView.frame.size.height;
        }
        if (_imageViewSize.height > _titleLabelSize.height) {
            _height = _imageViewSize.height + _detailLabelSize.height + _noteLabelSize.height + 16;
        }
        else{
            _height = _titleLabelSize.height + _detailLabelSize.height + _noteLabelSize.height + 16;
        }
    }
}

-(void)setDataWithString:(NSString *)titleString setDetailWithString: (NSString *) detailString setCellWidth: (CGFloat)cellWidth{
    width = cellWidth;
    if (width > DEFAULT_CELL_WIDTH) {
        width = DEFAULT_CELL_WIDTH;
    }
    
    _titleLabel.text = titleString;
	_detailLabel.text = detailString;
    _noteLabel.text = @"";
    
    if (_cellImageView.frame.size.width > DEFAULT_IMAGE_MAX_WIDTH) {
        _imageViewSize.width = DEFAULT_IMAGE_MAX_WIDTH;
    }
    else{
        _imageViewSize.width = _cellImageView.frame.size.width;
    }
    
    if (_imageViewPosition == UIImageViewPositionLeft || _imageViewPosition == UIImageViewPositionRight) {
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(width - 10 - _imageViewSize.width, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width - 10 - _imageViewSize.width, 2000) lineBreakMode:UILineBreakModeWordWrap];
        
        _height = _titleLabelSize.height + _detailLabelSize.height + _noteLabelSize.height + 16;
        
        if (_cellImageView.frame.size.height > _height) {
            _imageViewSize.height = _height;
        }
        else{
            _imageViewSize.height = _cellImageView.frame.size.height;
        }
    }
    else if(_imageViewPosition == UIImageViewPositionLeftTop || _imageViewPosition == UIImageViewPositionRightTop){
        _titleLabelSize = [titleString sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(width - 10 - _imageViewSize.width, 2000) lineBreakMode:UILineBreakModeWordWrap];
        _detailLabelSize = [detailString sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width - 20, 2000) lineBreakMode:UILineBreakModeWordWrap];
        
        if (_cellImageView.frame.size.height > DEFAULT_IMAGE_MAX_HEIGHT) {
            _imageViewSize.height = DEFAULT_IMAGE_MAX_HEIGHT;
        }
        else{
            _imageViewSize.height = _cellImageView.frame.size.height;
        }
        if (_imageViewSize.height > _titleLabelSize.height) {
            _height = _imageViewSize.height + _detailLabelSize.height + _noteLabelSize.height + 16;
        }
        else{
            _height = _titleLabelSize.height + _detailLabelSize.height + _noteLabelSize.height + 16;
        }
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
        CGFloat boundsX = 0;
        CGRect frame;
        if (_imageViewPosition == UIImageViewPositionLeft || _imageViewPosition == UIImageViewPositionRight) {
            if (_imageViewPosition == UIImageViewPositionLeft) {
                boundsX = contentRect.origin.x + _imageViewSize.width;
            }
            else{
                boundsX = contentRect.origin.x + 10;
            }
            
            frame = CGRectMake(boundsX, 4, width - 10 - _imageViewSize.width, _titleLabelSize.height);
            [_titleLabel setFrame:frame];
            frame = CGRectMake(boundsX, _titleLabelSize.height + 8, width - 10 - _imageViewSize.width, _detailLabelSize.height);
            [_detailLabel setFrame:frame];
            if (!([_noteLabel.text isEqualToString:@""])) {
                frame = CGRectMake(boundsX, _titleLabelSize.height + _detailLabelSize.height + 12, width - 10 - _imageViewSize.width, _noteLabelSize.height);
                [_noteLabel setFrame:frame];
            }
            
            if (_imageViewPosition == UIImageViewPositionLeft) {
                frame = CGRectMake(0, (_height - _imageViewSize.height)/2, _imageViewSize.width, _imageViewSize.height);
            }
            else{
                frame = CGRectMake(width - _imageViewSize.width, (_height - _imageViewSize.height)/2, _imageViewSize.width, _imageViewSize.height);
            }
            [_cellImageView setFrame:frame];
        }
        else if(_imageViewPosition == UIImageViewPositionLeftTop || _imageViewPosition == UIImageViewPositionRightTop){
            boundsX = contentRect.origin.x;
            if (_imageViewPosition == UIImageViewPositionLeftTop) {
                frame = CGRectMake(boundsX + _imageViewSize.width, 4, width - 10 - _imageViewSize.width, _titleLabelSize.height); 
                [_titleLabel setFrame:frame];
                frame = CGRectMake(0, 0, _imageViewSize.width, _imageViewSize.height);
                [_cellImageView setFrame:frame];
            }
            else{
                frame = CGRectMake(boundsX + 10, 4, width - 10 - _imageViewSize.width, _titleLabelSize.height);
                [_titleLabel setFrame:frame];
                frame = CGRectMake(width - _imageViewSize.width, 0, _imageViewSize.width, _imageViewSize.height);
                [_cellImageView setFrame:frame];
            }
            if (_imageViewSize.height > _titleLabelSize.height) {
                frame = CGRectMake(boundsX + 10, _imageViewSize.height + 8, width - 20, _detailLabelSize.height);
                [_detailLabel setFrame:frame];
                if (!([_noteLabel.text isEqualToString:@""])) {
                    frame = CGRectMake(boundsX + 10, _imageViewSize.height + _detailLabelSize.height + 12, width - 20, _noteLabelSize.height);
                    [_noteLabel setFrame:frame];
                }
            }
            else{
                frame = CGRectMake(boundsX + 10, _titleLabelSize.height + 8, width - 20, _detailLabelSize.height);
                [_detailLabel setFrame:frame];
                if (!([_noteLabel.text isEqualToString:@""])) {
                    frame = CGRectMake(boundsX + 10, _titleLabelSize.height + _detailLabelSize.height + 12, width - 20, _noteLabelSize.height);
                    [_noteLabel setFrame:frame];
                }
            }
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
    //[_cellImageView release];
	[super dealloc];
}

@end
