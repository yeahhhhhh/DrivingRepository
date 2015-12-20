//
//  EditeTableViewController.m
//  MyWeChat
//
//  Created by 黄欣 on 15/11/4.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "EditeTableViewController.h"
#import "QuartzCore/QuartzCore.h"////////////
@interface EditeTableViewController ()
@property (weak, nonatomic) UITextField *editeLabel;

@end

@implementation EditeTableViewController
- (void)saveBtn:(UIBarButtonItem *)sender {
    
    self.cell.detailTextLabel.text = self.editeLabel.text;
    [self.cell layoutSubviews];
    //移除当前控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    //通知保存
    if ([self.delegete respondsToSelector:@selector(editeTableViewController:didFinishedSave:)]) {
        [self.delegete editeTableViewController:self didFinishedSave: sender];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc]init];//删除多余空cell
    UITextField *editeLabel = [[UITextField alloc]init];
    self.editeLabel = editeLabel;
    editeLabel.frame = CGRectMake(10, 10, 300, 30);
    editeLabel.layer.borderColor=[[UIColor grayColor] CGColor];
    editeLabel.layer.borderWidth = 1.0;
//    editeLabel.backgroundColor = [UIColor blueColor];
    [self.view addSubview:editeLabel];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtn:)];
    // 设置标题
    self.title = self.cell.textLabel.text;
    //设置输入框默认值
    self.editeLabel.text = self.cell.detailTextLabel.text;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
