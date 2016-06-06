//
//  QYSettingViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/11.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYSettingViewController.h"
#import "NSString+Hash.h"
#import "UserAccount.h"
@interface QYSettingViewController ()



@end

@implementation QYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:18],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"系统设置";
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-34, 0, 0, 0);
}

//退出
- (IBAction)loginOut:(id)sender {
    
   
  
    
    
    NSString *tempPath =  NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:filePath error:nil];
    
}



@end
