//
//  UIBarButtonItem+Item.h
//  baidibudejie
//
//  Created by qy on 16/3/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
//快速创建UIBarButtonItem

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

+(UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

@end
