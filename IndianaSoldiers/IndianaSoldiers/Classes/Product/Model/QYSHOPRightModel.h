//
//  QYSHOPRightModel.h
//  IndianaSoldiers
//
//  Created by qy on 16/5/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYSHOPRightModel : NSObject

//夺宝进行中的Id
@property (nonatomic, strong) NSString *id;
//已参与人数
@property (nonatomic, assign) NSInteger count;
//商品Id
@property(nonatomic,assign)NSInteger goodsId;
//商品名称
@property (nonatomic, strong) NSString *goodsName;
//商品类型
@property (nonatomic, strong) NSString *goodsTypeName;
//剩余次数
@property(nonatomic,assign)NSInteger lastCount;
//商品图片路径
@property (nonatomic, strong) NSString *logoPath;
//最少购买次数
@property(nonatomic,assign)NSInteger minTimes;
//总需次数
@property(nonatomic,assign)NSInteger needs;
//当前期数
@property(nonatomic,assign)NSInteger times;
//开奖状态
@property(nonatomic,assign)NSInteger openStatus;


//额外增加的高度
@property (nonatomic, assign) NSInteger imgeHeight;
@end
