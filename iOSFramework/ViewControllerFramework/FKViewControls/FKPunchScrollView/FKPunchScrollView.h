//
//  FKPunchScrollView.h
//  iOSFramework
//
//  Created by macadmin on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FKPunchScrollViewDataSource;
@protocol FKPunchScrollViewDelegate;

typedef enum {
    FKPunchScrollViewDirectionHorizontal = 0,
    FKPunchScrollViewDirectionVertical = 1,
} FKPunchScrollViewDirection;

@interface FKPunchScrollView : UIScrollView<UIScrollViewDelegate> {
	
	id <FKPunchScrollViewDataSource> punchDataSource_;
	id <FKPunchScrollViewDelegate> punchDelegate_;
	
	NSMutableSet		*recycledPages_;
    NSMutableSet		*visiblePages_;
	NSInteger			currentPage_;
	NSMutableArray		*indexPaths_;
	CGFloat				oldWidth_;
    CGFloat             pagePadding_;
    CGRect              originalFrame_;
    
    FKPunchScrollViewDirection direction_;
}



@property (nonatomic, assign) id <FKPunchScrollViewDataSource> punchDataSource;                  // Set the DataSource for the Scroll Suite
@property (nonatomic, assign) id <FKPunchScrollViewDelegate> punchDelegate;                      // set the Delegate for the Scroll Suite
@property (nonatomic, assign) CGFloat             pagePadding;                                 // Set the padding between pages  . Default is 10pt
@property (nonatomic, assign) FKPunchScrollViewDirection direction;                              // Set a Vertical or Horizontal Direction of the scrolling

@property (nonatomic, retain, getter=getCurrentPage) UIView *currentPage;                      //  Get the current visible Page
@property (nonatomic, retain, getter=getFirstPage) UIView *firstPage;                          //  Get the first Page
@property (nonatomic, retain, getter=getLastPage) UIView *lastPage;                            //  Get the last Page
@property (nonatomic, retain, getter=getCurrentIndexPath) NSIndexPath *currentIndexPath;       //  Get the current visible indexPath
@property (nonatomic, retain, getter=getLastIndexPath) NSIndexPath *lastIndexPath;             //  Get the last indexPath of the Scroll Suite




/*
 * Init Method for PunchScrollView
 *
 */
- (id)init; 
- (id)initWithFrame:(CGRect)aFrame;

/*
 * This Method returns a UIView which is in the Queue
 */
- (UIView *)dequeueRecycledPage;


/*
 * This Method reloads the data in the scrollView
 */
- (void)reloadData;


/*
 * This Method returns an UIView for a given indexPath
 *
 */
- (UIView*)pageForIndexPath:(NSIndexPath*)indexPath;

/*
 * Some Scrolling to page methods
 *
 */
- (void)scrollToIndexPath:(NSIndexPath*)indexPath animated:(BOOL)animated;
- (void)scrollToNextPage:(BOOL)animated;
- (void)scrollToPreviousPage:(BOOL)animated;

/*
 * Change the frame of the view
 *
 */
- (void)adjustFrame:(CGRect)aFrame;

@end



/* 
 *  PunchScrollView Delegate Methods
 *
 */

@protocol FKPunchScrollViewDelegate <NSObject>

@optional

- (void)punchScrollView:(FKPunchScrollView*)scrollView pageChanged:(NSIndexPath*)indexPath;

@end


/*
 * PunchScrollView DataSource Methods
 *
 */

@protocol FKPunchScrollViewDataSource <NSObject>

@required

- (NSInteger)punchscrollView:(FKPunchScrollView *)scrollView numberOfPagesInSection:(NSInteger)section;

- (UIView*)punchScrollView:(FKPunchScrollView*)scrollView viewForPageAtIndexPath:(NSIndexPath *)indexPath;


@optional

- (NSInteger)numberOfSectionsInPunchScrollView:(FKPunchScrollView *)scrollView; // Default is 1 if not implemented

@end
