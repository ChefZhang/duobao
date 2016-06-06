//
//  QYShopRightTableViewCell.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYShopRightTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface QYShopRightTableViewCell ()



@property (weak, nonatomic) IBOutlet UIButton *buyCar;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UIImageView *jindu;
@property (weak, nonatomic) IBOutlet UILabel *shengyu;
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;


@end

@implementation QYShopRightTableViewCell

-(void)setModel:(QYSHOPRightModel *)model{
    _model = model;
    
    NSLog(@"%@",model);
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString: [QYURLShort stringByAppendingPathComponent:model.logoPath]] placeholderImage:[UIImage imageNamed:@"tupian"]];
    self.title.text = model.goodsName;
    self.total.text = [NSString stringWithFormat:@"总需: %ld",model.needs];
    self.jindu.image = [UIImage imageNamed:@"jindu02"];
    self.shengyu.text = [NSString stringWithFormat:@"剩余: %ld",model.lastCount];
    [self.buyCar setImage:[UIImage imageNamed:@"carIcon01"] forState:UIControlStateNormal];
}

- (IBAction)btnClick {
    
    
    NSLog(@"%@", _model);
    
      NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:_model ,@"dict", nil];
    
    [[NSNotificationCenter defaultCenter ] postNotificationName:@"buy" object:nil userInfo:dict ];
    
    
//    self.buyBtn.enabled = false;

    
    
}



@end
