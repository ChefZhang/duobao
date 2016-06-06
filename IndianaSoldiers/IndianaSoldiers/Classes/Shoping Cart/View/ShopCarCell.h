//
//  ShopCarCell.h
//  IndianaSoldiers
//
//  Created by leo on 16/5/13.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBShopCarGoods.h"

@interface ShopCarCell : UITableViewCell

@property (nonatomic, strong)  ZBShopCarGoods *item;
@property (nonatomic, strong) void(^block)(NSString *value);
@end
