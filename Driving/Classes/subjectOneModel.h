//
//  subjectOneModel.h
//  Driving
//
//  Created by 黄欣 on 15/10/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface subjectOneModel : NSObject
//
///** id*/
//@property (nonatomic, assign) NSUInteger  id;
///** 课程*/
//@property (nonatomic, copy) NSString *catalog;

/** 问题*/
@property (nonatomic, copy) NSString *question;
/** 答案*/
@property (nonatomic, copy) NSString *answer;
/** id*/
@property (nonatomic, assign) NSUInteger  id;
/** 选项1*/
@property (nonatomic, copy) NSString *item1;
/** 选项2*/
@property (nonatomic, copy) NSString *item2;
/** 选项3*/
@property (nonatomic, copy) NSString *item3;
/** 选项4*/
@property (nonatomic, copy) NSString *item4;
/**答案解释 */
@property (nonatomic, copy) NSString *explains;
/**图片url */
@property (nonatomic, copy) NSString *url;


@end
