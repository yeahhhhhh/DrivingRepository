//
//  messagesTableViewController.h
//  Driving
//
//  Created by 黄欣 on 15/11/29.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPJID.h"
@interface messagesTableViewController : UITableViewController
/**
 * 好友的jid
 */
@property (strong, nonatomic) XMPPJID * friendJid;
@end
