//
//  subjectVC1.m
//  Driving
//
//  Created by 黄欣 on 15/10/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "subjectVC1.h"
#import "AFNetworking.h"
#import "subjectOneModel.h"
#import "MJExtension.h"
#import "subjectvc1Model.h"
@interface subjectVC1 ()

@end

@implementation subjectVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //解决josn格式不标准问题
    mgr.requestSerializer  = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"4776393aee2c42c6a6a24da763ac142e";
    params[@"id"] = @"1";
    params[@"pn"] = @"1";
    params[@"rn"] = @"2";//题目数量
    // 3.发送请求
    
    [mgr GET:@"http://apis.haoservice.com/lifeservice/exam/query" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * responseObject1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功-%@", responseObject1);
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"请求失败-%@", error);
    }];
    
    
    
    
    
//    
//    [mgr GET:@"http://apis.haoservice.com/lifeservice/exam/query" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
//     {
//         NSDictionary * responseObject1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//         NSLog(@"请求成功-%@", responseObject1);
//         
//         
//         
//         
////        
//        
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         NSLog(@"请求失败-%@", error);
//         
//     }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text =[NSString stringWithFormat:@"ssss-%ld",(long)indexPath.row];
    
    return cell;
}


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
