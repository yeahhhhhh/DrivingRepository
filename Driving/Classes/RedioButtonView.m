//
//  RedioButtonView.m
//  RadioButton
//
//  Created by 黄欣 on 15/10/30.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "RedioButtonView.h"
#import "UIView+Extension.h"
@interface RedioButtonView()
//@property (nonatomic, strong) UILabel *questionText;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) ZYRadioButton *rb1;
@property (nonatomic, strong) ZYRadioButton *rb2;
@property (nonatomic, strong) ZYRadioButton *rb3;
@property (nonatomic, strong) ZYRadioButton *rb4;

@property (nonatomic, strong) SubjectOneFrame *f;
@end
@implementation RedioButtonView


- (void)setDatasFrame:(SubjectOneFrame *)datasFrame
{
    _datasFrame = datasFrame;
    
    
    self.label1.text = self.datasFrame.datas.item1;
    self.label1.frame = datasFrame.item1F;
    self.label1.font = HXquestionFont;
    
  
    self.label2.text = self.datasFrame.datas.item2;
    self.label2.frame = datasFrame.item2F;
    self.label2.font = HXquestionFont;
    
    
    self.label3.text = self.datasFrame.datas.item3;
    self.label3.frame = datasFrame.item3F;
    self.label3.font = HXquestionFont;
    
    
    
    self.label4.text = self.datasFrame.datas.item4;
    self.label4.frame = datasFrame.item4F;
    self.label4.font = HXquestionFont;
    
    //设置Frame
    CGFloat rb1X = datasFrame.item1F.origin.x - 20;
    CGFloat rb1Y = datasFrame.item1F.origin.y;
    self.rb1.frame = CGRectMake(rb1X,rb1Y,22,22);
    
    CGFloat rb2X = datasFrame.item2F.origin.x - 20;
    CGFloat rb2Y = datasFrame.item2F.origin.y;
    self.rb2.frame = CGRectMake(rb2X,rb2Y,22,22);
    
    
    if (self.datasFrame.datas.item3.length)
    {
        CGFloat rb3X = datasFrame.item3F.origin.x - 20;
        CGFloat rb3Y = datasFrame.item3F.origin.y;
        self.rb3.frame = CGRectMake(rb3X,rb3Y,22,22);
        
        CGFloat rb4X = datasFrame.item4F.origin.x - 20;
        CGFloat rb4Y = datasFrame.item4F.origin.y;
        self.rb4.frame = CGRectMake(rb4X,rb4Y,22,22);
        
        self.rb3.hidden = NO;//显示
        self.rb4.hidden = NO;
    }else{
        self.rb3.hidden = YES;//隐藏
        self.rb4.hidden =YES;
    }
    
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化UILabel并添加到之前的视图容器
        
//        UILabel *questionText = [[UILabel alloc] init];
//        questionText.numberOfLines = 0;
//        SubjectOneFrame *subjectOneFrame = [[SubjectOneFrame alloc]init];
//        self.questionText.frame = subjectOneFrame.questionLableF;
//        questionText.backgroundColor = [UIColor clearColor];
//        self.questionText = questionText;
//       
//        [self addSubview:questionText];
        //初始化单选按钮控件
        ZYRadioButton *rb1 = [[ZYRadioButton alloc] initWithGroupId:@"first group" index:0];
        ZYRadioButton *rb2 = [[ZYRadioButton alloc] initWithGroupId:@"first group" index:1];
        ZYRadioButton *rb3 = [[ZYRadioButton alloc] initWithGroupId:@"first group" index:2];
        ZYRadioButton *rb4 = [[ZYRadioButton alloc] initWithGroupId:@"first group" index:3];
        
        //添加到视图容器
        [self addSubview:rb1];
        [self addSubview:rb2];
        [self addSubview:rb3];
        [self addSubview:rb4];
        self.rb1 = rb1;
        self.rb2 = rb2;
        self.rb3 = rb3;
        self.rb4 = rb4;
        //初始化第一个单选按钮的UILabel
        
        UILabel *label1 =[[UILabel alloc] init];
        label1.backgroundColor = [UIColor clearColor];
        label1.numberOfLines = 0;
        self.label1 = label1;
        
        [self addSubview:label1];
        
        UILabel *label2 =[[UILabel alloc] init];
        label2.backgroundColor = [UIColor clearColor];
        label2.numberOfLines = 0;
        self.label2 = label2;
        [self addSubview:label2];
        
        UILabel *label3 =[[UILabel alloc] init];
        label3.backgroundColor = [UIColor clearColor];
        label3.numberOfLines = 0;
        self.label3 = label3;
        [self addSubview:label3];
        
        UILabel *label4 =[[UILabel alloc] init];
        label4.numberOfLines = 0;
        label4.backgroundColor = [UIColor clearColor];
        self.label4 = label4;
        [self addSubview:label4];
        
        
        //按照GroupId添加观察者
        [ZYRadioButton addObserverForGroupId:@"first group" observer:self];
    }
    return self;
}
//代理方法
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    NSLog(@"changed to %lu in %@",(unsigned long)index,groupId);
}
@end
