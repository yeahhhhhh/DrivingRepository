//
//  XMPPTool.m
//  MyWeChat
//
//  Created by 黄欣 on 15/11/4.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "XMPPTool.h"
#import "Accont.h"
@interface XMPPTool ()<XMPPStreamDelegate>
{

    XMPPReconnect *_reconnect ;//自动连接模块 由于网络问题与服务器断开 它会自动尝试回复连接
    
    
}
/**
 *  初始化 XMPPStream 这个类
 */
- (void)setupStream;
/**
 *  连接到服务器（传一个jid（用户名））
 */

- (void)connectToHost;
/**
 *  释放资源
 */
-(void)teardownStream;

/**
 *  连接成功 接着发送密码
 */
- (void)sendPwdToHost;
/**
 *  发送一个“在线消息”给服务器 默认登陆成功是不再线的
 */
- (void)sendOnline;
/**
 *  发送一个“离线消息”给服务器
 */
- (void)sendOffline;
/**
 *  与服务器断开连接
 */
- (void)disconnectFromHost;
@end
@implementation XMPPTool
singleton_implementation(XMPPTool)

#pragma mark - 私有方

- (void)setupStream{
    //创建XMPPStream对象
    _xmppStream = [[XMPPStream alloc]init];
    
    //添加XMPP模块
    //1.添加电子名片模块
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCard = [[XMPPvCardTempModule alloc]initWithvCardStorage:_vCardStorage];
    
    //激活 (_vCard 向服务器请求数据，_xmppStream跟服务器联系)
    [_vCard activate:_xmppStream];
    
    // 电子名片模块会与“头像模块”一起使用
    //2.添加 头像模块
    _avatar = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_vCard];
    
    //激活
    [_avatar activate:_xmppStream];
    
     //3.添加好友模块
    _rosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterStorage];
    [_roster activate:_xmppStream];
    
    // 4.添加 "消息" 模块
    _msgArchivingStorage = [[XMPPMessageArchivingCoreDataStorage alloc]init];
    _msgArchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:_msgArchivingStorage];
    [_msgArchiving activate:_xmppStream];
    
    // 5.添加 “自动连接” 模块
    _reconnect = [[XMPPReconnect alloc] init];
    [_reconnect activate:_xmppStream];
    
    //设置代理 - 所有的代理方法都将在子线程被调用
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}
-(void)teardownStream{
    //移除代理
    [_xmppStream removeDelegate:self];
    
    //取消模块
    [_avatar deactivate];
    [_vCard deactivate];
    [_roster deactivate];
    [_msgArchiving deactivate];
    [_reconnect deactivate];
    //断开连接
    [_xmppStream disconnect];
    
    //清空资源
    _reconnect = nil;
    _msgArchiving = nil;
    _msgArchivingStorage = nil;
    _roster = nil;
    _rosterStorage = nil;
    _vCardStorage = nil;
    _vCard = nil;
    _avatar = nil;
    _xmppStream = nil;
    
}
- (void)connectToHost{
    
    if (!_xmppStream) {//如果为空就初始化XMPPStream类
        [self setupStream];
    }
    // 1.设置登陆用户的jid
    //  resource 用户登陆客户端的设备类型
    XMPPJID * myjid;
    if (self.isRegisterOperation) {//注册
        NSString *registerUser = [Accont shareAccount].registerUser;
        myjid = [XMPPJID jidWithUser:registerUser domain:@"xindemacbook-pro.local" resource:@"iphone"];
    }else{
        NSString *loginUser = [Accont shareAccount].loginUser;
        myjid = [XMPPJID jidWithUser:loginUser domain:@"xindemacbook-pro.local" resource:@"iphone"];
    }
    _xmppStream.myJID = myjid;
    // 2.设置主机地址
    _xmppStream.hostName = @"120.34.52.18";//127.0.0.1
    // 3.设置主机端口号
    _xmppStream.hostPort =  5222;
    // 4.发起连接
    NSError * error = nil;
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        NSLog(@"%@",error);
    }else{
        NSLog(@"发起连接成功%s",__func__);
    }
}
#pragma mark - XMPPStream的代理
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    //连接建立成功 后发送密码
    NSLog(@"%s连接建立成功 后发送密码",__func__);
    
    if (self.registerOperation) {//注册
        NSError * error = nil;
        [_xmppStream registerWithPassword:[Accont shareAccount].registerPwd error:&error];
        if (error) {
            NSLog(@"密码错误%@",error);
        }else{
            NSLog(@"注册成功");
        }
        NSLog(@"1111");
    }else{//登录
        [self sendPwdToHost];
        NSLog(@"222");
    }
}

- (void)sendPwdToHost{
    NSLog(@"sendPwdToHost%s",__func__);
    NSError * error = nil;
    NSString *password = [Accont shareAccount].loginPwd;
    [_xmppStream authenticateWithPassword:password error:&error];
    if (error) {
        NSLog(@"密码错误%@",error);
    }else{
        NSLog(@"登陆成功");
    }
}

- (void)sendOnline
{
    XMPPPresence * presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}
- (void)sendOffline
{
    XMPPPresence *offLine = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offLine];
}

- (void)disconnectFromHost
{
    [_xmppStream disconnect];
}

#pragma mark - 登陆成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    //回调resultBlock
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginSucess);
    }
    [self sendOnline];
     NSLog(@"登陆成功%s",__func__);
}

#pragma mark  登陆失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    //回调resultBlock
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
     NSLog(@"登陆失败%s %@",__func__,error);
}

#pragma mark - 注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    //回调resultBlock
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterSucess);
    }
    NSLog(@"注册成功%s",__func__);
}
#pragma mark  注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    //回调resultBlock
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
    NSLog(@"注册失败%s %@",__func__,error);
}



#pragma mark - 公共方法
#pragma mark 用户登陆
- (void)xmppLogin:(XMPPResultBlock)resultBlock
{
    // 不管什么情况，把以前的连接断开
    [_xmppStream disconnect];
    //用户登陆流程
    // 1 初始化 XMPPStream 这个类
    // 2 连接服务器 （传一个jid（用户名））
    // 3 连接成功 接着发送密码
    // 4 发送一个“在线消息”给服务器 默认登陆成功是不再线的
    
    _resultBlock = resultBlock;
    [self connectToHost];
    
}
#pragma mark 用户注册
- (void)xmppRegister:(XMPPResultBlock)resultBlock
{
    //1 发送一个注册 ID 给服务器 建立一个长连接
    
    //2 连接成功发送注册密码
    //保存block
    _resultBlock = resultBlock;
    
    // 去除以前的连接
    [_xmppStream disconnect];
    
    [self connectToHost];
}
#pragma mark 用户注销
- (void)xmppLogout
{
    // 发送“离线”消息给服务器
    [self sendOnline];
    // 断开与服务器的连接
    [self disconnectFromHost];
}
#pragma mark - 程序退出时调用
-(void)dealloc{
    [self teardownStream];
}
@end
