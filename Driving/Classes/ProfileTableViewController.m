//
//  ProfileTableViewController.m
//  MyWeChat
//
//  Created by 黄欣 on 15/11/4.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "XMPPvCardTemp.h"
#import "EditeTableViewController.h"
#import "XMPPTool.h"
#import "Accont.h"
@interface ProfileTableViewController ()<EditeTableViewControllerDeleget,UIActionSheetDelegate,UINavigationControllerDelegate ,UIImagePickerControllerDelegate>
@property (weak, nonatomic)  UIImageView *avatarImageView;


@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init]; //删除多余空cell
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    //获取登录用户信息的，使用电子名片模块
    // 登录用户的电子名片信息
    XMPPvCardTemp *myvCard = [XMPPTool sharedXMPPTool].vCard.myvCardTemp;
    // 获取头像
    if (myvCard.photo) {
        self.avatarImageView.image = [UIImage imageWithData:myvCard.photo];
    }
    
 
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:@"myTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell.tag = 0;
            
        }
        
    }else {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = @"退出登陆";
        cell.tag = 1;
       
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 选中表格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //根据cell不同tag进行相应的操作
    /*
     *tag = 0,换头像
     *tag = 1,进行到下一个控制器
     */
    
    UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    switch (selectCell.tag) {
        case 0:
            NSLog(@"换头像");
            [self choseImg];
            break;
        case 1:
//            [self performSegueWithIdentifier:@"toEditVcSegue" sender:selectCell];
           
            NSLog(@"退出");
            [self logoutBtnClick];
            
            break;
    }
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    //获取目标控制器
//    id destVc = segue.destinationViewController;
//    //设置EditeTableViewController 的cell 属性
//    if ([destVc isKindOfClass:[EditeTableViewController class]]) {
//        EditeTableViewController *editVc = destVc;
//        editVc.cell = sender;
//        //设置代理
//        editVc.delegete = self;
//    }
//    
//}
#pragma mark - 退出登陆
- (void)logoutBtnClick {
    // 发送“离线”消息给服务器
    // 断开与服务器的连接
    [[XMPPTool sharedXMPPTool] xmppLogout];
    //把用户登录状态设置为no
    [Accont shareAccount].login = NO;
    //保存更改
    [[Accont shareAccount] saveToSandBox];
    
    //切换到登录页面
    id loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
    
    
    
}
#pragma mark - 选择图片
-(void)choseImg{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"图片库",nil];
    [sheet showInView:self.view];
}
// 对应UIActionSheet 的按钮
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex == 2) return;
    
    // 图片选择器
    UIImagePickerController *imgPC = [[UIImagePickerController alloc] init];
    
    //设置代理
    imgPC.delegate = self;
    
    //允许编辑图片
    imgPC.allowsEditing = YES;
    
    if (buttonIndex == 0) {//照相
        imgPC.sourceType =  UIImagePickerControllerSourceTypeCamera;
    }else{//图片库
        imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //显示控制器
    [self presentViewController:imgPC animated:YES completion:nil];
}
#pragma mark 图片选择后的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"图片选择后的代理%@",info);
    
    //获取修改后的图片
    UIImage *editedImg = info[UIImagePickerControllerEditedImage];
    
    //更改cell里的图片
    self.avatarImageView.image = editedImg;
    //移除图片选择的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //把新的图片保存到服务器
    // 获取电子名片信息
    XMPPvCardTemp *myvCard = [XMPPTool sharedXMPPTool].vCard.myvCardTemp;
    //重新设置myVCard里的属性
    myvCard.photo = UIImageJPEGRepresentation(editedImg, 1.0);//将self.avatarImageView.image转换为NSData数据
    
    //把数据保存到数据库
    [[XMPPTool sharedXMPPTool].vCard updateMyvCardTemp:myvCard ];
//    [self editeTableViewController:nil didFinishedSave:nil ];
}

//#pragma mark - 修改个人设置的代理
//- (void)editeTableViewController:(EditeTableViewController *)editVc didFinishedSave:(id)sender
//{
//    NSLog(@"保存了");
//    // 获取电子名片信息
//    XMPPvCardTemp *myvCard = [XMPPTool sharedXMPPTool].vCard.myvCardTemp;
//    //重新设置myVCard里的属性
//    myvCard.photo = UIImageJPEGRepresentation(self.avatarImageView.image, 1.0);//将self.avatarImageView.image转换为NSData数据
//    
//    //把数据保存到数据库
//    [[XMPPTool sharedXMPPTool].vCard updateMyvCardTemp:myvCard ];
//}
@end
