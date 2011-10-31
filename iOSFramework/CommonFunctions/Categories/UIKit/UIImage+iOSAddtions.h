//
//  UIImage+iOSAddtions.h
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (iOSAddtions)

- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnail;
- (UIImage *)thumbnailWithWidth:(int)twidth height:(int)theight;
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
@end
