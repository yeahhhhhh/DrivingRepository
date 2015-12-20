//
//  Accont.m
//  MyWeChat
//
//  Created by 黄欣 on 15/11/4.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "Accont.h"
#define kUserKey @"user"
#define kPwdKey @"pwd"
#define kLoginKey @"login"
@implementation Accont

+(instancetype)shareAccount{
    return [[self alloc] init];
}
#pragma mark 分配内存创建对象 (*单例模式)
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static Accont *acount;
    // 为了线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

            acount = [super allocWithZone:zone];
            
            //从沙盒获取上次的用户登录信息
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            acount.loginUser = [defaults objectForKey:kUserKey];
            acount.loginPwd = [defaults objectForKey:kPwdKey];
            acount.login = [defaults boolForKey:kLoginKey];
    });
    
    return acount;
    
}
-(void)saveToSandBox{
    
    // 保存user pwd login
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.loginUser forKey:kUserKey];
    [defaults setObject:self.loginPwd forKey:kPwdKey];
    [defaults setBool:self.isLogin forKey:kLoginKey];
    [defaults synchronize];
    
}

@end
