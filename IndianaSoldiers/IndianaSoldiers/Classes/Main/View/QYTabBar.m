//
//  QYTabBar.m
//  baidibudejie
//
//  Created by qy on 16/3/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYTabBar.h"
#import "UIView+Frame.h"

@interface QYTabBar ()

/** 上一次点击的按钮 */
@property (nonatomic, weak) UIControl *previousClickedTabBarButton;
@end

@implementation QYTabBar


- (void)layoutSubviews{
    self.backgroundColor = QYColor(240, 240, 240);

//    设置4个子控件的位置frame
    int i = 0 ;
    //宽度为5个控件平分
    CGFloat buttonW = self.qy_width / (self.items.count);
    //高度和父控件一致
    CGFloat buttonH = self.qy_height;
    CGFloat buttonY = 0;
//    子控件的x值要根据下标计算
    CGFloat buttonX = 0;
    
    
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            //设置previousClickedTabBarButton的默认值为最前面的按钮
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                
                self.previousClickedTabBarButton = tabBarButton;
            }

            buttonX = i * buttonW;
            
            tabBarButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
                i++;
            
            //监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }

}

/**
 *  tabBarButton的点击
 */

- (void)tabBarButtonClick:(UIControl *)tabBarButton{
    
    if (self.previousClickedTabBarButton == tabBarButton) {

        //发出通知,告知外加tabBarButton被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:QYTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.previousClickedTabBarButton = tabBarButton;
}

@end
