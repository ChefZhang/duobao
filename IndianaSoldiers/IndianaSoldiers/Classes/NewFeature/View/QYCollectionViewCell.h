//
//  QYCollectionViewCell.h
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYCollectionViewCell : UICollectionViewCell

/** 背景图片 */
@property (nonatomic, strong) UIImage *image;

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
@end
