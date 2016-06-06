//
//  UIView+Frame.m
//  baidibudejie
//
//  Created by qy on 16/3/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setQy_height:(CGFloat)Qy_height
{
    CGRect rect = self.frame;
    rect.size.height = Qy_height;
    self.frame = rect;
}

- (CGFloat)qy_height
{
    return self.frame.size.height;
}

- (CGFloat)qy_width
{
    return self.frame.size.width;
}
- (void)setQy_width:(CGFloat)qy_width
{
    CGRect rect = self.frame;
    rect.size.width = qy_width;
    self.frame = rect;
}

- (CGFloat)qy_x
{
    return self.frame.origin.x;
    
}

- (void)setQy_x:(CGFloat)qy_x
{
    CGRect rect = self.frame;
    rect.origin.x = qy_x;
    self.frame = rect;
}

- (void)setQy_y:(CGFloat)qy_y
{
    CGRect rect = self.frame;
    rect.origin.y = qy_y;
    self.frame = rect;
}

- (CGFloat)qy_y
{
    
    return self.frame.origin.y;
}

- (void)setQy_centerX:(CGFloat)qy_centerX{
    
    CGPoint center = self.center;
    center.x = qy_centerX;
    self.center = center;
}

- (CGFloat)qy_centerX{
    return self.center.x;
}

-(void)setQy_centerY:(CGFloat)qy_centerY{
    
    CGPoint center = self.center;
    center.y = qy_centerY;
    self.center = center;
}

- (CGFloat)qy_centerY{
    return self.qy_centerY;
}

+ (instancetype)qy_viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
@end
