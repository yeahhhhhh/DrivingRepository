//
//  StripTableViewCell.m
//  Driving
//
//  Created by 黄欣 on 15/12/6.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "StripTableViewCell.h"


@implementation StripTableViewCell

- (IBAction)touch:(UIButton *)sender {
//    NSLog(@"%ld",(long)sender.tag);
    if ([self.delegate respondsToSelector:@selector(PracticeDidClickButton:String:)]) {
        [self.delegate PracticeDidClickButton:sender.tag String:sender.titleLabel.text];
        NSLog(@"%@",sender.titleLabel.text);
    }
    
    
}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle =  UITableViewCellSelectionStyleNone;//无色

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
