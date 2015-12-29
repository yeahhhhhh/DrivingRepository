//
//  subjectVC0.h
//  Driving
//
//  Created by 黄欣 on 15/10/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"
@interface subjectVC0 : UITableViewController
/**
 *  测试类型，rand：随机测试（随机100个题目），order：顺序测试
 */
@property (nonatomic , copy) NSString *testType;

@property(nonatomic , strong)NSString *string;
@end
