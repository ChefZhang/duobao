//
//  QYPurchserBottomCellModel.h
//  IndianaSoldiers
//
//  Created by qy on 16/5/8.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYPurchserBottomCellModel : NSObject

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger goodsId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *goodsTypeName;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger lastCount;
@property (nonatomic, strong) NSString *logoPath;
@property(nonatomic,assign)NSInteger minTimes;
@property(nonatomic,assign)NSInteger needs;
@property(nonatomic,assign)NSInteger openStatus;
@property (nonatomic, strong) NSString *time;
@property(nonatomic,assign)NSInteger times;
@property(nonatomic,assign)NSInteger amount;
@end
