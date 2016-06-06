//
//  ZBGoodsDetailController.h
//  IndianaSoldiers
//
//  Created by leo on 16/5/13.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYSHOPRightModel.h"
#import "QYSHOPLeftModel.h"
@interface ZBGoodsDetailController : UIViewController



@property (weak, nonatomic) QYSHOPRightModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@end
