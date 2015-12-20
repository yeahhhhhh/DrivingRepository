//
//  NSString+Extention.m
//  WB微博
//
//  Created by 黄欣 on 15/9/17.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)
- (CGSize)sizeWithfont:(UIFont *)font //maxW:(CGFloat)maxW
{
    
    return [self sizeWithfont:font maxW:(MAXFLOAT)];
}
- (CGSize)sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW
{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    //    return [text sizeWithAttributes:attrs];
}
@end
