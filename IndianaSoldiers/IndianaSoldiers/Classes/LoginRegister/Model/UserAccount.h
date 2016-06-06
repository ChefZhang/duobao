//
//  UserAccount.h
//  IndianaSoldiers
//
//  Created by qy on 16/5/11.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

@interface UserAccount : NSObject<NSCoding>

//地址
@property (nonatomic, strong) NSString *address;
//市
@property (nonatomic, strong) NSString *city;
//创建时间
@property (nonatomic, strong) NSString *createTime;
//夺宝币
@property (nonatomic, assign) NSInteger currency;
//区
@property (nonatomic, strong) NSString *district;
//用户id
@property (nonatomic, strong) NSString *id;
//积分
@property (nonatomic, assign) NSInteger integral;
//头像
@property (nonatomic, strong) NSString *logoPath;
//昵称
@property (nonatomic, strong) NSString *nickName;
//省
@property (nonatomic, strong) NSString *province;
//密码
@property (nonatomic, strong) NSString *pwd;
//状态
@property (nonatomic, assign) NSInteger status;
//总充值金额
@property (nonatomic, assign) NSInteger totalMoney;
//用户名
@property (nonatomic, strong) NSString *userName;

SingleH(UserAccount)

@end
