//
//  LoginViewController.m
//  MyWeChat
//
//  Created by 黄欣 on 15/11/3.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"
#import "Accont.h"
#import "XMPPTool.h"
#import "drivingViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()<UIPickerViewDataSource , UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet  UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
/**
 *  驾驶证类型
 */
@property (nonatomic , copy) NSString *typeString;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray * array;//保存从.plist文件中取出的驾驶证类型数据
@end

@implementation LoginViewController
- (void)loginAction{
    // 1.判断有没有输入用户名和密码
    if (self.userField.text.length == 0 || self.passwordField.text.length == 0) {
        
        [MBProgressHUD showError:@"请求输入用户名和密码"];
        return;
    }
    [MBProgressHUD showMessage:@"正在登录"];
    // 2.登录服务器
    // 2.1把用户名和密码保存到accont中
    [Accont shareAccount].loginUser = self.userField.text;
    [Accont shareAccount].loginPwd = self.passwordField.text;
    //设置标示
    [XMPPTool sharedXMPPTool].registerOperation = NO;
    
    // 2.2调用AppDelegate的xmppLogin方法
    //block会对self进行强引用，所以使用__weak改为弱引用
    __weak typeof(self) selfvc = self;
    // 自己写的block 用强引用的时候最好改为弱引用
    [[XMPPTool sharedXMPPTool] xmppLogin:^(XMPPResultType resultType ) {
        
        [selfvc handlXMPPResultType:resultType];
        
    }];
    
}

#pragma mark 处理结果
-(void)handlXMPPResultType:(XMPPResultType)resultType{
    //回到主线程更新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if (resultType == XMPPResultTypeLoginSucess) {
            NSLog(@"%s 登录成功",__func__);
            // 3.登录成功切换到主界面
            [self changeToMain];
            
            // 设置当前的登录状态
            [Accont shareAccount].login = YES;
//
//            // 保存登录帐户信息到沙盒
            [[Accont shareAccount] saveToSandBox];
            
        }else{
            NSLog(@"%s 登录失败",__func__);
            [MBProgressHUD showError:@"用户名或者密码不正确"];
        }
    });
    
    
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}


#pragma mark 切换到主界面
-(void)changeToMain{
    // 1.获取Main.storyboard的第一个控制器
//    id vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    UITabBarController *tabbleVC = [[drivingViewController alloc]init];
    // 2.切换window的根控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbleVC;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithRed:255.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    // 登陆按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor whiteColor];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(50,319, 208, 30);
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [loginBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 255.0/255, 153.0/255, 153.0/255, 1 });
    [loginBtn.layer setBorderColor:colorref];//边框颜色
   
    loginBtn.backgroundColor = color;
    // 注册按钮
    
    UIButton *RegisteredBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    RegisteredBtn.backgroundColor = [UIColor whiteColor];
    [RegisteredBtn setTitle:@"注册" forState:UIControlStateNormal];
    [RegisteredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegisteredBtn.frame = CGRectMake(50,375, 208, 30);
    [RegisteredBtn.layer setMasksToBounds:YES];
    [RegisteredBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [RegisteredBtn.layer setBorderWidth:1.0];   //边框宽度
    [RegisteredBtn.layer setBorderColor:colorref];//边框颜色
    RegisteredBtn.backgroundColor = color;
    
    [self.view addSubview:loginBtn];
    [self.view addSubview:RegisteredBtn];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [RegisteredBtn addTarget:self action:@selector(RegisteredAction) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *  加载驾驶证类型数据
     */
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"DrivingType" ofType:@"plist"];
    _array = [[NSArray alloc]initWithContentsOfFile:plistPath];

    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}
- (void) RegisteredAction
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
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
#pragma mark - 选择器中拨轮的数目
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
#pragma mark - 选择器中某个拨轮的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 6;
}
#pragma mark - 为选择器中某个行提供数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_array objectAtIndex:row];
}
#pragma mark - 选择器选中某个拨轮中的某行时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _typeString = [_array objectAtIndex:row];
    NSLog(@"%@",_typeString);
}
@end
