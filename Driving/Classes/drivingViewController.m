//
//  drivingViewController.m
//  Driving
//
//  Created by 黄欣 on 15/7/19.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "drivingViewController.h"
#import "HomeTableViewController.h"
#import "MessageTableViewController.h"
#import "ExamTableViewController.h"
#import "myTableViewController.h"
@interface drivingViewController ()

@end

@implementation drivingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    HomeTableViewController *home = [[HomeTableViewController alloc]init];
    [self addchildVC:home title:@"驾校" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
    ExamTableViewController *discover = [[ExamTableViewController alloc]init];
    [self addchildVC:discover title:@"考试" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    myTableViewController *myTable = [[myTableViewController alloc]init];
    [self addchildVC:myTable title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
   
}
- (void)addchildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image  selectImage:(NSString *)selectImage
{
    
    childVC.tabBarItem.title = title;
    childVC.navigationItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    //    这张图片不会被渲染，会显示原图
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:(1)];
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    
    textAttrs [NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:1];
    
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    selectTextAttrs [NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC .tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVC];
    
    //添加控制器到tabbarviewcontrller
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
