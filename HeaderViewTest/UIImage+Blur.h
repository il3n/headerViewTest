//
//  UIImage+Blur.h
//  HeaderViewTest
//
//  Created by lee on 16/8/20.
//  Copyright © 2016年 jeelun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)
+(UIImage *)blurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
