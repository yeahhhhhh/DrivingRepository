//
//  FriendCell.m
//  Driving
//
//  Created by 黄欣 on 15/11/21.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "FriendCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation FriendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame       = CGRectMake(20, 12, 45, 45 );
    self.textLabel.frame       = CGRectMake(75, 15, 100, 20 );
    self.detailTextLabel.frame = CGRectMake(75, 35, 100, 20 );
    //圆角设置
    
    self.imageView.layer.cornerRadius = 8;//(值越大，角就越圆)
    
    self.imageView.layer.masksToBounds = YES;
    
    //边框宽度及颜色设置
    
//    [self.imageView.layer setBorderWidth:2];
//    
//    [self.imageView.layer setBorderColor:[UIColor blueColor]];  //设置边框为蓝色
//    
//    
    
    //自动适应,保持图片宽高比
    
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
