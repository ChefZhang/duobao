//
//  ShopCarCell.m
//  IndianaSoldiers
//
//  Created by leo on 16/5/13.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "ShopCarCell.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface ShopCarCell ()

@property (weak, nonatomic) IBOutlet UILabel *goodName;//商品名称
@property (weak, nonatomic) IBOutlet UIImageView *iconView;//图片
@property (weak, nonatomic) IBOutlet UILabel *needs; //总需
@property (weak, nonatomic) IBOutlet UILabel *lastNeeds;
@property (weak, nonatomic) IBOutlet UILabel *amount; //数量
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;




@end


@implementation ShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.minusBtn.enabled = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setItem:(ZBShopCarGoods *)item{
    
    _item = item;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[QYURLShort stringByAppendingString:item.logoPath]]];
    
    self.goodName.text = item.goodsName;
    
    self.needs.text = [NSString stringWithFormat:@"%ld",item.needs];
    
    self.amount.text = [NSString stringWithFormat:@"%ld",item.amount];
    
   
    
}

- (IBAction)minus {
    
    int a = [self.amount.text  intValue];
    
    if (a == 1) {
        a -= 1 ;
        self.item.amount -= 1;
        [self delete];
        self.minusBtn.enabled = true;
    }
    
    
    if (a != 0 ) {
         a -= 1 ;
        self.item.amount -= 1;
        self.minusBtn.enabled = true;
    }
    
   
    
    if (a == 0){
        self.minusBtn.enabled = false;
    }
    self.amount.text = [NSString stringWithFormat:@"%d",a];
    
    
    
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *address = [QYURLLong stringByAppendingPathComponent:@"/car/updateCarAmount.do"];
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
   
        [paramDict setObject:[NSString stringWithFormat:@"%ld",_item.id] forKey:@"id"];
        [paramDict setObject:[NSString stringWithFormat:@"%ld",_item.amount -= 1] forKey:@"amount"];
        [paramDict setObject:[NSString stringWithFormat:@"%ld",_item.minTimes] forKey:@"minTimes"];
   
    
    
    [manager POST:address parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            NSLog(@"请求成功--");
        [[NSNotificationCenter defaultCenter ]postNotificationName:@"minus" object:self];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];
    
    
    
    
}
- (IBAction)add {
    
    self.minusBtn.enabled = true;

    int a = [self.amount.text  intValue];
    a += 1 ;
    self.item.amount += 1;
    self.amount.text = [NSString stringWithFormat:@"%d",a];
    
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *address = [QYURLLong stringByAppendingPathComponent:@"/car/updateCarAmount.do"];
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setObject:[NSString stringWithFormat:@"%ld",_item.id] forKey:@"id"];
    [paramDict setObject:[NSString stringWithFormat:@"%ld",_item.amount += 1] forKey:@"amount"];
    [paramDict setObject:[NSString stringWithFormat:@"%ld",_item.minTimes] forKey:@"minTimes"];
    
    [manager POST:address parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         NSLog(@"请求成功--");
             [[NSNotificationCenter defaultCenter ]postNotificationName:@"add" object:self];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];
    
    
}


- (IBAction)delete {
    
    
    
    
     [[NSNotificationCenter defaultCenter ]postNotificationName:@"delete" object:self];
    
    
    
    
    
    
//    //1.创建会话管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSString *address = [QYURLLong stringByAppendingPathComponent:@"car/deleteCar.do"];
//    
//    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
//    [paramDict setObject:[NSString stringWithFormat:@"%ld",_item.id] forKey:@"id"];
//
//    
//    
//    
//    [manager POST:address parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"请求成功--");
//                [[NSNotificationCenter defaultCenter ]postNotificationName:@"delete" object:self];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败--%@",error);
//    }];
}










@end
