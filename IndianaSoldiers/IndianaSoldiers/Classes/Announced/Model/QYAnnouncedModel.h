//
//  QYAnnouncedModel.h
//  IndianaSoldiers
//
//  Created by qy on 16/5/12.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYAnnouncedModel : NSObject

@property (nonatomic, strong) NSString *address;
@property(nonatomic,assign)NSInteger goodsId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *goodsTypeName;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *logoPath;
@property(nonatomic,assign)NSInteger luckyNo;
@property (nonatomic, assign) NSInteger openStatus;
@property (nonatomic, strong) NSString *openTime;
@property(nonatomic,assign)NSInteger otherId;
@property(nonatomic,assign)NSInteger otherName;
@property(nonatomic,assign)NSInteger otherTimes;
@property (nonatomic, strong) NSString *prizeTime;
@property (nonatomic, strong) NSString *time;
@property(nonatomic,assign)NSInteger times;
@property (nonatomic, strong) NSString *userLogoPath;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *lastNedds;
@end
