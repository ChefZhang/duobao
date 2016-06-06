//
//  QYAnnouncedCollectionViewCell.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYAnnouncedCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface QYAnnouncedCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *qihao;
@property (weak, nonatomic) IBOutlet UILabel *huojiangze;
@property (weak, nonatomic) IBOutlet UILabel *benqicanyu;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *xingyunhao;


@end

@implementation QYAnnouncedCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


- (void)setItem:(QYAnnouncedModel *)item{
    
    _item = item;
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:[QYURLShort stringByAppendingPathComponent:item.logoPath]] placeholderImage:[UIImage imageNamed:@"tupian"]];
    self.title.text =[NSString stringWithFormat:@"%@",item.goodsName];
    self.qihao.text = [NSString stringWithFormat:@"期号: %ld",item.otherId];
    self.huojiangze.text = [NSString stringWithFormat:@"获奖者: %@",item.nickName];
    self.xingyunhao.text = [NSString stringWithFormat:@"幸运号: %ld",item.luckyNo];
    self.benqicanyu.text = [NSString stringWithFormat:@"本期参与: %ld",item.times];
    self.time.text = [NSString stringWithFormat:@"揭晓时间: %@",item.openTime];
}
@end
