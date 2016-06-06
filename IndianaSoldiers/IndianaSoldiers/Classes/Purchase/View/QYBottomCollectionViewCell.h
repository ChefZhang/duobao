//
//  QYBottomCollectionViewCell.h
//  IndianaSoldiers
//
//  Created by qy on 16/5/8.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYPurchserBottomCellModel.h"

@interface QYBottomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)  QYPurchserBottomCellModel *item;
@property (nonatomic, assign) NSInteger height;
@end
