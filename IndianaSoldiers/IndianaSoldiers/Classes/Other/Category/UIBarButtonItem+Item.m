//
//  UIBarButtonItem+Item.m
//  baidibudejie
//
//  Created by qy on 16/3/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+(UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    return [[UIBarButtonItem alloc]initWithCustomView:containView];
}


+(UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc]initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    return [[UIBarButtonItem alloc]initWithCustomView:contentView];
}

+(UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    return [[UIBarButtonItem alloc]initWithCustomView:containView];
}
@end
