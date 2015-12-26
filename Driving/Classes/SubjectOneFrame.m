//
//  SubjectOneFrame.m
//  Driving
//
//  Created by 黄欣 on 15/10/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "SubjectOneFrame.h"
#import "subjectOneModel.h"
#import "NSString+Extention.h"
@implementation SubjectOneFrame
- (void)setDatas:(subjectOneModel *)datas
{
    _datas = datas;
    /** 问题*/
    CGFloat questionLableX = HXCellBorderW;
    CGFloat questionLableY = HXCellBorderW;
    CGFloat maxW = [UIScreen mainScreen].bounds.size.width - 3 * HXCellBorderW;
    CGSize  questionLableSize = [datas.question sizeWithfont:HXquestionFont maxW:maxW];
    self.questionLableF = (CGRect){{questionLableX,questionLableY},questionLableSize};
    
    /**图片url */
    CGFloat itemViewY;
    CGFloat urlW = [UIScreen mainScreen].bounds.size.width;
    CGFloat urlw = [UIScreen mainScreen].bounds.size.width - 100;
    if (datas.url.length) {
        self.urlF = CGRectMake( (urlW - urlw)/2 ,CGRectGetMaxY(self.questionLableF) +HXCellBorderW ,urlw , 200);
        
        itemViewY = CGRectGetMaxY(self.urlF) + HXCellBorderW;
    }else{
        itemViewY = CGRectGetMaxY(self.questionLableF)+ HXCellBorderW;
    }
    
    /** 选项整体*/
    CGFloat itemMaxW = [UIScreen mainScreen].bounds.size.width - 4 * HXCellBorderW;
    CGFloat item1X = 2* HXCellBorderW;
    CGFloat item1Y = HXCellBorderW;
    CGSize  item1Size = [datas.item1 sizeWithfont:HXquestionFont maxW:itemMaxW];
    self.item1F = (CGRect){{item1X,item1Y},item1Size};
    
    
    CGFloat item2X = 2* HXCellBorderW;
    CGFloat item2Y = CGRectGetMaxY(self.item1F) + HXCellBorderW;
    CGSize  item2Size = [datas.item2 sizeWithfont:HXquestionFont maxW:itemMaxW];
    self.item2F = (CGRect){{item2X,item2Y},item2Size};
    
    CGFloat itemViewHeight;
    
    if (datas.item3.length) {
        CGFloat item3X = 2* HXCellBorderW;
        CGFloat item3Y = CGRectGetMaxY(self.item2F) + HXCellBorderW;
        CGSize  item3Size = [datas.item3 sizeWithfont:HXquestionFont maxW:itemMaxW];
        self.item3F = (CGRect){{item3X,item3Y},item3Size};
        
        CGFloat item4X = 2* HXCellBorderW;
        CGFloat item4Y = CGRectGetMaxY(self.item3F) + HXCellBorderW;
        CGSize  item4Size = [datas.item4 sizeWithfont:HXquestionFont maxW:itemMaxW];
        self.item4F = (CGRect){{item4X,item4Y},item4Size};
        
        itemViewHeight = CGRectGetMaxY(self.item4F) + HXCellBorderW;
        
    }else{
        itemViewHeight = CGRectGetMaxY(self.item2F) + HXCellBorderW;
    }
    
    CGFloat itemViewX = HXCellBorderW;
//    CGFloat itemViewY = CGRectGetMaxY(self.questionLableF);
    CGSize itemViewSize = CGSizeMake(maxW, itemViewHeight);
    
    self.itemViewF = (CGRect){{itemViewX,itemViewY},itemViewSize};
    
    /** 答案*/
    /** 问题*/
    CGFloat answerLableX = HXCellBorderW;
    CGFloat answerLableY = CGRectGetMaxY(self.itemViewF) + HXCellBorderW;
//    CGFloat maxW = [UIScreen mainScreen].bounds.size.width - 3 * HXCellBorderW;
    NSString *answerString = [NSString stringWithFormat:@"答案为选项%@,解析：%@",datas.answer,datas.explains];
    CGSize  answerLableSize = [answerString sizeWithfont:HXquestionFont maxW:maxW];
    self.answerLableF = (CGRect){{answerLableX,answerLableY},answerLableSize};
    
    self.cellhightF = CGRectGetMaxY(self.answerLableF) + HXCellBorderW;
}
@end
