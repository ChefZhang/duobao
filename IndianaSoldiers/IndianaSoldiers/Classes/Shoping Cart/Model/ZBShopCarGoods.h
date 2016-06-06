//
//  ZBShopCarGoods.h
//  IndianaSoldiers
//
//  Created by leo on 16/5/14.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBShopCarGoods : NSObject



@property(nonatomic,assign)NSInteger      amount;
@property (nonatomic, strong) NSString   *goodsName;
@property(nonatomic,assign)NSInteger     id;
@property(nonatomic,assign)NSInteger     lastNeeds;
@property (nonatomic, strong) NSString  *logoPath;
@property(nonatomic,assign)NSInteger      minTimes;
@property(nonatomic,assign)NSInteger      needs;
@property(nonatomic,assign)NSInteger      goodsId;
@property(nonatomic,assign)NSInteger      processingId;

@end
