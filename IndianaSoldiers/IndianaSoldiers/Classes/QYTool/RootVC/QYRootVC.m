//
//  QYRootVC.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYRootVC.h"
#import "QYSaveAccountTool.h"
#import "QYTabBarController.h"
#import "QYNewFeatureViewController.h"

@implementation QYRootVC

+ (UIViewController *)chooseWindowRootVC{
    // 当有版本更新,或者第一次安装的时候显示新特性界面;
    // 1.获取当前版本号
    NSString *currVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];

    
    NSString *lastVersion = [QYSaveAccountTool objectForKey:QYVersion];
    
    UIViewController *rootVc;
    
    if (![currVersion isEqualToString:lastVersion]) {
        // 进入新特界面
        rootVc = [[QYNewFeatureViewController alloc] init];

        [QYSaveAccountTool setObject:currVersion forKey:QYVersion];
        
    }else{
        // 进入主框架
        rootVc = [[QYTabBarController alloc] init];

    }
    
    return rootVc;
}
@end
