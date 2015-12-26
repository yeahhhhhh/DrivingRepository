//
//  UIBarButtonItem+Extension.m
//  WB微博
//
//  Created by 黄欣 on 15/7/19.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemwithTarget:(id)target action:(SEL)action image:(NSString *)image Highimage:(NSString *)highimage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage  imageNamed: image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside ];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
