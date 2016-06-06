//
//  QYTopCollectionViewCell.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/8.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYTopCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface QYTopCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemTime;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;


@end

@implementation QYTopCollectionViewCell

-(void)setItem:(QYPurchaseTopCellModel *)item{
    _item = item;
    if (item.openStatus == 1) {
        
        self.itemTitle.text = @"即将揭晓";
    }
    else if(item.openStatus == 2){
        self.itemTitle.text = @"已揭晓";
    }
    else{
       self.itemTitle.text = @"进行中";
    }
    self.itemName.text = item.goodsName;
    self.itemTime.text = item.openTime;
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:[QYURLShort stringByAppendingString:item.logoPath]]];
}

@end
