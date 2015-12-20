//
//  myTableViewCell.m
//  Driving
//
//  Created by 黄欣 on 15/11/21.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "myTableViewCell.h"
#import "XMPPvCardTemp.h"
#import "XMPPTool.h"
#import "Accont.h"
@interface myTableViewCell ()
/**
 *  登录用户头像
 */

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation myTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //显示头像和微信号
    
    //从数据库里取用户信息
    
    //获取登录用户信息的，使用电子名片模块
    // 登录用户的电子名片信息
    XMPPvCardTemp *myvCard = [XMPPTool sharedXMPPTool].vCard.myvCardTemp;
    if (myvCard.photo) {
        self.avatarImageView.image = [UIImage imageWithData:myvCard.photo];
    }else{
        NSLog(@"无图");
    }
    NSString * s = [NSString stringWithFormat:@"用户名:%@",[Accont shareAccount].loginUser];
    self.nameLabel.text = s;
    self.nameLabel.font = [UIFont systemFontOfSize:13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
