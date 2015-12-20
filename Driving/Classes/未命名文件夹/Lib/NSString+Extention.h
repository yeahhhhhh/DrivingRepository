//
//  NSString+Extention.h
//  WB微博
//
//  Created by 黄欣 on 15/9/17.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@interface NSString (Extention)
- (CGSize)sizeWithfont:(UIFont *)font;
- (CGSize)sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW;
@end
