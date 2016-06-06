//
//  QYFastButton.m
//  baidibudejie
//
//  Created by qy on 16/3/20.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYFastButton.h"

@implementation QYFastButton

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //设置按钮的图片和字体的frame
    self.imageView.qy_y = 0;
    self.imageView.qy_centerX = self.qy_width * 0.5;
    [self.imageView sizeToFit];
    
    //设置字体的frame
    self.titleLabel.qy_y = self.qy_height - self.titleLabel.qy_height;
    [self.titleLabel sizeToFit];
    self.titleLabel.qy_centerX = self.qy_width * 0.5;
    
}

@end
