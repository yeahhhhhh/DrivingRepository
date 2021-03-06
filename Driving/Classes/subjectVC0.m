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
#import "Accont.h"
#import "RedioButtonView.h"
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.title =  [NSString stringWithFormat:@"%@练习",self.string] ;
    [MBProgressHUD showMessage:@" 正在玩命加载..."];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - 加载科目题目数据
- (void) loadNewQuestion
{
//    // 1.请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    
//    
//    
//    // 3.发送请求
//    [mgr GET:@"http://localhost:8080/ErHuo/getWantList.action" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
//     {
//         NSLog(@"发送请求%@",responseObject);
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         NSLog(@"请求失败-%@", error);
//         
//     }];
    
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
    params[@"model"] = [Accont shareAccount].divingType;
    NSLog(@"%@",[Accont shareAccount].divingType);
    params[@"testType"] = self.testType;
    NSLog(@"%@",self.testType);

    // 3.发送请求
    [mgr GET:@"http://api2.juheapi.com/jztk/query" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {

//         NSLog(@"请求成功-%@", responseObject);
         
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
    RedioButtonView *rb = [[RedioButtonView alloc]init];
    rb.indexs = (int)indexPath.row;
    cell.subjectOneFrame = self.frameArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectOneFrame  *frame = self.frameArray[indexPath.row];
    return frame.cellhightF;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
