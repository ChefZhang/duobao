//
//  QYBottomCollectionViewCell.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/8.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYBottomCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface QYBottomCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageGoods;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *allCount;
@property (weak, nonatomic) IBOutlet UILabel *otherCount;

@property (weak, nonatomic) IBOutlet UIImageView *car;
@end

@implementation QYBottomCollectionViewCell

-(void)setItem:(QYPurchserBottomCellModel *)item{
    _item = item;
    [self.imageGoods sd_setImageWithURL:[NSURL URLWithString:[QYURLShort stringByAppendingString:item.logoPath]]];
    self.name.text = item.goodsName;
    self.allCount.text = [NSString stringWithFormat:@"%ld",item.needs];
    self.otherCount.text = [NSString stringWithFormat:@"%ld", item.lastCount];
    self.car.image = [UIImage imageNamed:@"carIcon01"];
    
}

@end
