//
//  SubjectOneCell.m
//  Driving
//
//  Created by 黄欣 on 15/10/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "SubjectOneCell.h"
#import "SubjectOneFrame.h"
#import "subjectOneModel.h"
#import "RedioButtonView.h"
#import "UIImageView+WebCache.h"
@interface SubjectOneCell()

/**问题*/
@property (nonatomic, weak) UILabel* questionLable;

/** 选项整体*/
@property (nonatomic, weak) RedioButtonView * itemView;
/** 图片*/
@property (nonatomic, weak) UIImageView * urlView;
/**答案*/
@property (nonatomic, weak) UILabel* answerLable;
@end

@implementation SubjectOneCell

+ (instancetype)cellwithTableView:(UITableView *)tableView
{
    
    NSString *ID = @"cell";
    SubjectOneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (!cell)
    {
        cell= [[SubjectOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                 reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//选中cell 后使cell无颜色变化
        [self setupView];

    }
    return self;
}
- (void)setSubjectOneFrame:(SubjectOneFrame *)subjectOneFrame
{
    _subjectOneFrame = subjectOneFrame;
    
    subjectOneModel * datas = subjectOneFrame.datas;
    
    self.questionLable.frame = subjectOneFrame.questionLableF;
    self.questionLable.text = datas.question;
    if (datas.url.length) {
        
        self.urlView.frame = subjectOneFrame.urlF;
        [self.urlView sd_setImageWithURL:[NSURL URLWithString:datas.url] placeholderImage:nil];
        self.urlView.hidden = NO;
    }else{
        self.urlView.hidden = YES;//隐藏
    }
    
    
    self.itemView.datasFrame = subjectOneFrame;
    
    self.itemView.frame = subjectOneFrame.itemViewF;
    
    self.answerLable.frame = subjectOneFrame.answerLableF;
    NSString *answerString = [NSString stringWithFormat:@"答案为选项%@,解析：%@",datas.answer,datas.explains];
    self.answerLable.text = answerString;
    
    
}
- (void)setupView
{
    UILabel * questionLable = [[UILabel alloc]init];
    [self.contentView addSubview:questionLable];
    questionLable.font = HXquestionFont;
    questionLable.numberOfLines = 0;
    self.questionLable = questionLable;
    
    UIImageView *urlView = [[UIImageView alloc]init];
    [self.contentView addSubview:urlView];
    self.urlView = urlView;
    
    RedioButtonView * itemView = [[RedioButtonView alloc]init];
    [self.contentView addSubview:itemView];
    self.itemView = itemView;
    
    UILabel * answerLable = [[UILabel alloc]init];
    answerLable.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    [self.contentView addSubview:answerLable];
    answerLable.font = HXquestionFont;
    answerLable.numberOfLines = 0;
    self.answerLable = answerLable;
}

@end
