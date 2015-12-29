//
//  foundLikeCarTableViewCell.m
//  Driving
//
//  Created by 黄欣 on 15/12/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "foundLikeCarTableViewCell.h"

@implementation foundLikeCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
    int j = 0;
    for (int i = 0; i<12; i++) {
        if (j>=0 && j<=3) {
            j = 0;
        }
        if (i >=4 && i<=7) {
             j = 60;
        }
        if (i>=8) {
            j = 120;
        }
        UIButton * imageButton = [[UIButton alloc]initWithFrame:CGRectMake(((i%4)*80)+10, j, 60, 40)];
        imageButton.tag = i;
        imageButton.backgroundColor = [UIColor colorWithRed:(i*20)/255.0 green:(i*50)/255.0 blue:(i*20)/255.0 alpha:1.0];
        [self addSubview:imageButton];
        [imageButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(((i%4)*80)+10, j+40, 60, 20)];
        lable.backgroundColor = [UIColor blueColor];
        [self addSubview:lable];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)touchButton:(UIButton *)button
{
    NSLog(@"%ld",(long)button.tag);  
}
@end
