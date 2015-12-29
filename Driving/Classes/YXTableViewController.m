//
//  YXTableViewController.m
//  YXRollView
//
//  Created by 黄欣 on 15/12/27.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "YXTableViewController.h"

@interface YXTableViewController ()

@end

@implementation YXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSLog(@"%ld",self.index);
    
    NSLog(@"又加载了一次");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text =[NSString stringWithFormat:@"ssss-%ld",(long)indexPath.row];
    
    return cell;
}
-(void)dealloc{
    NSLog(@"%s",__func__);
}
@end
