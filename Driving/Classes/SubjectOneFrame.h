//
//  SubjectOneFrame.h
//  Driving
//
//  Created by 黄欣 on 15/10/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class subjectOneModel;

#define HXCellBorderW 10
//问题字体
#define HXquestionFont [UIFont systemFontOfSize:15]

//选项字体
#define HXItemFont [UIFont systemFontOfSize:12]

//内容字体
#define HXStatusCellContentFont [UIFont systemFontOfSize:15]

// 来源字体
#define HXStatusCellSourceFont [UIFont systemFontOfSize:12]

//转发内容字体
#define HXStatusCellretweetContentFont [UIFont systemFontOfSize:15]
@interface SubjectOneFrame : NSObject

@property (nonatomic, strong) subjectOneModel * datas;

/** 问题*/
@property (nonatomic, assign) CGRect questionLableF;

/** 答案*/
@property (nonatomic, assign) CGRect answerLableF;

/** id*/
@property (nonatomic, assign) CGRect idF;

/** 选项 整体*/
@property (nonatomic, assign) CGRect itemViewF;

/** 选项1*/
@property (nonatomic, assign) CGRect item1F;

/** 选项2*/
@property (nonatomic, assign) CGRect item2F;

/** 选项3*/
@property (nonatomic, assign) CGRect item3F;

/** 选项4*/
@property (nonatomic, assign) CGRect item4F;

/**答案解释 */
@property (nonatomic, assign) CGRect xplainsF;

/**图片url */
@property (nonatomic, assign) CGRect  urlF;

@property (nonatomic, assign) CGFloat  cellhightF;
@end
