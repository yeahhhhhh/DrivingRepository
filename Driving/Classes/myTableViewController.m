//
//  myTableViewController.m
//  MyWeChat
//
//  Created by 黄欣 on 15/11/3.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "myTableViewController.h"
#import "XMPPvCardTemp.h"
#import "XMPPTool.h"
#import "Accont.h"
#import "myTableViewCell.h"
#import "ProfileTableViewController.h"
#import "EditeTableViewController.h"
#import "XMPPvCardTemp.h"
#import "FriendCell.h"
#import "UIView+Extension.h"
#import "addFriendViewController.h"
#import "messagesTableViewController.h"
@interface myTableViewController ()<NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *_resultsContr;
}
/**
 * 好友
 */
@property(strong,nonatomic)NSArray *users;

@end

@implementation myTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUsers];
    self.navigationItem.rightBarButtonItem = [self itemwithTarget:self action:@selector(addFriend) image:@"navigationbar_friendsearch" Highimage:@"navigationbar_friendsearch_highlighted"];
    self.tableView.tableFooterView = [[UIView alloc]init]; //删除多余空cell
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61/255.0 green:201/255.0 blue:106/255.0 alpha:1.0];//设置导航栏颜色
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadUsers{
    //显示好友数据 （保存XMPPRoster.sqlite文件）
    
    //1.上下文 关联XMPPRoster.sqlite文件""
    NSManagedObjectContext *rosterContext = [XMPPTool sharedXMPPTool].rosterStorage.mainThreadManagedObjectContext;
    
    //2.Request 请求查询哪张表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    //过滤
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"subscription != %@",@"none"];//subscription = none是没有该联系人
    request.predicate = pre;
    
    //设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:NO];
    request.sortDescriptors = @[sort];
    
    //3.执行请求
    //3.1创建结果控制器
    // 数据库查询，如果数据很多，会放在子线程查询
    // 移动客户端的数据库里数据不会很多，所以很多数据库的查询操作都主线程
    _resultsContr = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:rosterContext sectionNameKeyPath:nil cacheName:nil];
    _resultsContr.delegate = self;
    NSError *err = nil;
    //3.2执行 返回一个布尔类型，（_resultsContr.fetchedObjects）使用
    [_resultsContr performFetch:&err];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
    return _resultsContr.fetchedObjects.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
     static NSString *cellIndentifiter = @"CellIndentifiter";
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"myTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            
        }
        
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifiter];
        if (cell == nil) {
            cell = [[FriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifiter];
        }
        XMPPUserCoreDataStorageObject *user = _resultsContr.fetchedObjects[indexPath.row];
        NSString *string = user.jidStr;
        cell.textLabel.text = [string componentsSeparatedByString:@"@"][0];//好友名
        
//        if (user.photo) {
//            cell.imageView.image = user.photo;//第一次启动 user.photo 是没有 数据的
//        }//else{
            NSData *imgData = [[XMPPTool sharedXMPPTool].avatar photoDataForJID:user.jid];//第一次 从XMPPTool 的avatar中获取头像
        if (imgData) {
            cell.imageView.image = [UIImage imageWithData:imgData];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"placeholder"];
        }
            
//        }
        
        switch ([user.sectionNum integerValue]) {
            case 0:
                cell.detailTextLabel.text = @"在线";
                break;
            case 1:
                cell.detailTextLabel.text = @"离开";
                break;
            case 2:
                cell.detailTextLabel.text = @"离线";
                break;
            default:
                cell.detailTextLabel.text = @"见鬼了";
                break;
        }
    }
        
    return cell;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else{
    return 60;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        ProfileTableViewController * PC = [[ProfileTableViewController alloc]init];
        [self.navigationController pushViewController:PC animated:YES];
    }else{
        //获取 点击行 的好友jid
        XMPPJID * friendJID = [_resultsContr.fetchedObjects[indexPath.row] jid];
        
//        [self performSegueWithIdentifier:@"toChatVcSegue" sender:friendJID];
        messagesTableViewController *messages = [[messagesTableViewController alloc]init];
        messages.friendJid = friendJID;
        [self.navigationController pushViewController:messages animated:YES];
    }
}
#pragma mark - 添加好友
- (void)addFriend
{
    NSLog(@"添加好友");
    addFriendViewController *add = [[addFriendViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else {
        return @"通讯录";
    }
}
@end
