//
//  subjectVC0.m
//  Driving
//
//  Created by 黄欣 on 15/10/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "subjectVC0.h"
#import "AFNetworking.h"
#import "subjectOneModel.h"
#import "SubjectOneCell.h"
#import "SubjectOneFrame.h"
#import "MBProgressHUD+MJ.h"
@interface subjectVC0 ()
@property (nonatomic, strong) NSMutableArray *frameArray;//里面存放的SubjectOneFrame(模型)＋ 数据 每一个SubjectOneFrame(微博模型)代表一个问题

@property (nonatomic, strong) SubjectOneFrame *subjectOneFrame;
@end

@implementation subjectVC0
- (SubjectOneFrame *)subjectOneFrame
{
    if (!_subjectOneFrame)
    {
        self.subjectOneFrame = [[SubjectOneFrame alloc]init];
    }
    return _subjectOneFrame;
}

- (NSMutableArray *)frameArray
{
    if (!_frameArray)
    {
        self.frameArray = [[NSMutableArray alloc]init];
    }
    return _frameArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewQuestion];
    [MBProgressHUD showMessage:@" 正在玩命加载..."];
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - 加载科目题目数据
- (void) loadNewQuestion
{
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.拼接请求参数
    //key	string	是	您申请的appKey
    //subject	int	是	选择考试科目类型，1：科目1；4：科目4
    //model	string	是	驾照类型，可选择参数为：c1,c2,a1,a2,b1,b2；当subject=4时可省略
    //testType	string	否	测试类型，rand：随机测试（随机100个题目），order：顺序测试（所选科目全部题目）

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"fcb4b802789b39694b9c867cd74087e2";
    params[@"subject"] = @1;
    params[@"model"] = @"a2";
    params[@"testType"] = @"rand";

    // 3.发送请求
    [mgr GET:@"http://api2.juheapi.com/jztk/query" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {

         NSLog(@"请求成功-%@", responseObject);
         
         /**
          *  将json转换为plist文件
          */
//          dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_async(queue, ^{//异步
//            NSLog(@"1-----------%@",[NSThread currentThread]);
//            NSArray *array1 = [subjectOneModel objectArrayWithKeyValuesArray:responseObject[@"result"]];
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            dict[@"result"] = [subjectOneModel keyValuesArrayWithObjectArray:array1];
//            //          dict[@"total_number"] = responseObject[@"total_number"];
//            [dict writeToFile:@"/Users/huangxin/Desktop/huang.plist"  atomically:YES];
//           
//         });
         
         [MBProgressHUD hideHUD];
         NSArray *array = [subjectOneModel   objectArrayWithKeyValuesArray:responseObject[@"result"]];
         NSArray *newFreams = [self setFramesWithQuestion:array];//带有frame的数据
         [self.frameArray addObjectsFromArray:newFreams];
         
         
         [self.tableView reloadData];//刷新表格
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
         
     }];
}
- (NSArray *)setFramesWithQuestion:(NSArray *)ques
{
    NSMutableArray *frames = [NSMutableArray array];
    for (subjectOneModel *que in ques) {
        SubjectOneFrame *f = [[SubjectOneFrame alloc] init];
        f.datas = que;
        [frames addObject:f];
    }
    return frames;
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.frameArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString * ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.textLabel.text = @"asdf";
//    return cell;
    //获得cell
    
    SubjectOneCell *cell = [SubjectOneCell cellwithTableView:tableView];
//    self.subjectOneFrame.datas = self.array[indexPath.row];
    cell.subjectOneFrame = self.frameArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectOneFrame  *frame = self.frameArray[indexPath.row];
    return frame.cellhightF;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //获得cell
//    SubjectOneCell *cell = [SubjectOneCell cellwithTableView:tableView];
//    cell.datas = self.array[indexPath.row];
//}

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

@end
