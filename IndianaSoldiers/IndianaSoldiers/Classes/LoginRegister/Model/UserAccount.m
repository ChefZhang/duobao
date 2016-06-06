//
//  UserAccount.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/11.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "UserAccount.h"

@implementation UserAccount

SingleM(UserAccount)
//在保存对象时告诉要保存当前对象哪些属性.
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeInteger:self.integral forKey:@"integral"];
    [aCoder encodeObject:self.logoPath forKey:@"logoPath"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeInteger:self.status forKey:@"status"];
    [aCoder encodeInteger:self.totalMoney forKey:@"totalMoney"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
     [aCoder encodeObject:self.id forKey:@"id"];
    
}

//当解析一个文件的时候调用.(告诉当前要解析文件当中哪些属性.)
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    //当只有遵守了NSCoding协议时,才有[super initWithCoder]
    if (self = [super init]) {
        
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.integral = [aDecoder decodeIntegerForKey:@"integral"];
        self.logoPath = [aDecoder decodeObjectForKey:@"logoPath"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.status = [aDecoder decodeIntegerForKey:@"status"];
        self.totalMoney = [aDecoder decodeIntegerForKey:@"totalMoney"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        
    }
    return self;
}
@end
