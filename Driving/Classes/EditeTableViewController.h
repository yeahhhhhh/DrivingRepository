//
//  EditeTableViewController.h
//  MyWeChat
//
//  Created by 黄欣 on 15/11/4.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditeTableViewController;

@protocol EditeTableViewControllerDeleget <NSObject>

- (void)editeTableViewController:(EditeTableViewController *)editVc didFinishedSave:(id)sender;

@end
@interface EditeTableViewController : UITableViewController
/**
 *  接收上一个控制器传下来的cell
 */
@property(nonatomic ,strong) id<EditeTableViewControllerDeleget> delegete;

@property (nonatomic ,strong)UITableViewCell *cell;
@end
