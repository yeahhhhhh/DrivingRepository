//
//  HomeViewController.m
//  Driving
//
//  Created by 黄欣 on 15/12/27.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "HomeViewController.h"
#import "YXTableViewController.h"
#import "SXTitleLable.h"
#import "HomeTableViewController.h"
@interface HomeViewController ()<UIScrollViewDelegate>
/// 标签的滚动label
@property (nonatomic,strong)  UIScrollView *smallScview;
/// 显示视图的滚动view
@property (nonatomic,strong)  UIScrollView *bigScview;
@property (strong, nonatomic)  UIScrollView *scrollView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIScrollView *smallScview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,60 , self.view.bounds.size.width, 35)];
    UIScrollView *bigScview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 95, self.view.bounds.size.width, self.view.bounds.size.height - 95)];
    
    [self.view addSubview:smallScview];
    [self.view addSubview:bigScview];
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    smallScview.showsHorizontalScrollIndicator = NO;
    smallScview.showsVerticalScrollIndicator = NO;
    bigScview.delegate = self;
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
//    bigScview.contentSize = CGSizeMake(contentX, 0);
    bigScview.pagingEnabled = YES;
    
    self.smallScview = smallScview;
    self.bigScview = bigScview;
    
    [self addController];
    [self addLable];
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScview.bounds;
    [self.bigScview addSubview:vc.view];
    SXTitleLable *lable = [self.smallScview.subviews firstObject];
    lable.scale = 1.0;
    self.bigScview.showsHorizontalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 添加子控制器 */
- (void)addController
{
    YXTableViewController *vc1 = [[YXTableViewController alloc]init];
    vc1.title = @"报名";
    [self addChildViewController:vc1];
    HomeTableViewController *vc2 = [[HomeTableViewController alloc]init];
    vc2.title = @"科一";
    [self addChildViewController:vc2];
    
    YXTableViewController *vc3 = [[YXTableViewController alloc]init];
    vc3.title = @"科二";
    vc3.view.backgroundColor = [UIColor orangeColor];
    [self addChildViewController:vc3];
    
    YXTableViewController *vc4 = [[YXTableViewController alloc]init];
    vc4.title = @"科三";
    [self addChildViewController:vc4];
    
    YXTableViewController *vc5 = [[YXTableViewController alloc]init];
    vc5.title = @"科四";
    [self addChildViewController:vc5];
    YXTableViewController *vc6 = [[YXTableViewController alloc]init];
    vc6.title = @"拿本";
    [self addChildViewController:vc6];
}

/** 添加标题栏 */
- (void)addLable
{
    ///这里可以修改标签的个数
    for (int i = 0; i < 6; i++) {
        CGFloat lblW = self.view.frame.size.width/3;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        SXTitleLable *lbl1 = [[SXTitleLable alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text =vc.title;
        NSLog(@"%@",vc.title);
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont systemFontOfSize:19];
        [self.smallScview addSubview:lbl1];
        lbl1.tag = i;
//        lbl1.backgroundColor = [UIColor orangeColor];
        lbl1.userInteractionEnabled = YES;
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    CGFloat lblW = self.view.frame.size.width/4;
    self.smallScview.contentSize = CGSizeMake(lblW * 8, 0);
    
}
/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    SXTitleLable *titlelable = (SXTitleLable *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScview.frame.size.width;
    
    CGFloat offsetY = self.bigScview.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScview setContentOffset:offset animated:YES];
}





#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScview.frame.size.width;
    
    // 滚动标题栏
    SXTitleLable *titleLable = (SXTitleLable *)self.smallScview.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScview.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScview.contentSize.width - self.smallScview.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScview.contentOffset.y);
    [self.smallScview setContentOffset:offset animated:YES];
    // 添加控制器
    YXTableViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    [self.smallScview.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            SXTitleLable *temlabel = self.smallScview.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScview addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    SXTitleLable *labelLeft = self.smallScview.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScview.subviews.count) {
        SXTitleLable *labelRight = self.smallScview.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
