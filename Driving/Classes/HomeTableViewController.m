//
//  HomeTableViewController.m
//  Driving
//
//  Created by 黄欣 on 15/7/19.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HomeTableViewController.h"
#import "subjectVC0.h"
#import "subjectVC1.h"
#import "UIView+Extension.h"
//#import "StripTableViewCell.h"
#import "PracticeTableViewController.h"
 static long step = 0; //记录时钟动画调用次数
@interface HomeTableViewController ()<UIScrollViewDelegate>
{
    CADisplayLink   *_timer;            //定时器
    BOOL _isDraging; //当前是否正在拖拽
}
@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
//@property (nonatomic , strong)id  cell;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];                  
    self.tableView.tableFooterView = [[UIView alloc]init]; //删除多余空cell
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    UITableViewCell * cell;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    static NSString *ID = @"identifier";
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        UIScrollView * scrollView = [[UIScrollView alloc]init];
        self.scrollView = scrollView;
        scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 90);
        scrollView.contentSize = CGSizeMake(3 * scrollView.width, 0);//内容尺寸设置  设置滑动的区间 （3个屏幕宽度区间 上下没有滑动）
        [cell.contentView addSubview:scrollView];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *imageview = [[UIImageView alloc]init];
            imageview.size = scrollView.size;
            imageview.y = 0;
            imageview.x = i * imageview.width;
            NSString *name = [NSString stringWithFormat:@"text%d",i];
            imageview.image = [UIImage imageNamed:name];
            
            [scrollView addSubview:imageview];
            }
        scrollView.delegate = self;
        scrollView.bounces = NO;//关闭弹簧效果
        scrollView.pagingEnabled = YES;//分页效果
        scrollView.showsHorizontalScrollIndicator = NO;//关闭滚动条
    
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.numberOfPages = 3;
        //设置 橘红色 和 灰色 点
        pageControl.pageIndicatorTintColor = [UIColor colorWithRed:198/256.0 green:198/256.0 blue:198/256.0 alpha:1];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        //pageControl.userInteractionEnabled = NO;//
        pageControl.centerX = 290;
        pageControl.centerY = 80;
//        pageControl.width = 100;
        //    pageControl.height = 60; //可以不设置他的宽高
        
        [self.view addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 时钟动画
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
        [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        return cell;
        
    }
    if (indexPath.section == 1)
    {
        NSLog(@"bbbbbbbbb");
        StripTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell1)
        {
            [tableView registerNib:[UINib nibWithNibName:@"StripTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
            cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell1.delegate = self;
        }
        return cell1;
        
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
      
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"数据%ld", indexPath.row + 1];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    if (indexPath.section == 2) {
        NSString *demoClassString = [NSString stringWithFormat:@"subjectVC%ld", indexPath.row];
        
        [self.navigationController pushViewController:[NSClassFromString(demoClassString) new] animated:YES];
    }
    
}
#pragma mark - 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1)
    {
        return 60;
    }
    return 44;
}
#pragma mark - 设置间隔高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
//    if (section == 2) {
//        return 15;
//    }
//    return 15;
    return 5;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidScroll%@",NSStringFromCGPoint(scrollView.contentOffset));
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int) (page + 0.5);//设置四舍五入计算页码
    _isDraging = NO;
}
#pragma mark 时钟动画调用方法
- (void)update:(CADisplayLink *)timer
{
    step++;
    
    if ((step % 100 != 0) ) {
        return;
    }
    
    CGPoint offset = _scrollView.contentOffset;
    
    offset.x += 320;
    if (offset.x > 320 * 2) {
        offset.x = 0;
    }
    
    [_scrollView setContentOffset:offset animated:YES];
}
- (void)PracticeDidClickButton:(PracticeButtonType)buttonType String:(NSString *)string
{
    PracticeTableViewController *pc = [[PracticeTableViewController alloc]init];

    pc.string = string;
    

    
    
    [self.navigationController pushViewController:pc animated:YES];
}









@end
