//
//  QYShopRightTableViewCell.h
//  IndianaSoldiers
//
//  Created by qy on 16/5/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYSHOPRightModel.h"

@interface QYShopRightTableViewCell : UITableViewCell

@property (nonatomic, strong) QYSHOPRightModel *model;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContain;

@end
