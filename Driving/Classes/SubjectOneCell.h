//
//  SubjectOneCell.h
//  Driving
//
//  Created by 黄欣 on 15/10/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubjectOneFrame;
@interface SubjectOneCell : UITableViewCell
@property (nonatomic, strong)SubjectOneFrame * subjectOneFrame;
+ (instancetype)cellwithTableView:(UITableView *)tableView;
@end
