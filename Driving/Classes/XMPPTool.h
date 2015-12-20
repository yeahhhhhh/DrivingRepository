//
//  XMPPTool.h
//  MyWeChat
//
//  Created by 黄欣 on 15/11/4.
//  Copyright © 2015年 黄欣. All rights reserved.
//  引用 "Singleton.h 文件 实现单例

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "XMPPFramework.h"
typedef enum {
    XMPPResultTypeLoginSucess,//登录成功
    XMPPResultTypeLoginFailure,//登录失败
    XMPPResultTypeRegisterSucess,//注册成功
    XMPPResultTypeRegisterFailure//注册失败
}XMPPResultType;

/**
 *  与服务器交互的结果
 */
typedef void (^XMPPResultBlock)(XMPPResultType);


@interface XMPPTool : NSObject
singleton_interface(XMPPTool)

@property(strong,nonatomic,readonly)XMPPvCardTempModule *vCard;//电子名片模块
@property(strong,nonatomic,readonly)XMPPvCardCoreDataStorage *vCardStorage;//电子名片数据存储
@property(strong,nonatomic,readonly)XMPPvCardAvatarModule *avatar;//头像模块
@property(strong,nonatomic,readonly)XMPPRoster *roster;//花名册
@property(strong,nonatomic,readonly)XMPPRosterCoreDataStorage *rosterStorage;//花名册数据存储
@property(strong,nonatomic,readonly)XMPPStream *xmppStream;//与服务器交互的核心类

@property(strong,nonatomic,readonly)XMPPResultBlock resultBlock;//结果回调Block

@property(strong,nonatomic,readonly)XMPPMessageArchiving *msgArchiving;//消息
@property(strong,nonatomic,readonly)XMPPMessageArchivingCoreDataStorage *msgArchivingStorage;


/**
 *  标识 连接服务器 到底是 "登录连接"还是 “注册连接”
 *  NO 代表登录操作
 *  YES 代表注册操作
 */
@property(assign,nonatomic,getter=isRegisterOperation)BOOL registerOperation;

/**
 *  XMPP用户登陆
 */
- (void)xmppLogin:(XMPPResultBlock)resultBlock;
/**
 *  XMPP用户注册
 */
- (void)xmppRegister:(XMPPResultBlock)resultBlock;

/**
 *  XMPP用户注销
 */
- (void)xmppLogout;

@end
