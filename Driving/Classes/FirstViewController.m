//
//  FirstViewController.m
//  Driving
//
//  Created by 黄欣 on 15/12/26.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "FirstViewController.h"
#import "RegisterViewController.h"
@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *signupBtn;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 255.0/255, 153.0/255, 153.0/255, 1 });
    //登陆
    [_loginBtn setTitle:@"SIGN IN" forState:UIControlStateNormal];
    [_loginBtn setTintColor:[UIColor whiteColor]];
    [_loginBtn.layer setMasksToBounds:YES];
    [_loginBtn.layer setBorderWidth:1.0];   //边框宽度
    [_loginBtn.layer setBorderColor:colorref];//边框颜色
    //注册
    [_signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [_signupBtn setTintColor:[UIColor whiteColor]];
    [_signupBtn.layer setMasksToBounds:YES];
    [_signupBtn.layer setBorderWidth:1.0];   //边框宽度
    [_signupBtn.layer setBorderColor:colorref];//边框颜色
    [_signupBtn addTarget:self action:@selector(RegisteredAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void) RegisteredAction
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
    self.navigationController.navigationBarHidden = NO;
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
