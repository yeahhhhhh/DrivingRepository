//
//  SXTitleLable.m
//  85 - 网易滑动分页
//
//  Created by 黄欣 on 15/12/27.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "SXTitleLable.h"

@implementation SXTitleLable

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        
        self.scale = 0.0;
        
    }
    return self;
}

/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    NSLog(@"通过scale的改变改变多种参数%f",scale);
    self.textColor = [UIColor colorWithRed:scale green:0.5 blue:0.0 alpha:1];
    
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

@end
