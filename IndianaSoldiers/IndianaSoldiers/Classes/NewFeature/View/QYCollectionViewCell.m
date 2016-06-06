//
//  QYCollectionViewCell.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYCollectionViewCell.h"
#import "QYTabBarController.h"

@interface QYCollectionViewCell()

/** 背景图片 */
@property (nonatomic, weak) UIImageView *bgImageView;

/** 立即体验按钮 */
@property (nonatomic, weak) UIButton *startBtn;
@end

@implementation QYCollectionViewCell


- (UIButton *)startBtn{
    if (!_startBtn) {
        UIButton *button = [[UIButton alloc] init];
//        [button setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        [button setTitle:@"进入咯" forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor blueColor];
        [button sizeToFit];
        
        
        button.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height * 0.82f);
        
        
        [self.contentView addSubview:button];
        _startBtn = button;
        
        [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside ];
        
    }
    return _startBtn;
}
// 点击立即体验按钮的时候就会调用
- (void)buttonOnClick:(UIButton *)button{
    
    // 切换窗口的跟控制器
    QYTabBarController *tabBarVC = [[QYTabBarController alloc] init];
    
    QYKeyWindow.rootViewController =  tabBarVC;
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:imageView];
        _bgImageView = imageView;
    }
    return _bgImageView;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.bgImageView.image = image;
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count{
    if (indexPath.item == 2 ) {
        
        
        // 最后一个cell
        // 当是最后一个cell添加立即体验按钮
        //        UIButton *button
        // 显示
        self.startBtn.hidden = NO;
        
    }else{
        // 不是最后一cell
        //        隐藏立即体验按钮
        self.startBtn.hidden = YES;
    }
}
@end
