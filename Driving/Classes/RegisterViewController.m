//
//  RegisterViewController.m
//  MyWeChat
//
//  Created by 黄欣 on 15/11/4.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD+MJ.h"
#import "Accont.h"
#import "XMPPTool.h"
#import "UIBarButtonItem+Extension.h"
#import "LoginViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic)  UITextField *userField;
@property (weak, nonatomic)  UITextField *pwdField;

@end

@implementation RegisterViewController
- (IBAction)cancelBtnClick:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)registerBtnClick {
    //注册
    // 保存注册的用户名和密码
    if (self.userField.text.length == 0) {
        [MBProgressHUD showError:@"用户名不能为空"];
        return;
    }
    NSLog(@"%lu",self.pwdField.text.length);
    if (self.pwdField.text.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    [Accont shareAccount].registerUser = self.userField.text;
    [Accont shareAccount].registerPwd = self.pwdField.text;
    
    [MBProgressHUD showMessage:@"正在注册中...."];
    
    //设置标示
    [XMPPTool sharedXMPPTool].registerOperation = YES;
    __weak typeof (self) selfVc = self;
    [[XMPPTool sharedXMPPTool] xmppRegister: ^(XMPPResultType resultType){
        [selfVc handleXMPPResult:resultType];
    }];

}
#pragma mark 处理注册的结果
-(void)handleXMPPResult:(XMPPResultType)resultType{
    
    //在主线程工作
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 1.隐藏提示
        [MBProgressHUD hideHUD];
        
        // 2.提示注册成功
        if (resultType == XMPPResultTypeRegisterSucess) {
            
            [MBProgressHUD showSuccess:@"恭喜注册成功..."];
            [self.navigationController popToRootViewControllerAnimated:YES];
            self.navigationController.navigationBarHidden = YES;
            
        }else{
            [MBProgressHUD showError:@"用户名重复"];
        }
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemwithTarget:self action:@selector(back) image:@"navigationbar_back" Highimage:@"navigationbar_back_highlighted"];
    
    // Do any additional setup after loading the view.
    
    UITextField *userField = [[UITextField alloc]initWithFrame:CGRectMake(89, 155, 186, 30)];
    UITextField *pwdField  = [[UITextField alloc]initWithFrame:CGRectMake(89, 200, 186, 30)];
    
    self.userField = userField;
    self.pwdField  = pwdField;
    
    userField.placeholder = @"User name";
    pwdField.placeholder  = @"Password";
    
    [self.view addSubview:userField];
    [self.view addSubview:pwdField];
    
    UIImageView *userImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"email"]];
    UIImageView *pwdImage  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
    
    userImage.frame = CGRectMake(55, 158, 20.5, 22.5);
    pwdImage.frame  = CGRectMake(55, 205, 20.5, 22.5);
    
    [self.view addSubview:userImage];
    [self.view addSubview:pwdImage];
    
    UIButton *RegisteredBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
    RegisteredBtn.backgroundColor = [UIColor whiteColor];
    [RegisteredBtn setTitle:@"注册" forState:UIControlStateNormal];
    [RegisteredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegisteredBtn.frame = CGRectMake(50,305, 208, 30);
    [RegisteredBtn.layer setMasksToBounds:YES];
    [RegisteredBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [RegisteredBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 255.0/255, 153.0/255, 153.0/255, 1 });
    [RegisteredBtn.layer setBorderColor:colorref];//边框颜色
    RegisteredBtn.backgroundColor = [UIColor colorWithRed:255.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    [RegisteredBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:RegisteredBtn];
    self.navigationItem.title = @"注册";
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
//    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //退出键盘
    [self.view endEditing:YES];
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
