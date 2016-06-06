//
//  UIView+Frame.h
//  baidibudejie
//
//  Created by qy on 16/3/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat qy_width;
@property CGFloat qy_height;
@property CGFloat qy_x;
@property CGFloat qy_y;
@property CGFloat qy_centerX;
@property CGFloat qy_centerY;

+ (instancetype)qy_viewFromXib;
@end
