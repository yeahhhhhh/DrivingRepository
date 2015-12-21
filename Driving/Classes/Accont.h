//
//  Accont.h
//  MyWeChat
//
//  Created by 黄欣 on 15/11/4.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Accont : NSObject
/**
 *  驾照类型
 */
@property(nonatomic,copy)NSString *divingType;
/**
 *  登录用户名
 */
@property(nonatomic,copy)NSString *loginUser;
/**
 *  用户登录密码
 */
@property(nonatomic,copy)NSString *loginPwd;
/**
 *  用户注册的用户名
 */
@property(nonatomic,copy)NSString *registerUser;
/**
 *  用户注册时的密码
 */
@property(nonatomic,copy)NSString *registerPwd;
/**
 *  判断用户是否登录
 */
@property(nonatomic,assign,getter=isLogin)BOOL login;


+(instancetype)shareAccount;

/**
 *  保存最新的登录用户数据到沙盒
 */
-(void)saveToSandBox;
@end
