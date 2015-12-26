//
//  messagesTableViewController.m
//  Driving
//
//  Created by 黄欣 on 15/11/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "messagesTableViewController.h"
#import "UIView+Extension.h"
#import "XMPPTool.h"
@interface messagesTableViewController ()< NSFetchedResultsControllerDelegate , UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate ,UIImagePickerControllerDelegate , UINavigationControllerDelegate>
{
    NSFetchedResultsController *_resultContr;//   监听数据库变化的类
}

@property (nonatomic, weak) UIView *toolbar;
/** 输入文本框*/
@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,strong)UIButton *Btn;
@end

@implementation messagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupToolbar];
    [self loadMessage];
  self.navigationItem.leftBarButtonItem = [self itemwithTarget:self action:@selector(back) image:@"navigationbar_back" Highimage:@"navigationbar_back_highlighted"];
    
    self.tableView.tableFooterView=[[UIView alloc]init];//删除多余空cel
    self.tabBarController.tabBar.hidden = YES;
    NSString *string = self.friendJid.user;
    self.navigationItem.title = [string  componentsSeparatedByString:@"@"][0];
}
- (void)loadMessage
{
    // 加载数据库的聊天内容
    //1.上下文 关联XMPPRoster.sqlite文件
    NSManagedObjectContext *messageContext = [XMPPTool sharedXMPPTool].msgArchivingStorage.mainThreadManagedObjectContext;
    
    //2.Request 请求查询哪张表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    //过滤 当前登录的用户 好友的聊天消息
    NSString *loginUserJid = [XMPPTool sharedXMPPTool].xmppStream.myJID.bare;
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",loginUserJid,self.friendJid.bare];
//    NSLog(@"%@",self.friendJid.bare);
    request.predicate = pre;
    // 设置时间排序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[timeSort];
    // 3.执行请求
    _resultContr = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:messageContext sectionNameKeyPath:nil cacheName:nil];
    _resultContr.delegate = self;
    NSError *err;
    [_resultContr performFetch:&err];
    NSLog(@"%@",err);
    
    // 监听键盘显示通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kayboardWillShowFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    // 监听键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kayboardDidHideFrame:) name:UIKeyboardDidHideNotification object:nil];
    
}
#pragma mark 数据库内容改变调用
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
    
    //表格滚动到底部
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_resultContr.fetchedObjects.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%lu",_resultContr.fetchedObjects.count);
    return _resultContr.fetchedObjects.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

//    static NSString * ID = @"massageCell";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //获取聊天信息
    XMPPMessageArchiving_Message_CoreDataObject *msgObj = _resultContr.fetchedObjects[indexPath.row];
    //判断消息的类型 有没有附件（图片，文件，语音）
    //获取原始消息
    XMPPMessage *message = msgObj.message;
    //获取附件类型
    NSString *bodyType = [message attributeStringValueForName:@"bodyType"];
    if ([bodyType isEqualToString:@"image"]) {//图片
        
        //遍历message的子节点  (message.children)存放子节点数组
        for (XMPPElement *element in message.children) {
            //获取节点的名字
            if ([[element name ]isEqualToString:@"attachment"]) {
                // 将附件字符串 转为NSData 在转为图片
                NSString *Base64Str  = [element stringValue];
                NSData *data         = [[NSData alloc]initWithBase64EncodedString:Base64Str options:0];
                UIImage * image      = [UIImage imageWithData:data];
                cell.imageView.image = image;
            }
        }
    }else if ([bodyType isEqualToString:@"sound"]){//语音
    }else{//纯文本
        cell.textLabel.text = msgObj.body;
//        NSLog(@"%@",msgObj.body);
    }
    return cell;
    
//    cell.textLabel.text =[NSString stringWithFormat:@"ssss-%ld",(long)indexPath.row];
//    
//    return cell;
}
#pragma mark -发送聊天数据
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString * text  = self.textField.text;
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:self.friendJid];
    [msg addBody:text];
    [[XMPPTool sharedXMPPTool].xmppStream sendElement:msg];
    //清空textField 内容
    self.textField.text = nil;
    [self.view endEditing:YES];//键盘退下
    return YES;
}

#pragma mark -初始化输入框
- (void)setupToolbar
{
    UIView *toolbar           = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height, self.view.width, 44)];
    toolbar.backgroundColor   = [UIColor grayColor];
    self.toolbar              = toolbar;

    UITextField *textField    = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 200 , 34)];
    textField.backgroundColor = [UIColor whiteColor];
    [self.toolbar addSubview:textField];
    self.textField            = textField;
    self.textField.delegate   = self;

    UIButton *Btn             = [[UIButton alloc]initWithFrame:CGRectMake(230, 5, 60, 35)];
    [Btn setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
    [Btn setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateSelected];
    [Btn addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    Btn.backgroundColor       = [UIColor whiteColor];
    [toolbar addSubview:Btn];

    self.Btn                  = Btn;
    toolbar.y                 = self.view.height - 2*toolbar.height;//如果键盘消失后toolbar留在界面底部就用这句
    [self.view addSubview:toolbar];
    
//    self.tableView.tableFooterView = toolbar;
    //self.textView.inputView 用来设置键盘
    //    self.textView.inputAccessoryView = toolbar;//将工具条添加到键盘上如果键盘消失后toolbar不留在界面上就用这句
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
//    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - 键盘弹出时调用
- (void)kayboardWillShowFrame:(NSNotification *)notification
{
    NSLog(@"键盘的frame 发生改变时调用");
    
    NSDictionary *userInfo = notification.userInfo;
    //动画持续时间
    double duration        = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘frame
    CGRect keyboardF       = [userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //键盘的y值 keyboardF.origin.y
    self.toolbar.y         = keyboardF.origin.y - 44 ;
    }];
}
#pragma mark  键盘隐藏时调用
- (void)kayboardDidHideFrame:(NSNotification *)notification
{
    
    self.toolbar.y = self.view.height -  2 * self.toolbar.height;
//    NSLog(@"%f",self.toolbar.y);
}
#pragma mark  滚动表格 键盘隐藏
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"滚动表格");
    [self.view endEditing:YES];//键盘退下
    self.toolbar.y = self.view.height -  2 * self.toolbar.height;
}
#pragma mark - 设置rightBarButtonItem的方法封装
- (UIBarButtonItem *)itemwithTarget:(id)target action:(SEL)action image:(NSString *)image Highimage:(NSString *)highimage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage  imageNamed: image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside ];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
