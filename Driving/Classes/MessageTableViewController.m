//
//  MessageTableViewController.m
//  Driving
//
//  Created by 黄欣 on 15/7/19.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "MessageTableViewController.h"
#import "UIView+Extension.h"
@interface MessageTableViewController ()

@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init]; //删除多余空cell
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



@end
