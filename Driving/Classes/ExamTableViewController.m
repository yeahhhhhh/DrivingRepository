//
//  ExamTableViewController.m
//  Driving
//
//  Created by 黄欣 on 15/7/19.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "ExamTableViewController.h"
#import "UIView+Extension.h"
#import "foundLikeCarTableViewCell.h"
@interface ExamTableViewController ()
@property (nonatomic ,strong) id cell;
@end

@implementation ExamTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init]; //删除多余空cell
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61/255.0 green:201/255.0 blue:106/255.0 alpha:1.0];//设置导航栏颜色
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    if (section == 0 || section == 1) {
        return 1;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.cell = cell;
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 80);
        scrollView.contentSize = CGSizeMake(2 * scrollView.width, 0);//内容尺寸设置  设置滑动的区间 （4个屏幕宽度区间 上下没有滑动）
        [cell.contentView addSubview:scrollView];
        
        for (int i = 0; i < 2; i++) {
            UIImageView *imageview = [[UIImageView alloc]init];
            imageview.size = scrollView.size;
            imageview.y = 0;
            imageview.x = i * imageview.width;
//            NSString *name = @"foundP0";
            imageview.image = [UIImage imageNamed:@" foundP0"];
            
            [scrollView addSubview:imageview];
        }
        scrollView.bounces = NO;//关闭弹簧效果
        scrollView.pagingEnabled = YES;//分页效果
        scrollView.showsHorizontalScrollIndicator = NO;//关闭滚动条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1)
    {
        foundLikeCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"foundLikeCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//            cell1.delegate = self;
        }
        self.cell = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        self.cell = cell;
        cell.textLabel.text = [NSString stringWithFormat:@"数据数据%ld", indexPath.row + 1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//选中cell后 不变色
        return cell;
    }
    
    return nil;
}


#pragma mark - 设置间隔高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1 || section ==2) {
        return 15;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1)
    {
        return 180;
    }
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"热门品牌"];
    if (section == 1) {
        return @"热门品牌";
    }
    return @"sdf";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    NSLog(@"%s",__func__);
}
@end
