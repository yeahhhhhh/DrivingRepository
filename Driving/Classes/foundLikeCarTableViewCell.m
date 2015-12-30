//
//  foundLikeCarTableViewCell.m
//  Driving
//
//  Created by 黄欣 on 15/12/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "foundLikeCarTableViewCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
@interface foundLikeCarTableViewCell()
@property (nonatomic ,strong) NSMutableArray *mArray;

@end

@implementation foundLikeCarTableViewCell

//- (void)setModelArray:(NSMutableArray *)modelArray
//{
//    
//}
- (void)loadCarDatas
{
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 2.拼接请求参数
    /**
     *  action	string	是	固定值:getCarAllBrand
     key	    string	是	应用APPKEY(应用详细页查询)
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"d8631f1cfdc36a49163c783e51fc39ef";
    params[@"action"] = @"getCarAllBrand";
    
    // 3.发送请求
    [mgr GET:@"http://v.juhe.cn/carzone/series/query" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         
                  NSLog(@"请求成功-%@", responseObject);
         NSDictionary * resultDic = responseObject[@"result"];
         NSArray * detailArray = resultDic[@"detail"];
         NSArray *array = [foundLikeCarModel   objectArrayWithKeyValuesArray:detailArray];
         
         NSMutableArray * mArray = [[NSMutableArray alloc]init];
         for (foundLikeCarModel * f in array ) {
             [mArray addObject:f];
         }
         self.mArray = mArray;
         /**
          *  将json转换为plist文件
          */
         //          NSArray *array = [statusModle______ objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         //          NSMutableDictionary *dict = [NSMutableDictionary dictionary];
         //          dict[@"result"] = [foundLikeCarModel keyValuesArrayWithObjectArray:array];
         //          dict[@"total_number"] = responseObject[@"total_number"];
         //          [dict writeToFile:@"/Users/huangxin/Desktop/huang.plist"  atomically:YES];
         //         [self.tableView reloadData];//刷新表格
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
         
     }];
    
}
- (void)awakeFromNib { 
    // Initialization code
    
//    [self loadCarDatas];
    int j = 0;
    for (int i = 0; i<12; i++) {
        if (j>=0 && j<=3) {
            j = 0;
        }
        if (i >=4 && i<=7) {
             j = 60;
        }
        if (i>=8) {
            j = 120;
        }
        
        
        UIButton * imageButton = [[UIButton alloc]initWithFrame:CGRectMake(((i%4)*80)+10, j, 60, 40)];
        imageButton.tag = i;
        imageButton.backgroundColor = [UIColor colorWithRed:(i*20)/255.0 green:(i*50)/255.0 blue:(i*20)/255.0 alpha:1.0];
        [self addSubview:imageButton];
        [imageButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(((i%4)*80)+10, j+40, 60, 20)];
        lable.backgroundColor = [UIColor blueColor];
        [self addSubview:lable];
        
        foundLikeCarModel * F = self.mArray[i];
        lable.text = F.name;
        NSLog(@"%@",F.name);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)touchButton:(UIButton *)button
{
    NSLog(@"%ld",(long)button.tag);  
}
@end
