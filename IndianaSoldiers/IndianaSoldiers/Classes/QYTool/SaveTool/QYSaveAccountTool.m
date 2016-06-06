//
//  QYSaveAccountTool.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYSaveAccountTool.h"

@implementation QYSaveAccountTool

+ (nullable id)objectForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName{
    
    if (defaultName) {
        // 屏蔽一下外界的sb行为
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
