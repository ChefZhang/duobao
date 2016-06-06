//
//  PersonNicknameController.h
//  IndianaSoldiers
//
//  Created by leo on 16/5/15.
//  Copyright © 2016年 qy. All rights reserved.
//

#import <UIKit/UIKit.h>



@class PersonNicknameController;
@protocol PersonNicknameControllerDelegate <NSObject>

@optional
// 设计方法:想要代理做什么事情
- (void)nickNameViewController:(PersonNicknameController *)NicknamelVc sendValue:(NSString *)name;
@end


@interface PersonNicknameController : UIViewController

@property (nonatomic, weak) id<PersonNicknameControllerDelegate> delegate;

@end
