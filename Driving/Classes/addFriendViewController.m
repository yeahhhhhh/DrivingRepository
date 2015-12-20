//
//  addFriendViewController.m
//  Driving
//
//  Created by 黄欣 on 15/11/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "addFriendViewController.h"
#import "Accont.h"
#import "XMPPTool.h"
@interface addFriendViewController ()
@property (strong, nonatomic)  UITextField *textField;
@end

@implementation addFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, 270, 30)];
    self.textField = textField;
    [self.view addSubview:textField];
    textField.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.title = @"添加好友";
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(130, 130, 60, 30)];
    [self.view addSubview:btn];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
//    btn.titleLabel.text = @"添加";
    btn.backgroundColor = [UIColor grayColor];
    
}
- (void)add
{
    //添加好友
    // 获取用户输入好友名称
    NSString *user = self.textField.text;
    
    //1.不能添加自己为好友
    if ([user isEqualToString:[Accont shareAccount].loginUser]) {
        [self showMsg:@"不能添加自己为好友"];
        return;
    }
    
    //2.已经存在好友无需添加
    XMPPJID *userJid = [XMPPJID jidWithUser:user domain:@"xindemacbook-pro.local" resource:nil];
    
    BOOL userExists = [[XMPPTool sharedXMPPTool].rosterStorage userExistsWithJID:userJid xmppStream:[XMPPTool sharedXMPPTool].xmppStream];
    if (userExists) {
        [self showMsg:@"好友已经存在"];
        return;
    }
    
    //3.添加好友 (订阅)
    [[XMPPTool sharedXMPPTool].roster subscribePresenceToUser:userJid];
    
    
    /*添加好友在现有openfire存在的问题
     1.添加不存在的好友，通讯录里面也现示了好友
     解决办法1. 服务器可以拦截好友添加的请求，如当前数据库没有好友，不要返回信息
     <presence type="subscribe" to="werqqrwe@teacher.local"><x xmlns="vcard-temp:x:update"><photo>b5448c463bc4ea8dae9e0fe65179e1d827c740d0</photo></x></presence>
     
     解决办法2.过滤数据库的Subscription字段查询请求
     none 对方没有同意添加好友
     to 发给对方的请求
     from 别人发来的请求
     both 双方互为好友
     
     */
}

-(void)showMsg:(NSString *)msg{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [av show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
