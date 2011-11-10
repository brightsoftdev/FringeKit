#import "FKTableViewCell.h"

@interface FKAutoHeightImageCell : FKTableViewCell{
	// adding the 2 labels we want to show in the cell
	UILabel *titleLabel;
    UILabel *detailLabel;
    UILabel *noteLabel;
    UIImageView *imageView;
    CGFloat height;
    
    CGSize titleLabelSize;
    CGSize detailLabelSize;
    CGSize noteLabelSize;
    CGFloat width;
    CGSize imageViewSize;  
    
    NSUInteger imageViewPosition;
}

typedef enum {
    UIImageViewPositionLeft = 0,
    UIImageViewPositionRight,
    UIImageViewPositionLeftTop,
    UIImageViewPositionRightTop,
}imageViewPosition;

// these are the functions we will create in the .m file

//-(void)setDataWithArray:(NSArray *)titleArray setDetailWithArray: (NSArray *) detailArray setNoteWithArray: (NSArray *) noteArray;

-(void)setDataWithString:(NSString *)titleString setDetailWithString: (NSString *) detailString setNoteWithString: (NSString *) noteString;


-(void)setDataWithString:(NSString *)titleString setDetailWithString: (NSString *) detailString;

// internal function to ease setting up label text
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor font:(UIFont *)font bold:(BOOL)bold;

// you should know what this is for by know
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *detailLabel;
@property (nonatomic, retain) UILabel *noteLabel;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize titleLabelSize;
@property (nonatomic, assign) CGSize detailLabelSize;
@property (nonatomic, assign) CGSize noteLabelSize;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGSize imageViewSize;
@property (nonatomic, assign) NSUInteger imageViewPosition;

@end
